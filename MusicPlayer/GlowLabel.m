//
//  GlowLabel.m
//  GlowLabel
//
//  Created by Bill on 12-9-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GlowLabel.h"

@implementation GlowLabel

@synthesize redValue;
@synthesize greenValue;
@synthesize blueValue;
@synthesize size;

-(id) initWithFrame: (CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        redValue = 1.0f;
        greenValue = 1.0f;
        blueValue = 1.0f;
        size=3.0f;
    }
    return self;
}

-(void) drawTextInRect: (CGRect)rect {
	CGSize textShadowOffest = CGSizeMake(0, 0);
	float textColorValues[] = {redValue, greenValue, blueValue, 1.0};
	
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSaveGState(ctx);
	
	CGContextSetShadow(ctx, textShadowOffest, size);
	CGColorSpaceRef textColorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef textColor = CGColorCreate(textColorSpace, textColorValues);
	CGContextSetShadowWithColor(ctx, textShadowOffest, size, textColor);
	
	[super drawTextInRect:rect];
	
	CGColorRelease(textColor);
	CGColorSpaceRelease(textColorSpace);
	
	CGContextRestoreGState(ctx);
}


@end
