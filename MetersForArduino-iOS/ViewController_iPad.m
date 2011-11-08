//
//  ViewController_iPad.m
//  MetersForArduino-iOS
//
/*
 Meters for Arduino (iOS) is licensed under the BSD 3-Clause License
 http://www.opensource.org/licenses/BSD-3-Clause
 
 Meters for Arduino (iOS) Copyright (c) 2011, RobotGrrl.com. All rights reserved.
 */

#import "ViewController_iPad.h"
#import "MeterView.h"
#import "InfoViewController.h"

@interface ViewController_iPad (Private)
- (float) calculateX:(int)reading;
- (float) calculateY:(int)reading;
@end

@implementation ViewController_iPad

@synthesize givenSetupDict;

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
    
    infoVC = [[InfoViewController alloc] initWithNibName:@"InfoViewController-iPad" bundle:nil];
    
    if(givenSetupDict != nil) {
        [self updatedSetupDict];
    }
    
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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

- (void) updatedSetupDict {
    
    for(int i=0; i<6; i++) {
        
        NSString *key = [NSString stringWithFormat:@"A%d", i];
        
        if([[self.givenSetupDict objectForKey:key] intValue] == 1) {
            
            switch (i) {
                case 0:
                    pin0Grey.hidden = YES;
                    pin0View.hidden = NO;
                    break;
                case 1:
                    pin1Grey.hidden = YES;
                    pin1View.hidden = NO;
                    break;
                case 2:
                    pin2Grey.hidden = YES;
                    pin2View.hidden = NO;
                    break;
                case 3:
                    pin3Grey.hidden = YES;
                    pin3View.hidden = NO;
                    break;
                case 4:
                    pin4Grey.hidden = YES;
                    pin4View.hidden = NO;
                    break;
                case 5:
                    pin5Grey.hidden = YES;
                    pin5View.hidden = NO;
                    break;
                default:
                    break;
            }
            
        } else {
            
            switch (i) {
                case 0:
                    pin0Grey.hidden = NO;
                    pin0View.hidden = YES;
                    break;
                case 1:
                    pin1Grey.hidden = NO;
                    pin1View.hidden = YES;
                    break;
                case 2:
                    pin2Grey.hidden = NO;
                    pin2View.hidden = YES;
                    break;
                case 3:
                    pin3Grey.hidden = NO;
                    pin3View.hidden = YES;
                    break;
                case 4:
                    pin4Grey.hidden = NO;
                    pin4View.hidden = YES;
                    break;
                case 5:
                    pin5Grey.hidden = NO;
                    pin5View.hidden = YES;
                    break;
                default:
                    break;
            }
            
        }
        
    }
        
}

- (IBAction) infoPressed:(id)sender {
    infoVC.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:infoVC animated:YES];
}

#pragma mark - App Delegate

- (void) refresh:(NSDictionary *)dictionary {
    
    for(int i=0; i<6; i++) {
    
        NSString *iterKey = [NSString stringWithFormat:@"pin%d", i];
    
        NSNumber *givenNum = [dictionary objectForKey:iterKey];
        if(givenNum != nil) {
            int val = [givenNum intValue];
            
            switch (i) {
                case 0:
                    pin0View.xPos = [self calculateX:val];
                    pin0View.yPos = [self calculateY:val];
                    [pin0View setNeedsDisplay];
                    break;
                case 1:
                    pin1View.xPos = [self calculateX:val];
                    pin1View.yPos = [self calculateY:val];
                    [pin1View setNeedsDisplay];
                    break;
                case 2:
                    pin2View.xPos = [self calculateX:val];
                    pin2View.yPos = [self calculateY:val];
                    [pin2View setNeedsDisplay];
                    break;
                case 3:
                    pin3View.xPos = [self calculateX:val];
                    pin3View.yPos = [self calculateY:val];
                    [pin3View setNeedsDisplay];
                    break;
                case 4:
                    pin4View.xPos = [self calculateX:val];
                    pin4View.yPos = [self calculateY:val];
                    [pin4View setNeedsDisplay];
                    break;
                case 5:
                    pin5View.xPos = [self calculateX:val];
                    pin5View.yPos = [self calculateY:val];
                    [pin5View setNeedsDisplay];
                    break;
                default:
                    break;
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
