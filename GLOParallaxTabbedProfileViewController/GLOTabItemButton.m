//
//  GLOTabItemButton.m
//  GLOParallaxTabbedProfileViewController
//
//  Created by Gabriel Otte on 8/17/15.
//  Copyright © 2015 Gabriel Otte. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "GLOTabItemButton.h"

#define HEIGHTOFPOPUPTRIANGLE 6.0
#define WIDTHOFPOPUPTRIANGLE 12.0

@implementation GLOTabItemButton

static const CGFloat borderRadius = 0;
static const CGFloat strokeWidth = 0;

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    [[UIColor whiteColor] setFill];  // changes are here
    UIRectFill(rect);
    
    CGRect currentFrame = self.bounds;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextClearRect(context,rect);
    CGContextTranslateCTM(context, 0.0f, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineWidth(context, strokeWidth);
    CGContextSetStrokeColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextSetFillColorWithColor(context, [self.backgroundColor CGColor]);
    
    // Draw and fill the bubble
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, borderRadius + strokeWidth , strokeWidth + HEIGHTOFPOPUPTRIANGLE);
    
    if (self.selected) {
        CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0f - WIDTHOFPOPUPTRIANGLE / 2.0f) , HEIGHTOFPOPUPTRIANGLE + strokeWidth);
        CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0f) , strokeWidth);
        CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0f + WIDTHOFPOPUPTRIANGLE / 2.0f) , HEIGHTOFPOPUPTRIANGLE + strokeWidth);
    }
    
    CGContextAddArcToPoint(context, currentFrame.size.width - strokeWidth, strokeWidth + HEIGHTOFPOPUPTRIANGLE, currentFrame.size.width - strokeWidth, currentFrame.size.height - strokeWidth, borderRadius - strokeWidth);
    CGContextAddArcToPoint(context, currentFrame.size.width - strokeWidth, currentFrame.size.height - strokeWidth, round(currentFrame.size.width / 2.0f + WIDTHOFPOPUPTRIANGLE / 2.0f) - strokeWidth , currentFrame.size.height - strokeWidth, borderRadius - strokeWidth);
    CGContextAddArcToPoint(context, strokeWidth , currentFrame.size.height - strokeWidth, strokeWidth , HEIGHTOFPOPUPTRIANGLE + strokeWidth , borderRadius - strokeWidth);
    CGContextAddArcToPoint(context, strokeWidth , strokeWidth + HEIGHTOFPOPUPTRIANGLE , currentFrame.size.width - strokeWidth, HEIGHTOFPOPUPTRIANGLE + strokeWidth , borderRadius - strokeWidth);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    // Draw a clipping path for the fill
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, borderRadius + strokeWidth, round((currentFrame.size.height + HEIGHTOFPOPUPTRIANGLE) * 0.50f));
    CGContextAddArcToPoint(context, currentFrame.size.width - strokeWidth, round((currentFrame.size.height + HEIGHTOFPOPUPTRIANGLE) * 0.50f), currentFrame.size.width - strokeWidth, currentFrame.size.height - strokeWidth, borderRadius - strokeWidth);
    CGContextAddArcToPoint(context, currentFrame.size.width - strokeWidth, currentFrame.size.height - strokeWidth, round(currentFrame.size.width / 2.0f + WIDTHOFPOPUPTRIANGLE / 2.0f) - strokeWidth, currentFrame.size.height - strokeWidth, borderRadius - strokeWidth);
    CGContextAddArcToPoint(context, strokeWidth, currentFrame.size.height - strokeWidth, strokeWidth, HEIGHTOFPOPUPTRIANGLE + strokeWidth, borderRadius - strokeWidth);
    CGContextAddArcToPoint(context, strokeWidth, round((currentFrame.size.height + HEIGHTOFPOPUPTRIANGLE) * 0.50f), currentFrame.size.width - strokeWidth, round((currentFrame.size.height + HEIGHTOFPOPUPTRIANGLE) * 0.50f), borderRadius - strokeWidth);
    CGContextClosePath(context);
    CGContextClip(context);
    
}


@end
