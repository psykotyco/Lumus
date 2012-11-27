//
//  LUMorseManager.h
//  Lumus
//
//  Created by Ricardo Suarez on 11/17/12.
//  Copyright (c) 2012 Ricardo Suarez Martinez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LUMorseCharacterDelegate.h"

#import "LUMorseManagerDelegate.h"

@class LUMorseCharacterProtocol;

@interface LUMorseManager : NSObject <LUMorseCharacterDelegate>

+(id)sharedInstance;

@property (nonatomic, strong) id<LUMorseManagerDelegate> delegate;

-(NSString *)getValidCharacters;

-(BOOL)checkTextItsValid:(NSString *)text;

-(void)sendText:(NSString *)text;                   // If text have invalid characters, this function will remove them before send text

-(void)setTorchOn:(BOOL)torchOn;

-(void)setTorchOn:(BOOL)torchOn withBrightnessLevel:(CGFloat)brightnessLevel;

@end
