//
//  LUViewController.m
//  Lumus
//
//  Created by Ricardo Suarez on 11/12/12.
//  Copyright (c) 2012 Ricardo Suarez Martinez. All rights reserved.
//

#import "LUViewController.h"

#import <AVFoundation/AVFoundation.h>
#import "UIDevice-Hardware.h"

#define ON_IMAGE  @"on.png"
#define ON_TEXT  @"ON"

#define OFF_IMAGE @"off.png"
#define OFF_TEXT @"OFF"

static NSInteger ORIGIN_Y_IPHONE_5 = 379;


@interface LUViewController ()


@property (nonatomic, weak)     AVCaptureDevice     *captureDevice;

-(AVCaptureDevice *)getBackCaptureDevice;
-(void)setTorchOn:(BOOL)torchOn;
-(void)applicationEnterBackground:(NSNotification *)notification;
-(void)applicationBecomeActive:(NSNotification *)notification;
-(void)setSliderPositionForIphone5;


@end

@implementation LUViewController

@synthesize switchOnOff;
@synthesize torchBrightness;
@synthesize captureDevice;

#pragma mark - Class Functions

-(AVCaptureDevice *)getBackCaptureDevice {
    if (!self.captureDevice) {
        NSArray *captureDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
        for (AVCaptureDevice *device in captureDevices) {
            if (device.position == AVCaptureDevicePositionBack) {
                self.captureDevice = device;
                break;
            }
        }
    }
    return self.captureDevice;
}

-(void)setTorchOn:(BOOL)torchOn {
    AVCaptureDevice *device = [self getBackCaptureDevice];
    
    if (![device isTorchAvailable]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Advertisement" message:@"Your device dont have torch" delegate:nil cancelButtonTitle:@"Accept" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    
    [device lockForConfiguration:nil];
    if (torchOn && self.torchBrightness.value > 0.0f) {
        [self.switchOnOff setBackgroundImage:[UIImage imageNamed:ON_IMAGE] forState:UIControlStateNormal];
        [self.switchOnOff setTitle:ON_TEXT forState:UIControlStateNormal];
        [self.torchBrightness setMinimumTrackTintColor:[UIColor greenColor]];
        
        [device setTorchModeOnWithLevel:self.torchBrightness.value error:nil];
    }
    else {
        [self.switchOnOff setBackgroundImage:[UIImage imageNamed:OFF_IMAGE] forState:UIControlStateNormal];
        [self.switchOnOff setTitle:OFF_TEXT forState:UIControlStateNormal];
        [self.torchBrightness setMinimumTrackTintColor:[UIColor redColor]];
        
        [device setTorchMode:AVCaptureTorchModeOff];
    }
    [device unlockForConfiguration];
}

-(void)applicationEnterBackground:(NSNotification *)notification {
    [self setTorchOn:NO];
}

-(void)applicationBecomeActive:(NSNotification *)notification {
    [self setTorchOn:YES];
}

-(void)setSliderPositionForIphone5 {
    CGRect frame = self.torchBrightness.frame;
    frame.origin.y = ORIGIN_Y_IPHONE_5;
    
    [self.torchBrightness setFrame:frame];
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setTorchOn:YES];
    if ([[UIDevice currentDevice] platformType] == UIDevice5iPhone) {
        [self setSliderPositionForIphone5];
    }
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self setTorchOn:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)torchBrightnessChanged:(id)sender {
    [self setTorchOn:YES];
}

- (IBAction)OnOff:(id)sender {
    [self setTorchOn:![[self getBackCaptureDevice] torchMode]];
}


@end
