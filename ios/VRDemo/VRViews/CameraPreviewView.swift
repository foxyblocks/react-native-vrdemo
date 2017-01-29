//
//  CameraPreviewView.swift
//  VRDemo
//
//  Created by Christian Schlensker on 1/22/17.
//  Copyright © 2017 Christian Schlensker. All rights reserved.
//

import UIKit
import AVFoundation

class CameraPreviewView: UIView {
  
  private var previewLayer : AVCaptureVideoPreviewLayer
  
  override init(frame: CGRect) {
    
    // Create capture session
    let captureSession = AVCaptureSession()
    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
    
    super.init(frame: frame)
    
    // try to load capture device
    if let videoDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) {
      
      do {
        // continue setup
        let videoIn = try AVCaptureDeviceInput.init(device: videoDevice)
        captureSession.addInput(videoIn as AVCaptureDeviceInput)
        
        captureSession.startRunning()
        
        self.layer.addSublayer(previewLayer)
        
        previewLayer.frame = frame
      } catch {
        print("Failed to capture video input")
      }
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func orient(orientation: AVCaptureVideoOrientation) {
    previewLayer.connection.videoOrientation = orientation
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    previewLayer.frame = self.bounds;
    
    // set orientation
    if let connection = self.previewLayer.connection  {

      if connection.isVideoOrientationSupported {
        switch (UIDevice.current.orientation) {
        case .portrait: orient(orientation: .portrait)
          break
        case .landscapeRight: orient(orientation: .landscapeLeft)
          break
        case .landscapeLeft: orient(orientation: .landscapeRight)
          break
        case .portraitUpsideDown: orient(orientation: .portraitUpsideDown)
          break
        default: orient(orientation: .portrait)
          break
        }
      }
    }
  }
}
