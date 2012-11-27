//
//  LUViewController.h
//  Lumus
//
//  Created by Ricardo Suarez on 11/12/12.
//  Copyright (c) 2012 Ricardo Suarez Martinez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *switchOnOff;
@property (strong, nonatomic) IBOutlet UISlider *torchBrightness;

- (IBAction)torchBrightnessChanged:(id)sender;
- (IBAction)OnOff:(id)sender;

@end
