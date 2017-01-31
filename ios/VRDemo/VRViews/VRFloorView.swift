//
//  VRFloorView.swift
//  VRDemo
//
//  Created by Christian Schlensker on 1/30/17.
//  Copyright © 2017 Christian Schlensker. All rights reserved.
//

import Foundation
import SceneKit

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
