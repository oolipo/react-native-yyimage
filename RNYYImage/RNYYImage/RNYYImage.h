//
//  RNYYImage.h
//  RNYYImage
//

#import <React/RCTView.h>
#import "RNYYImage.h"

@class RNYYImage;

@interface RNYYImage : UIView

@property (nonatomic, copy) NSString *src;
@property (nonatomic, assign) NSInteger *contentMode;
@property (nonatomic, copy) RCTDirectEventBlock onLoadEnd;

@end
