//
//  ConnectingViewController.h
//  MetersForArduino-iOS
//
/*
 Meters for Arduino (iOS) is licensed under the BSD 3-Clause License
 http://www.opensource.org/licenses/BSD-3-Clause
 
 Meters for Arduino (iOS) Copyright (c) 2011, RobotGrrl.com. All rights reserved.
 */

#import <UIKit/UIKit.h>

@interface ConnectingViewController : UIViewController {
    
    IBOutlet UINavigationBar *titleBar;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UITextView *descriptionText;
    
}

@property (nonatomic, retain) IBOutlet UINavigationBar *titleBar;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction) helpPressed:(id)sender;

- (void) searchingForConnection;
- (void) connectionFound;
- (void) waitingForArduino;
- (void) arduinoFound;
- (void) connectionInterrupted;

@end
