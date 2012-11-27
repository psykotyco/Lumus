//
//  LUMorseViewController.h
//  Lumus
//
//  Created by Ricardo Suarez on 11/17/12.
//  Copyright (c) 2012 Ricardo Suarez Martinez. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LUMorseManagerDelegate.h"

@interface LUMorseViewController : UIViewController <UITextFieldDelegate,UIAlertViewDelegate,LUMorseManagerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *morseText;

@end
