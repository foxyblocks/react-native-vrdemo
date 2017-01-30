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
    }
  }
  
  var textSize : CGFloat {
    get {
      return (geometry as! SCNText).font.pointSize
    }
    
    set {
      if let text = geometry as? SCNText {
        text.font = text.font.withSize(newValue)
      }
    }
  }
  
  var truncationMode : String {
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
      }
    }
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

