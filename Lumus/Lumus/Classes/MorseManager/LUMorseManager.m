//
//  LUMorseManager.m
//  Lumus
//
//  Created by Ricardo Suarez on 11/17/12.
//  Copyright (c) 2012 Ricardo Suarez Martinez. All rights reserved.
//

#import "LUMorseManager.h"

#import <AVFoundation/AVFoundation.h>

#import "LUMorseCharacterManager.h"

#import "LUMorseContants.h"

static __strong LUMorseManager *morseManager;

static CGFloat maxBrightnessLevel = 1.0f;

@interface LUMorseManager ()

@property (nonatomic, assign)   AVCaptureDevice         *captureDevice;

@property (nonatomic, strong)   LUMorseCharacterManager *morseCharacterManager;

@property (nonatomic, strong)   NSMutableArray          *allCharactersToSend;

@property (nonatomic, strong)   NSString                *previousCharacter;

@property (nonatomic, strong)   id<LUMorseCharacterProtocol> morseWhiteSpaceCharacterPresenter;
@property (nonatomic, strong)   id<LUMorseCharacterProtocol> morseCharacterSeparatorPresenter;
@property (nonatomic, strong)   id<LUMorseCharacterProtocol> morseCharacterPresenter;

-(AVCaptureDevice *)getBackCaptureDevice;

-(NSString *)filterTextWhitValidCharacters:(NSString *)text;

-(NSString *)filterToGetOnlyValidCharacters:(NSString *)text;

-(void)startSendMessage;

@end

@implementation LUMorseManager

@synthesize captureDevice;
@synthesize morseCharacterManager;
@synthesize allCharactersToSend;
@synthesize delegate;
@synthesize previousCharacter;
@synthesize morseWhiteSpaceCharacterPresenter;
@synthesize morseCharacterSeparatorPresenter;
@synthesize morseCharacterPresenter;


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

-(NSString *)filterTextWhitValidCharacters:(NSString *)text {
    NSCharacterSet *charactersSet = [NSCharacterSet characterSetWithCharactersInString:[self.morseCharacterManager getValidCharacters]];
    
    NSString *filteredText = [[text componentsSeparatedByCharactersInSet:charactersSet] componentsJoinedByString:@""];
    return filteredText;
}

-(NSString *)filterToGetOnlyValidCharacters:(NSString *)text {
    NSCharacterSet *charactersSet = [NSCharacterSet characterSetWithCharactersInString:[self.morseCharacterManager getValidCharacters]];
    
    NSString *filteredText = [[text componentsSeparatedByCharactersInSet:[charactersSet invertedSet]] componentsJoinedByString:@""];
    return filteredText;
}

-(void)startSendMessage {
    if ([self.allCharactersToSend count] == 0) {
        if ([self.delegate respondsToSelector:@selector(messageSent)]) {
            [self.delegate messageSent];
            return;
        }
    }
    
    NSString *characterToRepresent = [self.allCharactersToSend objectAtIndex:0];
    
    if ([characterToRepresent isEqualToString:@" "]) {
        self.previousCharacter = characterToRepresent;
        [self.allCharactersToSend removeObjectAtIndex:0];
        self.morseWhiteSpaceCharacterPresenter =[self.morseCharacterManager getMorseCharacterForFinishWord];
        
        [self.morseWhiteSpaceCharacterPresenter setDelegate:self];
        [self.morseWhiteSpaceCharacterPresenter showCharacterSignal];
    }
    else {
        self.previousCharacter = characterToRepresent;
        [self.allCharactersToSend removeObjectAtIndex:0];
        self.morseCharacterPresenter =[self.morseCharacterManager getMorseCharacterForCharacter:characterToRepresent];
        [self.morseCharacterPresenter setDelegate:self];
        [self.morseCharacterPresenter showCharacterSignal];
    }
}

-(void)setTorchOn:(BOOL)torchOn {
    [self setTorchOn:torchOn withBrightnessLevel:maxBrightnessLevel];
}

-(NSString *)getValidCharacters {
    return [self.morseCharacterManager getValidCharacters];
}

-(BOOL)checkTextItsValid:(NSString *)text {
    
    return [[self filterTextWhitValidCharacters:text] isEqualToString:@""];

}

-(void) sendText:(NSString *)text {
    AVCaptureDevice *device = [self getBackCaptureDevice];
    
    if (![device isTorchAvailable]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Advertisement" message:@"Your device dont have torch" delegate:nil cancelButtonTitle:@"Accept" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    
    [self setTorchOn:NO];
    self.previousCharacter = nil;
    
    NSString *filteredText = [self filterToGetOnlyValidCharacters:text];
    
    self.allCharactersToSend = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < filteredText.length; i++) {
        [self.allCharactersToSend addObject:[filteredText substringWithRange:NSMakeRange(i, 1)]];
    }
    [self startSendMessage];
}

-(void)setTorchOn:(BOOL)torchOn withBrightnessLevel:(CGFloat)brightnessLevel {
    AVCaptureDevice *device = [self getBackCaptureDevice];
    
    [device lockForConfiguration:nil];
    if (torchOn) {
        
        [device setTorchModeOnWithLevel:brightnessLevel error:nil];
    }
    else {
        [device setTorchMode:AVCaptureTorchModeOff];
    }
    [device unlockForConfiguration];
}

#pragma mark - LUMorseCharacterDelegate

-(void)characterShown {
    if ([self.allCharactersToSend count] > 0) {
        if (![[self.allCharactersToSend objectAtIndex:0] isEqualToString:@" "]) {
            [self performSelector:@selector(startSendMessage) withObject:nil afterDelay:[LUMorseContants getCharacterSeparationSignalTime]];
        }
        else {
            [self startSendMessage];
        }
    }
    else {
        [self startSendMessage];
    }
}

#pragma mark - Life Cycle

+(id)sharedInstance {
    if (!morseManager) {
        morseManager = [[LUMorseManager alloc]init];
        morseManager.morseCharacterManager = [[LUMorseCharacterManager alloc] init];
    }
    return morseManager;
}


@end
