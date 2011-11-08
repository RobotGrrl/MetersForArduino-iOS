//
//  AppDelegate.m
//  MetersForArduino-iOS
//
/*
 Meters for Arduino (iOS) is licensed under the BSD 3-Clause License
 http://www.opensource.org/licenses/BSD-3-Clause
 
 Meters for Arduino (iOS) Copyright (c) 2011, RobotGrrl.com. All rights reserved.
 */

#import "AppDelegate.h"
#import "ViewController.h"
#import "ViewController_iPad.h"
#import "Wijourno_tags.h"
#import "ConnectingViewController.h"

#define SERVICE_NAME @"MetersForArduino"

@interface AppDelegate (Private)
- (void) sendInitialInfo;
- (void) initWijourno;
- (void) showConnVC;
- (void) hideConnVC;
@end

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize viewController_iPad = _viewController_iPad;
@synthesize givenSetupDict;

- (BOOL) iPadClient {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) return NO;
    return YES;
}

- (void)dealloc {
    [wijourno closeSocket];
    [wijourno release];
    [_window release];
    [_viewController release];
    [_viewController_iPad release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    debug = NO;
    connVCVisible = NO;
    readTimed = NO;
    
    [self initWijourno];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    if (![self iPadClient]) {
        self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil] autorelease];
        self.window.rootViewController = self.viewController;
        connVC = [[ConnectingViewController alloc] initWithNibName:@"ConnectingViewController" bundle:nil];
    } else {
        self.viewController_iPad = [[[ViewController_iPad alloc] initWithNibName:@"ViewController_iPad" bundle:nil] autorelease];
        self.window.rootViewController = self.viewController_iPad;
        connVC = [[ConnectingViewController alloc] initWithNibName:@"ConnectingViewController-iPad" bundle:nil];
        connVC.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    
    waitingForTimer = YES;
    [NSTimer scheduledTimerWithTimeInterval:2 
                                     target:self 
                                   selector:@selector(checkConn) 
                                   userInfo:nil 
                                    repeats:NO];
    
    [self.window makeKeyAndVisible];

    return YES;
}

- (void) initWijourno {
    //NSString *clientName = @"My iPad";
    
    UIDevice *device = [UIDevice currentDevice];
    NSString *deviceName = [device name];
        
    NSCharacterSet *charactersToRemove = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    NSString *clientName = [[deviceName componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@""];
        
    NSString *deviceModel = [device model];
    NSString *deviceSysName = [device systemName];
    NSString *deviceSysVersion = [device systemVersion];
    
    NSMutableDictionary *clientInfo = [[NSMutableDictionary alloc] initWithCapacity:5];
    [clientInfo setObject:clientName forKey:@"name"];
    
    [clientInfo setObject:clientName forKey:@"deviceName"];
    [clientInfo setObject:deviceModel forKey:@"deviceModel"];
    [clientInfo setObject:deviceSysName forKey:@"deviceSysName"];
    [clientInfo setObject:deviceSysVersion forKey:@"deviceSysVersion"];
    
    wijourno =  [[Wijourno alloc] init];
    wijourno.delegate = self;
    [wijourno initClientWithServiceName:SERVICE_NAME dictionary:clientInfo];
    
    [clientInfo release];
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    
    sleeping = YES;
    [wijourno disconnectClient];
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    if(sleeping) {
        waitingForTimer = YES;
        [NSTimer scheduledTimerWithTimeInterval:2 
                                         target:self 
                                       selector:@selector(checkConn) 
                                       userInfo:nil 
                                        repeats:NO];
        
        [wijourno reconnectClient];
        sleeping = NO;
    }
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    
    sleeping = YES;
    [wijourno disconnectClient];
    
}

- (void) checkConn {
    
    if(debug) NSLog(@"Checking the connection now");
    
    if(![wijourno currentlyConnected]) {
        
        if(debug) NSLog(@"Not currently connected");
        
        [self showConnVC];
        [connVC searchingForConnection];
        
    } else {
    
        if([[self.givenSetupDict objectForKey:@"ArduinoConnected"] intValue] == 1) {
        
            [self hideConnVC];
        
        } else {
        
            [self showConnVC];
            [connVC waitingForArduino];
            
        }   
    }
    waitingForTimer = NO;
}

#pragma mark - Wijourno

- (void) connectionStarted:(NSString *)host {
    NSLog(@"We connected to host: %@", host); 
}

- (void) connectionFinished:(NSString *)details {
    NSLog(@"The connection finished: %@", details);
    if(!sleeping) [self showConnVC];
    [connVC searchingForConnection];
    
    
    
}

- (void) readTimedOut {    
    if([[self.givenSetupDict objectForKey:@"ArduinoConnected"] intValue] == 1) {
        [self showConnVC];
        [connVC connectionInterrupted];
        readTimed = YES;
    }
    
}

- (void) didReadCommand:(NSString *)command dictionary:(NSDictionary *)dictionary isServer:(BOOL)isServer {
    
    //NSLog(@"The client received a command: %@ and dict: %@", command, dictionary);
    
    if(readTimed && connVCVisible) {
        readTimed = NO;
        [self hideConnVC];
    }
    
    if([command isEqualToString:DATA]) {
        if(debug) NSLog(@"It was data");
        [connVC connectionFound];
        
    } else if([command isEqualToString:SETUP]) {
        if(debug) NSLog(@"It was setup: %@", dictionary);
        
        self.givenSetupDict = dictionary;
        
        if([[dictionary objectForKey:@"ArduinoConnected"] intValue] == 1) {
            
            if(![self iPadClient]) {
                self.viewController.givenSetupDict = dictionary;
                [self.viewController updatedSetupDict];
            } else {
                self.viewController_iPad.givenSetupDict = dictionary;
                [self.viewController_iPad updatedSetupDict];
            }
            
            [self hideConnVC];
            
        } else {
            if(!waitingForTimer) [self showConnVC];
            [connVC waitingForArduino];
        }
        
    } else if([command isEqualToString:ACTION]) {
        if(debug) NSLog(@"It was an action");
        
    } else if([command isEqualToString:TEXT]) {
        //NSLog(@"It was text");
        
        if(![self iPadClient]) {
            [self.viewController refresh:dictionary];
        } else {
            [self.viewController_iPad refresh:dictionary];
        }
        
    }
    
}

- (void) showConnVC {
    if(!connVCVisible) {
        if(![self iPadClient]) {
            [self.viewController presentModalViewController:connVC animated:YES];
        } else {
            [self.viewController_iPad presentModalViewController:connVC animated:YES];
        }
        connVCVisible = YES;
    }
}

- (void) hideConnVC {
    if(connVCVisible) {
        if(![self iPadClient]) {
            [self.viewController dismissModalViewControllerAnimated:YES];
        } else {
            [self.viewController_iPad dismissModalViewControllerAnimated:YES];
        }
        connVCVisible = NO;
    }
}

@end
