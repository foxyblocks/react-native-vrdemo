//
//  VRBoxView.swift
//  VRDemo
//
//  Created by Christian Schlensker on 1/30/17.
//  Copyright © 2017 Christian Schlensker. All rights reserved.
//

import Foundation
import SceneKit

class VRBoxView : VRShapeView {
  
  
  var width : CGFloat {
    get {
      return (geometry as! SCNBox).width
    }
    
    set {
      (geometry as! SCNBox).width = newValue
    }
  }
  
  var height : CGFloat {
    get {
      return (geometry as! SCNBox).height
    }
    
    set {
      (geometry as! SCNBox).height = newValue
    }
  }
  
  var length : CGFloat {
    get {
      return (geometry as! SCNBox).length
    }
    
    set {
      (geometry as! SCNBox).length = newValue
    }
  }
  
  var borderRadius : CGFloat {
    get {
      return (geometry as! SCNBox).chamferRadius
    }
    
    set {
      (geometry as! SCNBox).chamferRadius = newValue
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  override func makeGeometry() -> SCNGeometry {
    return SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
