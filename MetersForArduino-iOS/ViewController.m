//
//  ViewController.m
//  MetersForArduino-iOS
//
/*
 Meters for Arduino (iOS) is licensed under the BSD 3-Clause License
 http://www.opensource.org/licenses/BSD-3-Clause
 
 Meters for Arduino (iOS) Copyright (c) 2011, RobotGrrl.com. All rights reserved.
 */

#import "ViewController.h"
#import "MeterView.h"
#import "InfoViewController.h"

@interface ViewController (Private)
- (float) calculateX:(int)reading;
- (float) calculateY:(int)reading;
@end

@implementation ViewController

@synthesize givenSetupDict;

- (void) dealloc {
    AudioServicesDisposeSystemSoundID(click);
    AudioServicesDisposeSystemSoundID(clock);
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    infoVC = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
    
    b = 0;
    
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"click" ofType:@"caf"]], &click);  
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"clock" ofType:@"caf"]], &clock);  
    
    currentMeter = 0;
    pinLabel.text = @"Analog Pin 0";
        
    if(givenSetupDict != nil) {
        if([[givenSetupDict objectForKey:@"A0"] intValue] == 1) {
            greyView.hidden = YES;
            meterView.hidden = NO;
        } else {
            greyView.hidden = NO;
            meterView.hidden = YES;
        }
    }
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

/*
- (void) setGivenSetupDict:(NSDictionary *)dict {
    
    if(dict != nil) {
        NSString *key = [NSString stringWithFormat:@"A%d", currentMeter];
        if([dict objectForKey:key] == 0) {
            greyView.hidden = YES;
            meterView.hidden = YES;
        } else {
            greyView.hidden = NO;
            meterView.hidden = NO;
        }
    }
    
    self.givenSetupDict = dict;
    
}
*/

- (void) updatedSetupDict {
    
    NSString *key = [NSString stringWithFormat:@"A%d", currentMeter];
    
    if([[self.givenSetupDict objectForKey:key] intValue] == 1) {
        greyView.hidden = YES;
        meterView.hidden = NO;
    } else {
        greyView.hidden = NO;
        meterView.hidden = YES;
    }
    
}

- (IBAction) infoPressed:(id)sender {
    [self presentModalViewController:infoVC animated:YES];
}

#pragma mark - Buttons

- (void) toggleButton:(int)newMeter {
    
    UIImage *buttonUp = [UIImage imageNamed:@"button-up@2x.png"];
    
    switch (currentMeter) {
        case 0:
            [pin0Img setImage:buttonUp];
            break;
        case 1:
            [pin1Img setImage:buttonUp];
            break;
        case 2:
            [pin2Img setImage:buttonUp];
            break;
        case 3:
            [pin3Img setImage:buttonUp];
            break;
        case 4:
            [pin4Img setImage:buttonUp];
            break;
        case 5:
            [pin5Img setImage:buttonUp];
            break;
        default:
            break;
    }
    
    UIImage *buttonDown = [UIImage imageNamed:@"button-down@2x.png"];
    
    switch (newMeter) {
        case 0:
            [pin0Img setImage:buttonDown];
            break;
        case 1:
            [pin1Img setImage:buttonDown];
            break;
        case 2:
            [pin2Img setImage:buttonDown];
            break;
        case 3:
            [pin3Img setImage:buttonDown];
            break;
        case 4:
            [pin4Img setImage:buttonDown];
            break;
        case 5:
            [pin5Img setImage:buttonDown];
            break;
        default:
            break;
    }
    
    if(b%2 == 0) {
        AudioServicesPlaySystemSound(click);
        b++;
    } else {
        AudioServicesPlaySystemSound(clock);
        b=0;
    }
    
}

