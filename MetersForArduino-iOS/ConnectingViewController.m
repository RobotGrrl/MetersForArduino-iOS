//
//  ConnectingViewController.m
//  MetersForArduino-iOS
//
/*
 Meters for Arduino (iOS) is licensed under the BSD 3-Clause License
 http://www.opensource.org/licenses/BSD-3-Clause
 
 Meters for Arduino (iOS) Copyright (c) 2011, RobotGrrl.com. All rights reserved.
 */

#import "ConnectingViewController.h"

@implementation ConnectingViewController

@synthesize titleBar, activityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) viewWillAppear:(BOOL)animated {
    
    //self.titleBar.topItem.title = @"Searching for Connection";
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark -

- (void) searchingForConnection {
    self.titleBar.topItem.title = @"Searching for Connection";
    descriptionText.text = @"Make sure Meters for Arduino on your Mac is open and your device is on the same wireless network.";
}

- (void) connectionFound {
    self.titleBar.topItem.title = @"Connected! Setting up...";
    descriptionText.text = @"Connection was established to the Mac! Waiting for setup.";
}

- (void) waitingForArduino {
    self.titleBar.topItem.title = @"Waiting for Arduino";
    descriptionText.text = @"Connection was established to the Mac! Waiting for the Arduino.";
}

- (void) arduinoFound {
    self.titleBar.topItem.title = @"Arduino Success";
    descriptionText.text = @"Connection to the Arduino was a success! Let's go!";
}

- (void) connectionInterrupted {
    self.titleBar.topItem.title = @"Connection Interruption";
    descriptionText.text = @"There has been no data received recently. Check your connection from your device to your Mac.";
}

- (IBAction) helpPressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.robotgrrl.com/apps4arduino/wijourno-help.php"]];
}

@end
