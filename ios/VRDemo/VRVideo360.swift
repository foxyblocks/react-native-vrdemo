//
//  VRVideo360.swift
//  VRDemo
//
//  Created by Christian Schlensker on 1/21/17.
//

import Foundation
import SceneKit
import SpriteKit
import AVFoundation


class VRVideo360 {
  
  var node : SCNNode
  var player : AVPlayer
  
  
  init(url: URL) {
    // Create video
    let sphere = SCNSphere(radius: 2)
    self.node = SCNNode(geometry: sphere)
    
    // we need to rotate the node 180 degrees because textures are upside down on the inside of geometry
    node.eulerAngles = SCNVector3Make(0, 0, degreesToRadians(180.0))
    
    self.player = AVPlayer(url: url)
    
    // pick an arbitrary size
    let videoSize = CGSize(width: 2000, height: 2000)
    
    // Video node
    let videoNode = SKVideoNode(avPlayer: player)
    let spritescene = SKScene(size: videoSize)
    videoNode.position = CGPoint(x: spritescene.size.width/2, y: spritescene.size.height/2)
    videoNode.size = videoSize
    spritescene.addChild(videoNode)
    
    // assign SKScene-embedded video to sphere geometry material
    sphere.firstMaterial?.diffuse.contents = spritescene
    sphere.firstMaterial?.cullMode = SCNCullMode.front
    
  }
}
