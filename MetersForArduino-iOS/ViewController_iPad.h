//
//  ViewController_iPad.h
//  MetersForArduino-iOS
//
/*
 Meters for Arduino (iOS) is licensed under the BSD 3-Clause License
 http://www.opensource.org/licenses/BSD-3-Clause
 
 Meters for Arduino (iOS) Copyright (c) 2011, RobotGrrl.com. All rights reserved.
 */

#import <UIKit/UIKit.h>

@class MeterView, InfoViewController;

@interface ViewController_iPad : UIViewController {
    
    InfoViewController *infoVC;
    
    IBOutlet MeterView *pin0View;
    IBOutlet MeterView *pin1View;
    IBOutlet MeterView *pin2View;
    IBOutlet MeterView *pin3View;
    IBOutlet MeterView *pin4View;
    IBOutlet MeterView *pin5View;
    
    IBOutlet UIView *pin0Grey;
    IBOutlet UIView *pin1Grey;
    IBOutlet UIView *pin2Grey;
    IBOutlet UIView *pin3Grey;
    IBOutlet UIView *pin4Grey;
    IBOutlet UIView *pin5Grey;
    
    NSDictionary *givenSetupDict;
    
}

@property (nonatomic, retain) NSDictionary *givenSetupDict;

- (void) refresh:(NSDictionary *)dictionary;
- (IBAction) infoPressed:(id)sender;
- (void) updatedSetupDict;

@end
