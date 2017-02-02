//
//  VRViewModule.m
//  VRDemo
//
//  Created by Christian Schlensker on 1/21/17.
//  Copyright © 2017 Christian Schlensker. All rights reserved.
//


#import <React/RCTBridgeModule.h>
#import <React/RCTViewManager.h>
#import <React/RCTConvert.h>
#import <React/UIView+React.h>
#import <SceneKit/SceneKit.h>
#import "VRDemo-Swift.h"



@implementation RCTConvert(VRNodeView)

+ (SCNVector3)SCNVector3:(id)json
{
  return (SCNVector3){
    [self CGFloat:json[@"x"]],
    [self CGFloat:json[@"y"]],
    [self CGFloat:json[@"z"]],
  };
}

+ (SCNVector3)EulerAngles:(id)json
{
  return (SCNVector3){
    [self CGFloat:json[@"x"]],
    [self CGFloat:json[@"y"]],
    [self CGFloat:json[@"z"]],
  };
}

@end



# pragma mark - VRViewManager

@interface VRViewManager : RCTViewManager
@end

@implementation VRViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
  return [[VRView alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(showRealWorld, BOOL)
RCT_EXPORT_VIEW_PROPERTY(bgSrc, NSString)
RCT_EXPORT_VIEW_PROPERTY(bgColor, UIColor)
@end

# pragma mark - VRNodeViewManager

@interface VRNodeViewManager : RCTViewManager
- (VRNodeView *)node;
@end

@interface VRNodeViewManager() <VRHitDelegate>
@end

@implementation VRNodeViewManager

RCT_EXPORT_MODULE()

- (VRNodeView *)node {
  return [[VRNodeView alloc] init];
}

- (UIView *)view
{
  VRNodeView *nodeView = [self node];
  nodeView.hitDelegate = self;
  return nodeView;
}

- (void)hitStartWithNodeView:(VRNodeView *)nodeView {
  if (nodeView.onHitStart) {
    nodeView.onHitStart(@{});
  }
}

- (void)hitEndWithNodeView:(VRNodeView *)nodeView {
  if (nodeView.onHitEnd) {
    nodeView.onHitEnd(@{});
  }
}


RCT_EXPORT_VIEW_PROPERTY(rotation, SCNVector3)
RCT_EXPORT_VIEW_PROPERTY(scale, SCNVector3)
RCT_EXPORT_VIEW_PROPERTY(nodePosition, SCNVector3)
RCT_EXPORT_VIEW_PROPERTY(onHitStart, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onHitEnd, RCTBubblingEventBlock)

@end

# pragma mark - VRVideo360ViewManager

@interface VRVideo360ViewManager : RCTViewManager
@end

@implementation VRVideo360ViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
  return [[VRVideo360View alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(src, NSString)
@end

# pragma mark - VRSphereViewManager

@interface VRSphereViewManager : RCTViewManager
@end

@implementation VRSphereViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
  return [[VRSphereView alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(radius, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(color, UIColor)
RCT_EXPORT_VIEW_PROPERTY(textureSrc, NSString)
@end


# pragma mark - VRPlaneViewManager

@interface VRPlaneViewManager : RCTViewManager
@end

@implementation VRPlaneViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
  return [[VRPlaneView alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(color, UIColor)
RCT_EXPORT_VIEW_PROPERTY(textureSrc, NSString)
RCT_EXPORT_VIEW_PROPERTY(width, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(height, CGFloat)
@end

# pragma mark - VRBoxViewManager

@interface VRBoxViewManager : RCTViewManager
@end

@implementation VRBoxViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
  return [[VRBoxView alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(color, UIColor)
RCT_EXPORT_VIEW_PROPERTY(textureSrc, NSString)
RCT_EXPORT_VIEW_PROPERTY(width, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(height, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(length, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(borderRadius, CGFloat)
@end


# pragma mark - VRFloorViewManager

@interface VRFloorViewManager : RCTViewManager
@end

@implementation VRFloorViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
    return [[VRFloorView alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(color, UIColor)
RCT_EXPORT_VIEW_PROPERTY(textureSrc, NSString)
RCT_EXPORT_VIEW_PROPERTY(reflectivity, CGFloat)
@end

# pragma mark - VRTextViewManager

@interface VRTextViewManager : RCTViewManager
@end

@implementation VRTextViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
  return [[VRTextView alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(color, UIColor)
RCT_EXPORT_VIEW_PROPERTY(textureSrc, NSString)
RCT_EXPORT_VIEW_PROPERTY(value, NSString)
RCT_EXPORT_VIEW_PROPERTY(fontSize, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(truncation, NSString)
RCT_EXPORT_VIEW_PROPERTY(alignment, NSString)
@end


