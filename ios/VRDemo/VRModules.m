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



# pragma mark - VRView

@interface VRViewManager : RCTViewManager
@end

@implementation VRViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
  return [[VRView alloc] init];
}

@end

# pragma mark - VRNodeView

@interface VRNodeViewManager : RCTViewManager
@end

@implementation VRNodeViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
  return [[VRNodeView alloc] init];
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
