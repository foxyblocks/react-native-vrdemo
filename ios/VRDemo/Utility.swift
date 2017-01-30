//
//  Utility.swift
//  VRDemo
//
//  Created by Christian Schlensker on 1/30/17.
//  Copyright © 2017 Christian Schlensker. All rights reserved.
//

import Foundation


func degreesToRadians(_ degrees: Float) -> Float {
  return (degrees * Float(M_PI)) / 180.0
}

func radiansToDegrees(_ radians: Float) -> Float {
  return (180.0/Float(M_PI)) * radians
}

func isSimulator() -> Bool {
  return ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil
}
