//
//  VRTestViewManager.swift
//  VRDemo
//
//  Created by Christian Schlensker on 1/21/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import Foundation

@objc(VRTestViewManager)
class VRTestViewManager : RCTViewManager {
  override func view() -> UIView! {
    return VRTestView();
  }
}