- (IBAction) pin0Pressed:(id)sender {
    
    [self toggleButton:0];
    
    pinLabel.text = @"Analog Pin 0";
    currentMeter = 0;
    
    if(givenSetupDict != nil) {
        if([[givenSetupDict objectForKey:@"A0"] intValue] == 1) {
            greyView.hidden = YES;
            meterView.hidden = NO;
        } else {
            greyView.hidden = NO;
            meterView.hidden = YES;
        }
    }
    
}

- (IBAction) pin1Pressed:(id)sender {
    
    [self toggleButton:1];
    
    pinLabel.text = @"Analog Pin 1";
    currentMeter = 1;
    
    if(givenSetupDict != nil) {
        if([[givenSetupDict objectForKey:@"A1"] intValue] == 1) {
            greyView.hidden = YES;
            meterView.hidden = NO;
        } else {
            greyView.hidden = NO;
            meterView.hidden = YES;
        }
    }
    
}

- (IBAction) pin2Pressed:(id)sender {
    
    [self toggleButton:2];
    
    pinLabel.text = @"Analog Pin 2";
    currentMeter = 2;
    
    if(givenSetupDict != nil) {
        if([[givenSetupDict objectForKey:@"A2"] intValue] == 1) {
            greyView.hidden = YES;
            meterView.hidden = NO;
        } else {
            greyView.hidden = NO;
            meterView.hidden = YES;
        }
    }
    
}

- (IBAction) pin3Pressed:(id)sender {
    
    [self toggleButton:3];
    
    pinLabel.text = @"Analog Pin 3";
    currentMeter = 3;
    
    if(givenSetupDict != nil) {
        if([[givenSetupDict objectForKey:@"A3"] intValue] == 1) {
            greyView.hidden = YES;
            meterView.hidden = NO;
        } else {
            greyView.hidden = NO;
            meterView.hidden = YES;
        }
    }
    
}

- (IBAction) pin4Pressed:(id)sender {
    
    [self toggleButton:4];
    
    pinLabel.text = @"Analog Pin 4";
    currentMeter = 4;
    
    if(givenSetupDict != nil) {
        if([[givenSetupDict objectForKey:@"A4"] intValue] == 1) {
            greyView.hidden = YES;
            meterView.hidden = NO;
        } else {
            greyView.hidden = NO;
            meterView.hidden = YES;
        }
    }
    
}

- (IBAction) pin5Pressed:(id)sender {
    
    [self toggleButton:5];
    
    pinLabel.text = @"Analog Pin 5";
    currentMeter = 5;
    
    if(givenSetupDict != nil) {
        if([[givenSetupDict objectForKey:@"A5"] intValue] == 1) {
            greyView.hidden = YES;
            meterView.hidden = NO;
        } else {
            greyView.hidden = NO;
            meterView.hidden = YES;
        }
    }
    
}

#pragma mark - App Delegate

- (void) refresh:(NSDictionary *)dictionary {
    
    for(int i=0; i<6; i++) {
        
        NSString *iterKey = [NSString stringWithFormat:@"pin%d", i];
        
        NSNumber *givenNum = [dictionary objectForKey:iterKey];
        if(givenNum != nil) {
            int val = [givenNum intValue];
            
            if(i == currentMeter) {
                meterView.xPos = [self calculateX:val];
                meterView.yPos = [self calculateY:val];
                [meterView setNeedsDisplay];
            }
            
        }
    }
}

#pragma mark - Math

- (float) calculateX:(int)reading {
    
    // Change from linear to angular
    float adjusted = ( (120.0*(1023-reading))/1023.0 ) + 30;
    
    // Convert from deg to rad
    float radians = adjusted*(M_PI/180);
    
    // Compute x&y locations
    float x = cos(radians);
    return x;
    
}

- (float) calculateY:(int)reading {
    
    // Change from linear to angular
    float adjusted = ( (120.0*(1023-reading))/1023.0 ) + 30;
    
    // Convert from deg to rad
    float radians = adjusted*(M_PI/180);
    
    // Compute x&y locations
    float y = sin(radians);
    return y;
    
}

@end
