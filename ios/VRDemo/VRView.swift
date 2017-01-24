//
//  VRView.swift
//  VRDemo
//
//  Created by Christian Schlensker on 1/21/17.
//  Copyright © 2017 Christian Schlensker. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit
import AVFoundation
import CoreMotion

func degreesToRadians(_ degrees: Float) -> Float {
  return (degrees * Float(M_PI)) / 180.0
}

func radiansToDegrees(_ radians: Float) -> Float {
  return (180.0/Float(M_PI)) * radians
}

class VRNodeView : UIView {
  var node = SCNNode()
  var vrView : VRView?
  
  var position : SCNVector3 {
    get {
      return node.position
    }
    
    set {
      node.position = newValue;
    }
  }
  
  var rotation : SCNVector3 {
    get {
      return node.eulerAngles
    }
    
    set {
      node.eulerAngles = newValue;
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: React subviews
  override func insertReactSubview(_ subview: UIView!, at atIndex: Int) {
    if let nodeView = subview as? VRNodeView {
      self.node.addChildNode(nodeView.node)
      nodeView.vrView = self.vrView
    }

    super.insertReactSubview(subview, at: atIndex)
  }
  
  override func removeReactSubview(_ subview: UIView!) {
    if subview is VRNodeView {
      (subview as! VRNodeView).node.removeFromParentNode()
    }
    
    super.removeReactSubview(subview)
  }
}

class VRSphereView : VRNodeView {
  
  private let geometry = SCNSphere(radius: 0)
  
  var radius : CGFloat {
    get {
      return geometry.radius
    }
    
    set {
      geometry.radius = newValue
    }
  }
  
  var color : UIColor {
    get {
      return geometry.firstMaterial?.diffuse.contents as! UIColor
    }
    
    set {
      geometry.firstMaterial?.diffuse.contents = newValue
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let material = SCNMaterial()
    material.diffuse.contents = UIColor.white
    material.specular.contents = UIColor.white
    material.shininess = 1.0
    geometry.materials = [ material ]
    self.node.geometry = geometry
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class VRPlaneView : VRNodeView {
  
  private let geometry = SCNPlane(width: 1, height: 1)
  
  var width : CGFloat {
    get {
      return geometry.width
    }
    
    set {
      geometry.width = newValue
    }
  }
  
  var height : CGFloat {
    get {
      return geometry.height
    }
    
    set {
      geometry.height = newValue
    }
  }
  
  var color : UIColor {
    get {
      return geometry.firstMaterial?.diffuse.contents as! UIColor
    }
    
    set {
      geometry.firstMaterial?.diffuse.contents = newValue
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let material = SCNMaterial()
    material.diffuse.contents = UIColor.white
    material.specular.contents = UIColor.white
    material.shininess = 1.0
    material.isDoubleSided = true
    geometry.materials = [ material ]
    self.node.geometry = geometry
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


class VRView: UIView, SCNSceneRendererDelegate {
  
  private var leftSceneView : SCNView!
  private var rightSceneView : SCNView!
  
  private var motionManager : CMMotionManager?
  private let cameraRollNode = SCNNode()
  private let cameraPitchNode = SCNNode()
  private let cameraYawNode = SCNNode()

  var contentNode : SCNNode!
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)

    leftSceneView = SCNView(frame: CGRect.zero)
    rightSceneView = SCNView(frame: CGRect.zero)

    
    self.addSubview(leftSceneView)
    self.addSubview(rightSceneView)
    
    leftSceneView.backgroundColor = UIColor.black
    rightSceneView.backgroundColor = UIColor.black
    
    // Create Scene
    let scene = SCNScene()
    
    leftSceneView.scene = scene
    rightSceneView.scene = scene
    
    // Create cameras
    let leftCameraNode = SCNNode()
    leftCameraNode.camera = SCNCamera()
    leftCameraNode.position = SCNVector3(x: -0.5, y: 0.0, z: 0.0)
    
    let rightCameraNode = SCNNode()
    rightCameraNode.camera = SCNCamera()
    rightCameraNode.position = SCNVector3(x: 0.5, y: 0.0, z: 0.0)
    
    let camerasNode = SCNNode()
    camerasNode.position = SCNVector3(x: 0.0, y:0.0, z:0.0)
    camerasNode.addChildNode(leftCameraNode)
    camerasNode.addChildNode(rightCameraNode)
    
    // The user will be holding their device up (i.e. 90 degrees roll from a flat orientation)
    // so roll the cameras by -90 degrees to orient the view correctly.
    camerasNode.eulerAngles = SCNVector3Make(degreesToRadians(-90.0), 0, 0)
    
    cameraRollNode.addChildNode(camerasNode)
    cameraPitchNode.addChildNode(cameraRollNode)
    cameraYawNode.addChildNode(cameraPitchNode)
    
    scene.rootNode.addChildNode(cameraYawNode)
    leftSceneView.pointOfView = leftCameraNode
    rightSceneView.pointOfView = rightCameraNode

    
    // Respond to user head movement
    motionManager = CMMotionManager()
    motionManager?.deviceMotionUpdateInterval = 1.0 / 60.0
    motionManager?.startDeviceMotionUpdates(using: CMAttitudeReferenceFrame.xArbitraryZVertical)
    
    leftSceneView?.delegate = self
    leftSceneView.isPlaying = true
    rightSceneView.isPlaying = true
    
    
    contentNode = SCNNode()
    scene.rootNode.addChildNode(contentNode)

    self.setNeedsLayout()
  }
  
  func renderer(_ aRenderer: SCNSceneRenderer, updateAtTime time: TimeInterval)
  {
    if let mm = motionManager, let motion = mm.deviceMotion {
      let currentAttitude = motion.attitude
      
      cameraRollNode.eulerAngles.x = Float(currentAttitude.roll)
      cameraPitchNode.eulerAngles.z = Float(currentAttitude.pitch)
      cameraYawNode.eulerAngles.y = Float(currentAttitude.yaw)
    }
  }
  
  override func layoutSubviews() {
    
    super.layoutSubviews()
    
  
    leftSceneView.frame = CGRect(x: 0, y: 0, width: frame.width / 2, height: frame.height)
    rightSceneView.frame = CGRect(x: frame.width / 2, y: 0, width: frame.width / 2, height: frame.height)
    
  }
  
  // MARK: React subviews
  override func insertReactSubview(_ subview: UIView!, at atIndex: Int) {
    print("SUBVIEWS ADDED", type(of: subview))
    if let nodeView = subview as? VRNodeView {
      self.contentNode.addChildNode(nodeView.node)
      nodeView.vrView = self
    }
    super.insertReactSubview(subview, at: atIndex)
  }
  
  override func removeReactSubview(_ subview: UIView!) {
     if let nodeView = subview as? VRNodeView {
      nodeView.node.removeFromParentNode()
    }
    
    super.removeReactSubview(subview)
  }

}
