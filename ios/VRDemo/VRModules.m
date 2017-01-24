//
//  VRViewModule.m
//  VRDemo
//
//  Created by Christian Schlensker on 1/21/17.
//  Copyright © 2017 Christian Schlensker. All rights reserved.
//


#import <React/RCTBridgeModule.h>
#import <React/RCTViewManager.h>
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

@end

# pragma mark - VRNodeViewManager

@interface VRNodeViewManager : RCTViewManager
- (VRNodeView *)node;
@end

@implementation VRNodeViewManager

RCT_EXPORT_MODULE()

- (VRNodeView *)node {
  return [[VRNodeView alloc] init];
}

- (UIView *)view
{
  return [self node];
}


- (RCTShadowView *)shadowView
{
  return nil;
}

RCT_CUSTOM_VIEW_PROPERTY(position, SCNVector3, VRNodeView) {
  [view setPosition:json ? [RCTConvert SCNVector3:json] : SCNVector3Zero];
}

RCT_CUSTOM_VIEW_PROPERTY(rotation, SCNVector3, VRNodeView) {
  [view setPosition:json ? [RCTConvert SCNVector3:json] : SCNVector3Zero];
}

@end

# pragma mark - VRSphereViewManager

@interface VRSphereViewManager : VRNodeViewManager
@end

@implementation VRSphereViewManager

RCT_EXPORT_MODULE()

- (VRNodeView *)node
{
  return [[VRSphereView alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(radius, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(color, UIColor)
@end

# pragma mark - VRPlaneViewManager

@interface VRPlaneViewManager : VRNodeViewManager
@end

@implementation VRPlaneViewManager

RCT_EXPORT_MODULE()

- (VRNodeView *)node
{
  return [[VRPlaneView alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(color, UIColor)
RCT_EXPORT_VIEW_PROPERTY(width, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(height, CGFloat)
@end


//@interface RCT_EXTERN_MODULE(VRViewManager, RCTViewManager)
////  RCT_EXTERN_METHOD(addNode:(NSDictionary *)coords)
//@end


//@interface RCT_EXTERN_MODULE(VRNodeManager, NSObject)
//RCT_EXTERN_METHOD(addNode:(NSDictionary *)coords)
//@end

//@interface VRNodeManager : NSObject <RCTBridgeModule>
//  
//@end
//
//@implementation VRNodeManager
//
//RCT_EXPORT_MODULE();
//
//RCT_EXPORT_METHOD(addNode:(NSDictionary *)coords)
//{
//  RCTLogInfo(@"Pretending to create an event %@ at %@", name, location);
//}
//
//@end
