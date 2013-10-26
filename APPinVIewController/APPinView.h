//
//  APPinCodeView.h
//  Fotokassa
//
//  Created by Sergii Kryvoblotskyi on 10/24/13.
//  Copyright (c) 2013 Alterplay. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDefinedPinsCount 4

@protocol APPinViewDelegate;
@interface APPinView : UIView

//Pins image
@property (nonatomic, strong) UIImage *normalPinImage;
@property (nonatomic, strong) UIImage *selectedPinImage;

//Getter/Setter for pin code NSString
@property (nonatomic, strong) NSString *pinCode;

//Delegate
@property (nonatomic, weak) id <APPinViewDelegate> delegate;
@end

@protocol APPinViewDelegate <NSObject>
@optional
- (void)pinCodeView:(APPinView *)view didEnterPin:(NSString *)pinCode;
@end
