//
//  SamplePinViewController.m
//  APPinExpample
//
//  Created by Sergii Kryvoblotskyi on 10/26/13.
//  Copyright (c) 2013 Alterplay. All rights reserved.
//

#import "SamplePinViewController.h"

@implementation SamplePinViewController

/*
 
 Sample messages you can override them.
 
 */

- (void)showCreateThePinMessage {
    self.messageLabel.text = self.createYourPinString;
}

- (void)showEnterOnceAgainMessage {
    self.messageLabel.text = self.enterOnceAgainString;
}

- (void)showPinCreatedMessage {
    self.messageLabel.text = self.pinCreatedString;
}

- (void)showPinsDontMatchMessage {
    self.messageLabel.text = self.pinsDontMatchTryOnceAgainString;
}

- (void)showEnterYourPinMessage {
    self.messageLabel.text = self.enterYourPinString;
}

- (void)showPinVerifiedMessage {
    self.messageLabel.text = self.pinCreatedString;
}

@end
