//
//  VRSphereView.swift
//  VRDemo
//
//  Created by Christian Schlensker on 1/30/17.
//  Copyright © 2017 Christian Schlensker. All rights reserved.
//

import Foundation
import SceneKit

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
