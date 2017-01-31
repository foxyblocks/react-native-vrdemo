//
//  VRPlaneView.swift
//  VRDemo
//
//  Created by Christian Schlensker on 1/30/17.
//  Copyright © 2017 Christian Schlensker. All rights reserved.
//

import Foundation
import SceneKit

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
