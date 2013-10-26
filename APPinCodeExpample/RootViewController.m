//
//  RootViewController.m
//  APPinExpample
//
//  Created by Sergii Kryvoblotskyi on 10/26/13.
//  Copyright (c) 2013 Alterplay. All rights reserved.
//

#import "RootViewController.h"

#define kCurrentPinKey @"kCurrentPinKey"

@implementation RootViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        /*
         We are using NSUserDefaults in this expample. Its up to you to decide where to store
         you pin code (Keychain, etc...)
         */
        
        _defaults = [NSUserDefaults standardUserDefaults];
        _pinCode = [_defaults objectForKey:kCurrentPinKey];
    }
    return self;
}

- (void)setPinCode:(NSString *)pinCode {
    _pinCode = pinCode;
    [_defaults setObject:pinCode forKey:kCurrentPinKey];
    [_defaults synchronize];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadView];
}

#pragma mark - View
- (void)reloadView {
    self.verifyPinButton.enabled = self.pinCode != nil;
    self.changePinButton.enabled = self.pinCode != nil;
}

#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SamplePinViewController *sampleVC = segue.destinationViewController;
    sampleVC.delegate = self;
    
    //Set pin
    if (sender == self.setupPinButton) {
        
        //Do nothing just open the screen
    //Verify pin
    } else if (sender == self.verifyPinButton) {
        
        //Set the pin to verify
        sampleVC.pinCodeToCheck = self.pinCode;
    //Change pin
    } else if (sender == self.changePinButton) {
        
        //Set the pin to verify and mark to change
        sampleVC.pinCodeToCheck = self.pinCode;
        sampleVC.shouldResetPinCode = YES;
    }
}

#pragma mark - Delegates
//Create
- (void)pinCodeViewController:(APPinViewController *)controller didCreatePinCode:(NSString *)pinCode {
    self.pinCode = pinCode;
    [self reloadView];
    
    [self.navigationController popViewControllerAnimated:YES];
    [self showAlertWithMessage:@"Pin created"];
}

//Verify
- (void)pinCodeViewController:(APPinViewController *)controller didVerifiedPincodeSuccessfully:(NSString *)pinCode {
    [self.navigationController popViewControllerAnimated:YES];
    [self showAlertWithMessage:@"Pin verified"];
}

//Change
- (void)pinCodeViewController:(APPinViewController *)controller didChangePinCode:(NSString *)pinCode {
    self.pinCode = pinCode;
    [self.navigationController popViewControllerAnimated:YES];
    [self showAlertWithMessage:@"Pin changed"];
}

#pragma mark - Alert
- (void)showAlertWithMessage:(NSString *)message {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"Dismiss"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
