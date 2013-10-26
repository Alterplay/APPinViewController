//
//  RootViewController.h
//  APPinExpample
//
//  Created by Sergii Kryvoblotskyi on 10/26/13.
//  Copyright (c) 2013 Alterplay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SamplePinViewController.h"

@interface RootViewController : UIViewController <APPinViewControllerDelegate>

@property (nonatomic, strong) NSUserDefaults *defaults;
@property (nonatomic, strong) NSString *pinCode;

@property (weak, nonatomic) IBOutlet UIButton *setupPinButton;
@property (weak, nonatomic) IBOutlet UIButton *verifyPinButton;
@property (weak, nonatomic) IBOutlet UIButton *changePinButton;

@end
