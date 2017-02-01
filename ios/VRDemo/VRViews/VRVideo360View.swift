//
//  VRVideo360View.swift
//  VRDemo
//
//  Created by Christian Schlensker on 1/30/17.
//  Copyright © 2017 Christian Schlensker. All rights reserved.
//

import Foundation
import AVFoundation
import SceneKit
import SpriteKit

class VRVideo360View : VRNodeView {
  let spriteScene = SKScene()
  var player : AVPlayer?
      // pick an arbitrary size
  var videoSize = CGSize(width: 2000, height: 2000)
  
  
  var src : String {
    get {
      return ""
    }
    set {
      player = AVPlayer(url: URL(string: newValue)!)
      let videoNode = SKVideoNode(avPlayer: player!)
      videoNode.position = CGPoint(x: spriteScene.size.width/2, y: spriteScene.size.height/2)
      videoNode.size = videoSize
      spriteScene.removeAllChildren()
      spriteScene.addChild(videoNode)
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    let sphere = SCNSphere(radius: 10)
    self.node.geometry = sphere
    
    // we need to rotate the node 180 degrees because textures are upside down on the inside of geometry
    node.eulerAngles = SCNVector3Make(0, 0, degreesToRadians(180.0))
    
    spriteScene.size = videoSize
    
    // assign SKScene-embedded video to sphere geometry material
    sphere.firstMaterial?.diffuse.contents = spriteScene
    sphere.firstMaterial?.cullMode = SCNCullMode.front
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
