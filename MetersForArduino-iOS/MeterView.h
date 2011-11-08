//
//  MeterView.h
//  MetersForArduino-iOS
//
/*
 Meters for Arduino (iOS) is licensed under the BSD 3-Clause License
 http://www.opensource.org/licenses/BSD-3-Clause
 
 Meters for Arduino (iOS) Copyright (c) 2011, RobotGrrl.com. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MeterView : UIView {
    
    UIBezierPath *stick;
    float middle;
    float scale;
    
    float xPos;
    float xPos2;
    float yPos;
    
}

@property (nonatomic, retain) UIBezierPath *stick;

@property (assign) float xPos;
@property (assign) float xPos2;
@property (assign) float yPos;

- (void) refreshEverything;

@end
