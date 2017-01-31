//
//  VRNode.swift
//  VRDemo
//
//  Created by Christian Schlensker on 1/29/17.
//  Copyright © 2017 Christian Schlensker. All rights reserved.
//

import Foundation
import SceneKit

@objc
protocol VRHitDelegate {
  func hitStart(nodeView: VRNodeView)
  func hitEnd(nodeView: VRNodeView)
}

class VRNodeView : UIView {
  var identifier = NSUUID().uuidString
  var node = SCNNode()
  var vrView : VRView?
  var hitDelegate : VRHitDelegate?
  var onHitStart : RCTBubblingEventBlock?
  var onHitEnd : RCTBubblingEventBlock?
  
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
  
  func hitStart() {
    hitDelegate?.hitStart(nodeView: self)
  }
  
  func hitEnd() {
    hitDelegate?.hitEnd(nodeView: self)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func addedToVRView(vrView: VRView) {
    vrView.trackNodeView(nodeView: self)
    if let rctSubviews = reactSubviews() {
      for childView in rctSubviews {
        if let childNodeView = childView as? VRNodeView {
          childNodeView.addedToVRView(vrView: vrView)
        }
      }
    }
  }
  
  // MARK: React subviews
  override func insertReactSubview(_ subview: UIView!, at atIndex: Int) {
    if let nodeView = subview as? VRNodeView {
      self.node.addChildNode(nodeView.node)
    }
    
    if let shapeView = subview as? VRShapeView {
      self.node.geometry = shapeView.geometry
      shapeView.node = self.node
    }
    
    if let shapeView = subview as? VRTextView {
      shapeView.centerPivot()
    }
    
    
    super.insertReactSubview(subview, at: atIndex)
  }
  
  override func removeReactSubview(_ subview: UIView!) {
    if let nodeView = subview as? VRNodeView {
      nodeView.node.removeFromParentNode()
      self.vrView?.unTrackNodeView(nodeView: nodeView)
    }
    
    super.removeReactSubview(subview)
  }
}
