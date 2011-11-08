//
//  MeterView.m
//  MetersForArduino-iOS
//
/*
 Meters for Arduino (iOS) is licensed under the BSD 3-Clause License
 http://www.opensource.org/licenses/BSD-3-Clause
 
 Meters for Arduino (iOS) Copyright (c) 2011, RobotGrrl.com. All rights reserved.
 */

#import "MeterView.h"

@implementation MeterView

@synthesize stick, xPos, xPos2, yPos;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        xPos = 0.0;
        yPos = 0.0;
        
        middle = (frame.size.width/2);
        scale = (frame.size.height/2);
        
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    float h = rect.size.height;
    //float w = rect.size.width;
    
    middle = (rect.size.width/2);
    scale = h;//sqrt((h*h) + (w*w))/2;
    
    xPos *= scale;
    yPos *= scale;
    
    stick = [UIBezierPath bezierPath];
    [stick setLineWidth:2];
    [stick setLineCapStyle:kCGLineCapRound];
    
    [stick moveToPoint:CGPointMake(middle, h)];
    [stick addLineToPoint:CGPointMake(middle+xPos, h-yPos)];
    
    [[UIColor grayColor] set]; 
    [stick stroke];
    
}

- (void) refreshEverything {
    [self setNeedsDisplay];
}

@end
