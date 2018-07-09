//
//  VRTextView.swift
//  VRDemo
//
//  Created by Christian Schlensker on 1/30/17.
//  Copyright © 2017 Christian Schlensker. All rights reserved.
//

import Foundation
import SceneKit

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
