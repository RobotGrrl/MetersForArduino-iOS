//
//  ViewController.h
//  MetersForArduino-iOS
//
/*
 Meters for Arduino (iOS) is licensed under the BSD 3-Clause License
 http://www.opensource.org/licenses/BSD-3-Clause
 
 Meters for Arduino (iOS) Copyright (c) 2011, RobotGrrl.com. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@class MeterView, InfoViewController;

@interface ViewController : UIViewController {
    
    InfoViewController *infoVC;
    
    IBOutlet MeterView *meterView;
    IBOutlet UILabel *pinLabel;
    
    IBOutlet UIView *greyView;
    
    int currentMeter;
    
    NSDictionary *givenSetupDict;
    
    IBOutlet UIImageView *pin0Img;
    IBOutlet UIImageView *pin1Img;
    IBOutlet UIImageView *pin2Img;
    IBOutlet UIImageView *pin3Img;
    IBOutlet UIImageView *pin4Img;
    IBOutlet UIImageView *pin5Img;
    
    int b;
    
    SystemSoundID click;
    SystemSoundID clock;
    
}

@property (nonatomic, retain) NSDictionary *givenSetupDict;

- (IBAction) pin0Pressed:(id)sender;
- (IBAction) pin1Pressed:(id)sender;
- (IBAction) pin2Pressed:(id)sender;
- (IBAction) pin3Pressed:(id)sender;
- (IBAction) pin4Pressed:(id)sender;
- (IBAction) pin5Pressed:(id)sender;

- (void) refresh:(NSDictionary *)dictionary;
- (void) updatedSetupDict;
- (IBAction) infoPressed:(id)sender;

@end
