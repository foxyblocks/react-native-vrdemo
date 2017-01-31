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
  }
  
  func makeGeometry() -> SCNGeometry {
    return SCNGeometry()
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK: VRSPhereView

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

// MARK: VRFloorView

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

// MARK: VRTextView

class VRTextView : VRShapeView {
  
  var value : String? {
    get {
      return (geometry as! SCNText).string as! String?
    }
    
    set {
      (geometry as! SCNText).string = newValue
      centerPivot()
    }
  }
  
  var fontSize : CGFloat {
    get {
      return (geometry as! SCNText).font.pointSize
    }
    
    set {
      if let text = geometry as? SCNText {
        text.font = text.font.withSize(newValue)
        centerPivot()
      }
    }
  }
  
  var truncation : String {
    get {
      switch (geometry as! SCNText).truncationMode {
      case kCATruncationNone:
        return "none"
      case kCATruncationStart:
        return "start"
      case kCATruncationMiddle:
        return "middle"
      case kCATruncationEnd:
        return "end"
      default:
        return "none"
      }
    }
    
    set {
      if let text = geometry as? SCNText {
        switch newValue {
        case "none":
          text.truncationMode = kCATruncationNone
        case "start":
          text.truncationMode = kCATruncationStart
        case "middle":
          text.truncationMode = kCATruncationMiddle
        case "end":
          text.truncationMode = kCATruncationEnd
        default:
          text.truncationMode = kCATruncationNone
        }
        
        centerPivot()
      }
    }
  }
  
  var alignment : String {
    get {
      switch (geometry as! SCNText).alignmentMode {
      case kCAAlignmentLeft:
        return "left"
      case kCAAlignmentCenter:
        return "center"
      case kCAAlignmentRight:
        return "right"
      case kCAAlignmentJustified:
        return "justified"
      case kCAAlignmentNatural:
        return "natural"
      default:
        return "natural"
      }
    }
    
    set {
      if let text = geometry as? SCNText {
        switch newValue {
        case "left":
          text.alignmentMode = kCAAlignmentLeft
        case "center":
          text.alignmentMode = kCAAlignmentCenter
        case "right":
          text.alignmentMode = kCAAlignmentRight
        case "justified":
          text.alignmentMode = kCAAlignmentJustified
        case "natural":
          text.alignmentMode = kCAAlignmentNatural
        default:
          text.alignmentMode = kCAAlignmentNatural
        }
        centerPivot()
      }
    }
  }
  
  func centerPivot() {
    let boundingBox = (geometry as! SCNText).boundingBox
    let min = boundingBox.min
    let max = boundingBox.max
    
    let bound = SCNVector3(
      x: max.x - min.x,
      y: max.y - min.y,
      z: max.z - min.z
    )
    
    node?.pivot = SCNMatrix4MakeTranslation(bound.x / 2, bound.y / 2, bound.z / 2)
  }
		
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  override func makeGeometry() -> SCNGeometry {
    return SCNText()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

