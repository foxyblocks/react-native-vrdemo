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

func isSimulator() -> Bool {
   return ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil
}

class VRNodeView : UIView {
  var node = SCNNode()
  var vrView : VRView?
  
  var nodePosition : SCNVector3 {
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
      node.eulerAngles.x = degreesToRadians(newValue.x);
      node.eulerAngles.y = degreesToRadians(newValue.y);
      node.eulerAngles.z = degreesToRadians(newValue.z);
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

class VRHudView : VRNodeView {
  
}

class VRShapeView : VRNodeView {
  var geometry : SCNGeometry?
  var color : UIColor {
    get {
      return geometry?.firstMaterial?.diffuse.contents as! UIColor
    }
    
    set {
      geometry?.firstMaterial?.diffuse.contents = newValue
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    geometry = makeGeometry();
    let material = SCNMaterial()
    material.diffuse.contents = UIColor.white
    material.specular.contents = UIColor.white
    material.shininess = 1.0
    
    geometry?.materials = [ material ]

    self.node.geometry = geometry
  }
  
  func makeGeometry() -> SCNGeometry {
    return SCNGeometry()
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

class VRSphereView : VRShapeView {
  
  
  var radius : CGFloat {
    get {
      return (geometry as! SCNSphere).radius
    }
    
    set {
      (geometry as! SCNSphere).radius = newValue
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  override func makeGeometry() -> SCNGeometry {
    return SCNSphere(radius: 0)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class VRPlaneView : VRShapeView {
  
  var width : CGFloat {
    get {
      return (geometry as! SCNPlane).width
    }
    
    set {
      (geometry as! SCNPlane).width = newValue
    }
  }
  
  var height : CGFloat {
    get {
      return (geometry as! SCNPlane).height
    }
    
    set {
      (geometry as! SCNPlane).height = newValue
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  override func makeGeometry() -> SCNGeometry {
    return SCNPlane(width: 1, height: 1)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class VRFloorView : VRShapeView {
  
  var reflectivity : CGFloat {
    get {
      return (geometry as! SCNFloor).reflectivity
    }
    
    set {
      (geometry as! SCNFloor).reflectivity = newValue
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  override func makeGeometry() -> SCNGeometry {
    return SCNFloor()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


class VRView: UIView, SCNSceneRendererDelegate {
  var contentNode : SCNNode!
  var hudNode : SCNNode!
  
  private var leftSceneView : SCNView!
  private var rightSceneView : SCNView!
  
  private var motionManager : CMMotionManager?
  private let cameraPitchNode = SCNNode()
  private let cameraRollNode = SCNNode()
  private let cameraYawNode = SCNNode()
  private let camerasNode = SCNNode()

  private var touchStartPoint : CGPoint?
  private var touchStartAngles : SCNVector3?
  private var cameraPreview : CameraPreviewView?
  
  
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
    
//    let camerasNode = SCNNode()
    camerasNode.position = SCNVector3Zero
    camerasNode.addChildNode(leftCameraNode)
    camerasNode.addChildNode(rightCameraNode)
    
    
    // Create hud node
    hudNode = SCNNode()
    hudNode.position = SCNVector3Zero
    hudNode.addChildNode(camerasNode)
    
    
    // The user will be holding their device up (i.e. 90 degrees roll from a flat orientation)
    // so roll the cameras by -90 degrees to orient the view correctly.
    if !isSimulator() {
//      hudNode.eulerAngles = SCNVector3(x: degreesToRadians(-180), y: 0, z: 0)
//      print("NOT SIMULATOR")
      hudNode.eulerAngles = SCNVector3(x: degreesToRadians(-90), y: 0, z: 0)
    }
    
    scene.rootNode.addChildNode(hudNode)
    leftSceneView.pointOfView = leftCameraNode
    rightSceneView.pointOfView = rightCameraNode

    
    // Respond to user head movement
    motionManager = CMMotionManager()
    motionManager?.deviceMotionUpdateInterval = 1.0 / 60.0
    motionManager?.startDeviceMotionUpdates(using: CMAttitudeReferenceFrame.xArbitraryZVertical)
    
    leftSceneView?.delegate = self
    rightSceneView?.delegate = self
    leftSceneView.isPlaying = true
    rightSceneView.isPlaying = true
    
    contentNode = SCNNode()
    scene.rootNode.addChildNode(contentNode)
    
//    let previewFrame = CGRect(origin: CGPoint.zero, size: CGSize(width: 300, height: 200))
//    cameraPreview = CameraPreviewView(frame: previewFrame)
//    leftSceneView.addSubview(cameraPreview!)

    self.setNeedsLayout()
  }
  
  func renderer(_ aRenderer: SCNSceneRenderer, updateAtTime time: TimeInterval)
  {
    if let mm = motionManager, let motion = mm.deviceMotion {
      let currentAttitude = motion.attitude
      var multiplier : Float
      
      switch UIDevice.current.orientation {
      case .landscapeLeft:
        multiplier = -1.0
      case .landscapeRight:
        multiplier = 1.0
      default:
        multiplier = 1.0
      }
      
      hudNode.eulerAngles.x = multiplier * Float(currentAttitude.roll) - degreesToRadians(90)
      hudNode.eulerAngles.z = multiplier * Float(currentAttitude.pitch)
      hudNode.eulerAngles.y = Float(currentAttitude.yaw)
    }
  }
  
  override func layoutSubviews() {
    
    super.layoutSubviews()
    
  
    leftSceneView.frame = CGRect(x: 0, y: 0, width: frame.width / 2, height: frame.height)
    rightSceneView.frame = CGRect(x: frame.width / 2, y: 0, width: frame.width / 2, height: frame.height)
    
  }
  
  // MARK: React subviews
  override func insertReactSubview(_ subview: UIView!, at atIndex: Int) {
    
    if let nodeView = subview as? VRHudView {
      print("HUD ADDED", type(of: subview))
      self.hudNode.addChildNode(nodeView.node)
      nodeView.vrView = self
    } else if let nodeView = subview as? VRNodeView {
      print("Content View ADDED", type(of: subview))
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
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if !isSimulator() {
      return
    }
    if let touch = touches.first {
        self.touchStartPoint = touch.location(in: self)
        self.touchStartAngles = hudNode.eulerAngles
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if !isSimulator() {
      return
    }
    if let touch = touches.first {
      let currentPoint = touch.location(in: self)
      let startPoint = self.touchStartPoint!
      let yDiff = startPoint.y - currentPoint.y
      let xDiff = startPoint.x - currentPoint.x
     
      hudNode.eulerAngles.x = touchStartAngles!.x + Float(yDiff) * 0.01
      hudNode.eulerAngles.y = touchStartAngles!.y + Float(xDiff) * 0.01
    }
    
  }

}
