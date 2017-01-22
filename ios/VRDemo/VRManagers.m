//
//  VRViewModule.m
//  VRDemo
//
//  Created by Christian Schlensker on 1/21/17.
//  Copyright © 2017 Christian Schlensker. All rights reserved.
//


#import <React/RCTBridgeModule.h>
#import <React/RCTViewManager.h>
#import "VRDemo-Swift.h"


@interface VRViewManager : RCTViewManager
@end

@implementation VRViewManager
RCT_EXPORT_MODULE()

- (UIView *) view {
  return [[VRView alloc] init];
}
@end
