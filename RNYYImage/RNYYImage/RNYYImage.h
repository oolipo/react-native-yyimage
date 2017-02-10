//
//  RNYYImage.h
//  RNYYImage
//
//  Created by Marcin Pawlowski on 09/02/17.
//  Copyright © 2017 Netbulls. All rights reserved.
//

#import "RCTView.h"
#import "RNYYImage.h"

@class RNYYImage;

@interface RNYYImage : UIView

@property (nonatomic, copy) NSString *src;
@property (nonatomic, assign) NSNumber *contentMode;
@property (nonatomic, copy) RCTDirectEventBlock onLoadEnd;

@end
