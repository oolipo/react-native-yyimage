//
//  RNYYImage.m
//  RNYYImage
//

#import <Foundation/Foundation.h>
#import <ImageIO/ImageIO.h>

#import "YYImage.h"
#import "RNYYImage.h"

#import <React/RCTLog.h>
#import "RCTImageUtils.h"


@implementation RNYYImage {
    YYImage *_image;
    YYAnimatedImageView *_imageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if((self = [super initWithFrame:frame])){
        _imageView = [[YYAnimatedImageView alloc] init];
    }
    return self;
}

RCT_NOT_IMPLEMENTED(- (instancetype)initWithCoder:(NSCoder *)aDecoder)

- (void)layoutSubviews
{
    _imageView.frame = self.bounds;
    [self addSubview:_imageView];
}

- (void)setSrc:(NSString *)src
{
    if (![src isEqual:_src]) {
        _src = [src copy];
        [self reloadImage];
    }
}

- (void)setContentMode:(NSNumber *)contentMode
{
    if(![contentMode isEqual:_contentMode]) {
        _contentMode = contentMode;
        [self reloadImage];
    }
}

-(void)reloadImage {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    	if(_src == nil)
        	return;
        NSData *_imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_src]];
        
        if(_imageData == nil) {
            _imageData = [NSData dataWithContentsOfFile:[NSURL URLWithString:_src]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *meta = RCTGetImageMetadata(_imageData);
            CGSize size = (CGSize) {
                [meta[(id)kCGImagePropertyPixelWidth] doubleValue],
                [meta[(id)kCGImagePropertyPixelHeight] doubleValue],
            };
            
            if(_onLoadEnd) {
                _onLoadEnd(@{
                             @"size":@{
                                     @"width": @(size.width),
                                     @"height": @(size.height),
                                     }
                             });
            }
            
            _image = [YYImage imageWithData:_imageData];
            [_imageView removeFromSuperview];
            _imageView = [[YYAnimatedImageView alloc] initWithImage:_image];
            _imageView.contentMode = [_contentMode integerValue];
            [self addSubview:_imageView];
            
        });
    });
}

@end
