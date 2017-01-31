//
//  VRShapeView.swift
//  VRDemo
//
//  Created by Christian Schlensker on 1/29/17.
//  Copyright © 2017 Christian Schlensker. All rights reserved.
//

import Foundation
import SceneKit

// MARK: VRShapeView

class VRShapeView : UIView {
  var node : SCNNode?
  var geometry : SCNGeometry?
  var colorMaterial : SCNMaterial?
  var imageMaterial : SCNMaterial?
  var color : UIColor {
    get {
      return geometry?.firstMaterial?.diffuse.contents as! UIColor
    }
    
    set {
      geometry?.firstMaterial?.diffuse.contents = newValue
    }
  }
  
  var textureSrc : String {
    get {
      return "";
    }
    set {
      imageMaterial?.diffuse.contents = newValue
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    geometry = makeGeometry();
    colorMaterial = SCNMaterial()
    colorMaterial?.diffuse.contents = UIColor.white
    colorMaterial?.shininess = 1.0
    
    imageMaterial = SCNMaterial()
    
    geometry?.materials = [ imageMaterial!, colorMaterial! ]
  }
  
  func makeGeometry() -> SCNGeometry {
    return SCNGeometry()
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


