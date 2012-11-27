//
//  LUMorseCharacterManager.m
//  Lumus
//
//  Created by Ricardo Suarez on 11/19/12.
//  Copyright (c) 2012 Ricardo Suarez Martinez. All rights reserved.
//

#import "LUMorseCharacterManager.h"

static NSString *validCharacters = @"abcdefghijklmnñopqrstuvwxyz0123456789.,?!\" ";

@implementation LUMorseCharacterManager


#pragma mark - Class Functions

-(NSString *)getValidCharacters {
    return validCharacters;
}

-(id<LUMorseCharacterProtocol>)getMorseCharacterForCharacter:(NSString *)character {
    LUMorseCharacter *morseCharacter = [[LUMorseCharacter alloc] init];
    [morseCharacter loadMorseCharacter:character];
    
    return morseCharacter;
}

-(id<LUMorseCharacterProtocol>)getMorseCharacterSeparator {
    LUMorseCharacter *morseCharacter = [[LUMorseCharacter alloc] init];
    [morseCharacter loadMorseCharacterSeparator];
    
    return morseCharacter;
}

-(id<LUMorseCharacterProtocol>)getMorseCharacterForFinishWord {
    LUMorseCharacter *morseCharacter = [[LUMorseCharacter alloc] init];
    [morseCharacter loadMorseEndWord];
    
    return morseCharacter;
}

@end
