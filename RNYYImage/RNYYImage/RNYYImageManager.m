//
//  RNYYImageManager.m
//  RNYYImage
//

#import <Foundation/Foundation.h>
#import <React/RCTUIManager.h>
#import <React/UIView+React.h>
#import "RNYYImageManager.h"
#import "RNYYImage.h"
#import "YYImage.h"

@implementation RNYYImageManager

RCT_EXPORT_MODULE();

@synthesize bridge = _bridge;

- (UIView *)view
{
    RNYYImage *animatedImage = [RNYYImage new];
    return animatedImage;
}

- (dispatch_queue_t) methodQueue{
    return dispatch_get_main_queue();
}

RCT_EXPORT_VIEW_PROPERTY(src, NSString);
RCT_EXPORT_VIEW_PROPERTY(contentMode, NSInteger);
RCT_EXPORT_VIEW_PROPERTY(onLoadEnd, RCTDirectEventBlock)


- (NSDictionary *) constantsToExport {
    return @{
             @"ScaleAspectFit": @(UIViewContentModeScaleAspectFit),
             @"ScaleAspectFill": @(UIViewContentModeScaleAspectFill),
             @"ScaleToFill": @(UIViewContentModeScaleToFill)
             };
}

RCT_EXPORT_METHOD(getSize:(NSString *)uri success:(RCTResponseSenderBlock)success failure:(RCTResponseSenderBlock)failure){
    NSData *_imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:uri]];
    
    if(_imageData == nil) {
        _imageData = [NSData dataWithContentsOfFile:[NSURL URLWithString:uri]];
    }
    YYImageDecoder *decoder = [YYImageDecoder decoderWithData:_imageData scale:1.0];
    NSDictionary *size = nil;
    if(decoder != nil)
        success(@[[NSNumber numberWithInteger:decoder.width],[NSNumber numberWithInteger:decoder.height]]);
    else
        failure(@[[NSString stringWithFormat:@"Cannot get size of file: %@", uri]]);
}

@end
