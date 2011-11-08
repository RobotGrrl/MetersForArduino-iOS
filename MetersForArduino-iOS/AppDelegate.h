//
//  AppDelegate.h
//  MetersForArduino-iOS
//
/*
 Meters for Arduino (iOS) is licensed under the BSD 3-Clause License
 http://www.opensource.org/licenses/BSD-3-Clause
 
 Meters for Arduino (iOS) Copyright (c) 2011, RobotGrrl.com. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import "Wijourno.h"

@class ViewController, ViewController_iPad, ConnectingViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, WijournoDelegate> {
    
    // Wijourno
    Wijourno *wijourno;
    NSDictionary *givenSetupDict;
    
    // UI
    ViewController *viewController;
    ViewController_iPad *viewController_iPad;
    ConnectingViewController *connVC;
    
    // Flags
    BOOL debug;
    BOOL connVCVisible;
    BOOL waitingForTimer;
    BOOL sleeping;
    BOOL readTimed;
    
}

// Wijourno
@property (nonatomic, retain) NSDictionary *givenSetupDict;

// UI
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) ViewController_iPad *viewController_iPad;

// FYI
- (BOOL) iPadClient;

@end
