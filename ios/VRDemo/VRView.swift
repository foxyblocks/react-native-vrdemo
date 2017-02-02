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


class VRView: UIView, SCNSceneRendererDelegate {
  var bgColor : UIColor? {
    get {
      return UIColor.clear
    }
    
    set {
      scene.background.contents = newValue
    }
  }
  
  var bgSrc: String? {
    get {
      return ""
    }
    
    set {
      scene.background.contents = newValue
    }
  }
  
  var showRealWorld : Bool {
    get {
      return (cameraPreview?.isRunning)!
    }
    
    set {
      if newValue == true {
        cameraPreview?.start()
        leftSceneView.addSubview(cameraPreview!)
      } else {
        cameraPreview?.stop()
        cameraPreview!.removeFromSuperview()
      }
    }
  };

  var contentNode : SCNNode!
  var hudNode : SCNNode!
  
  private var scene : SCNScene!
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
  private var hitNode : VRNodeView?
  private var nodeViewMap = NSMapTable<SCNNode, VRNodeView>(keyOptions: NSMapTableStrongMemory, valueOptions: NSMapTableStrongMemory)
  
  
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
    scene = SCNScene()
    
    leftSceneView.scene = scene
    rightSceneView.scene = scene
    
    // Create cameras
    let leftCameraNode = SCNNode()
    leftCameraNode.camera = SCNCamera()
    leftCameraNode.position = SCNVector3(x: -0.5, y: 0.0, z: 0.0)
    
    let rightCameraNode = SCNNode()
    rightCameraNode.camera = SCNCamera()
    rightCameraNode.position = SCNVector3(x: 0.5, y: 0.0, z: 0.0)
    
    // setup camerasNode
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
    
    cameraPreview = CameraPreviewView(frame: CGRect.zero)
    
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
    
    doHitTest()
  }
  
  
  func trackNodeView(nodeView: VRNodeView) {
    nodeView.vrView = self
    nodeViewMap.setObject(nodeView, forKey: nodeView.node)
  }
  
  func unTrackNodeView(nodeView: VRNodeView) {
    nodeViewMap.removeObject(forKey: nodeView.node)
  }
  
  func doHitTest() {
    let from = SCNVector3Zero
    let to = SCNVector3(x: 0, y: 0, z: -1000)
    let newFrom = self.contentNode.convertPosition(from, from: self.hudNode)
    let newTo = self.contentNode.convertPosition(to, from: self.hudNode)
    
    let hits = self.contentNode.hitTestWithSegment(from: newFrom, to: newTo, options: nil)
    
    if let firstItem = hits.first {
      if let nodeView = nodeViewMap.object(forKey: firstItem.node) {
        if hitNode !== nodeView {
          hitNode?.hitEnd()
          hitNode = nodeView
          nodeView.hitStart()
        }
      }
    }
    
    if hits.isEmpty {
      hitNode?.hitEnd()
      hitNode = nil
    }
  }
  
  override func layoutSubviews() {
    
    super.layoutSubviews()
    
  
    leftSceneView.frame = CGRect(x: 0, y: 0, width: frame.width / 2, height: frame.height)
    rightSceneView.frame = CGRect(x: frame.width / 2, y: 0, width: frame.width / 2, height: frame.height)
    
    cameraPreview?.frame = leftSceneView.frame
    
  }
  
  // MARK: React subviews
  override func insertReactSubview(_ subview: UIView!, at atIndex: Int) {
    print("insertReactSubview")
    if let nodeView = subview as? VRNodeView {
      self.contentNode.addChildNode(nodeView.node)
      nodeView.addedToVRView(vrView: self)
    }
    super.insertReactSubview(subview, at: atIndex)
  }
  
  override func removeReactSubview(_ subview: UIView!) {
     if let nodeView = subview as? VRNodeView {
      nodeView.node.removeFromParentNode()
      self.unTrackNodeView(nodeView: nodeView)
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
      
      doHitTest()
    }
    
  }

}
