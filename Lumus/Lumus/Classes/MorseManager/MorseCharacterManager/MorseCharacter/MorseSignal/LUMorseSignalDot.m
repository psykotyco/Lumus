//
//  LUMorseSignalDot.m
//  Lumus
//
//  Created by Ricardo Suarez on 11/19/12.
//  Copyright (c) 2012 Ricardo Suarez Martinez. All rights reserved.
//

#import "LUMorseSignalDot.h"

#import <AVFoundation/AVFoundation.h>

#import "LUMorseContants.h"

@interface LUMorseSignalDot ()

@property (nonatomic, assign) AVCaptureDevice       *captureDevice;

@property (nonatomic, strong) NSTimer               *timer;

-(AVCaptureDevice *)getBackCaptureDevice;

-(void)notifyShownSignal;

-(void)setTorchOn;

-(void)setTorchOff;


@end

@implementation LUMorseSignalDot

@synthesize delegate;
@synthesize captureDevice;
@synthesize timer;

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

-(void)notifyShownSignal {
    [self setTorchOff];
    [self.timer invalidate];
    if ([self.delegate respondsToSelector:@selector(shownSignal)]) {
        [self.delegate shownSignal];
    }
}

-(void)setTorchOn {
    AVCaptureDevice *device = [self getBackCaptureDevice];
    
    [device lockForConfiguration:nil];
    [device setTorchMode:AVCaptureTorchModeOn];
    [device unlockForConfiguration];
}

-(void)setTorchOff {
    AVCaptureDevice *device = [self getBackCaptureDevice];
    
    [device lockForConfiguration:nil];
    [device setTorchMode:AVCaptureTorchModeOff];
    [device unlockForConfiguration];
}

#pragma mark - LUMorseSignalProtocol

-(void)showLightSignal {
    [self setTorchOff];
    if (self.timer) {
        [self.timer invalidate];
    }
    [self setTorchOn];
    [self performSelector:@selector(notifyShownSignal) withObject:nil afterDelay:[LUMorseContants getDotSignalTime]];
}

-(void)showNonLighSignal {
    [self setTorchOff];
    if (self.timer) {
        [self.timer invalidate];
    }

    [self performSelector:@selector(notifyShownSignal) withObject:nil afterDelay:[LUMorseContants getDotSignalTime]];
}

@end
