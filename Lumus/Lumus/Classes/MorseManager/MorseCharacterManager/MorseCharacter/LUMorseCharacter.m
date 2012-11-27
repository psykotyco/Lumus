//
//  LUMorseCharacter.m
//  Lumus
//
//  Created by Ricardo Suarez on 11/19/12.
//  Copyright (c) 2012 Ricardo Suarez Martinez. All rights reserved.
//

#import "LUMorseCharacter.h"

#import <AVFoundation/AVFoundation.h>

#import "LUMorseSignalDot.h"

#import "LUMorseSignalStreak.h"

#import "LUMorseContants.h"


static NSString *dot = @"P";

static NSString *streak = @"R";

static NSString *morseCharacterFileExtension = @"txt";

static NSString *codificationSeparator = @",";

static NSString *whiteSpaceFile = @"whiteSpace";

static NSString *wordEndFile = @"wordEnd";

typedef enum {
    LightSignal = 0,
    NonLightSignal = 1
} SignalType;

@interface LUMorseCharacter ()

@property (nonatomic,assign) NSString               *characterRepresented;

@property (nonatomic,assign) BOOL                   mustLight;

@property (nonatomic,strong) NSArray                *codificationList;

@property (nonatomic,strong) NSMutableArray         *characterSignalProcess;

@property (nonatomic,strong) LUMorseSignalDot       *dotSignal;

@property (nonatomic,strong) LUMorseSignalStreak    *streakSignal;

@property (nonatomic,strong) NSTimer                *timer;

@property (nonatomic,assign) SignalType             signalType;

-(void)startSendCharacterLightSignal;

-(void)startSendCharacterNonLightSignal;

@end

@implementation LUMorseCharacter

@synthesize characterRepresented;
@synthesize mustLight;
@synthesize codificationList;
@synthesize characterSignalProcess;
@synthesize dotSignal;
@synthesize streakSignal;
@synthesize timer;
@synthesize signalType;
@synthesize delegate;

#pragma mark - LUMorseCharacterProtocol

-(void)showCharacterSignal {
    self.characterSignalProcess = [NSMutableArray arrayWithArray:self.codificationList];
    if (self.signalType == LightSignal) {
        [self startSendCharacterLightSignal];
    }
    else if (self.signalType == NonLightSignal) {
        [self startSendCharacterNonLightSignal];
    }
}

-(NSString *)getCharacterRepresented {
    return self.characterRepresented;
}

-(NSArray *)getMorseCharacterRepresentation {
    return self.codificationList;
}

#pragma mark - LUMorseSignalDelegate

-(void)shownSignal {
    [self.timer invalidate];
    if (self.signalType == LightSignal) {
        [self performSelector:@selector(startSendCharacterLightSignal) withObject:nil afterDelay:[LUMorseContants getSignalLightSpaceInterval]];
    }
    else if (self.signalType == NonLightSignal) {
        [self performSelector:@selector(startSendCharacterNonLightSignal) withObject:nil afterDelay:[LUMorseContants getSignalNonLightSpaceInterval]];
    }
}

#pragma mark - Class Functions

-(void)startSendCharacterLightSignal {
    if ([self.characterSignalProcess count] == 0) {
        if ([self.delegate respondsToSelector:@selector(characterShown)]) {
            [self.delegate characterShown];
        }
        return;
    }
    NSString *signal = [self.characterSignalProcess objectAtIndex:0];
    
    [self.characterSignalProcess removeObjectAtIndex:0];
    
    if ([signal isEqualToString:dot]) {
        [[self getDotSignal] showLightSignal];
    }
    else if ([signal isEqualToString:streak]) {
        [[self getStreakSignal] showLightSignal];
    }
}

-(void)startSendCharacterNonLightSignal {
    if ([self.characterSignalProcess count] == 0) {
        if ([self.delegate respondsToSelector:@selector(characterShown)]) {
            [self.delegate characterShown];
        }
        return;
    }
    NSString *signal = [self.characterSignalProcess objectAtIndex:0];
    
    [self.characterSignalProcess removeObjectAtIndex:0];
    
    if ([signal isEqualToString:dot]) {
        [[self getDotSignal] showNonLighSignal];
    }
    else if ([signal isEqualToString:streak]) {
        [[self getStreakSignal] showNonLighSignal];
    }
}


-(LUMorseSignalDot *)getDotSignal {
    if (!dotSignal) {
        dotSignal = [[LUMorseSignalDot alloc] init];
        [dotSignal setDelegate:self];
    }
    return dotSignal;
}

-(LUMorseSignalStreak *)getStreakSignal {
    if (!streakSignal) {
        streakSignal = [[LUMorseSignalStreak alloc] init];
        [streakSignal setDelegate:self];
    }
    return streakSignal;
}

-(void)loadMorseCharacter:(NSString *)character {
    self.signalType = LightSignal;
    NSString *morseCharacterPath = [[NSBundle mainBundle] pathForResource:character ofType:morseCharacterFileExtension];
    
    NSData *fileContent = [NSData dataWithContentsOfFile:morseCharacterPath];
    
    NSString *morseCharacterFileContent = [[NSString alloc] initWithData:fileContent encoding:NSUTF8StringEncoding];
    
    self.codificationList = [morseCharacterFileContent componentsSeparatedByString:codificationSeparator];
}

-(void)loadMorseCharacterSeparator {
    self.signalType = NonLightSignal;
    NSString *morseCharacterPath = [[NSBundle mainBundle] pathForResource:whiteSpaceFile ofType:morseCharacterFileExtension];
    
    NSData *fileContent = [NSData dataWithContentsOfFile:morseCharacterPath];
    
    NSString *morseCharacterFileContent = [[NSString alloc] initWithData:fileContent encoding:NSUTF8StringEncoding];
    
    self.codificationList = [morseCharacterFileContent componentsSeparatedByString:codificationSeparator];

}

-(void)loadMorseEndWord {
    self.signalType = NonLightSignal;
    NSString *morseCharacterPath = [[NSBundle mainBundle] pathForResource:wordEndFile ofType:morseCharacterFileExtension];
    
    NSData *fileContent = [NSData dataWithContentsOfFile:morseCharacterPath];
    
    NSString *morseCharacterFileContent = [[NSString alloc] initWithData:fileContent encoding:NSUTF8StringEncoding];
    
    self.codificationList = [morseCharacterFileContent componentsSeparatedByString:codificationSeparator];

}

@end
