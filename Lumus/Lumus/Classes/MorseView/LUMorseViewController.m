//
//  LUMorseViewController.m
//  Lumus
//
//  Created by Ricardo Suarez on 11/17/12.
//  Copyright (c) 2012 Ricardo Suarez Martinez. All rights reserved.
//

#import "LUMorseViewController.h"

#import "LUMorseManager.h"

@interface LUMorseViewController ()

@property (nonatomic, assign) LUMorseManager *morseManager;

-(void)sendMessage:(NSString *)message;

@end

@implementation LUMorseViewController

@synthesize morseText;
@synthesize morseManager;


#pragma mark - Class Functions

-(void)sendMessage:(NSString *)message {
    if (![self.morseManager checkTextItsValid:message]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Advertisement" message:[NSString stringWithFormat:@"Your message have invalid characters, valid characters are:\n %@",[self.morseManager getValidCharacters]] delegate:nil cancelButtonTitle:@"Accept" otherButtonTitles:nil];
        [alert show];
        return;
    }
    [self.morseManager sendText:message];
}

#pragma mark - Touch Events

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [event.allTouches anyObject];
    if ([self.morseText isFirstResponder] && [touch view] != self.morseText) {
        [self.morseText resignFirstResponder];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if (![textField.text isEqualToString:@""]) {
        [self sendMessage:[textField.text lowercaseString]];
    }
    return YES;
}

#pragma mark - LUMorseManagerDelegate

-(void)messageSent {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Advertisement" message:@"Message sent" delegate:nil cancelButtonTitle:@"Accept" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.morseManager = [LUMorseManager sharedInstance];
        [self.morseManager setDelegate:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.morseManager setTorchOn:NO];
    [self.morseText becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
