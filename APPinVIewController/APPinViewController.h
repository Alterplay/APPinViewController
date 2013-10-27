//The MIT License (MIT)
//
//Copyright (c) 2013 Alterplay
//
//Permission is hereby granted, free of charge, to any person obtaining a copy of
//this software and associated documentation files (the "Software"), to deal in
//the Software without restriction, including without limitation the rights to
//use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//the Software, and to permit persons to whom the Software is furnished to do so,
//subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import <UIKit/UIKit.h>
#import "APPinView.h"

@protocol APPinViewControllerDelegate;
@interface APPinViewController : UIViewController <APPinViewDelegate>
@property (weak, nonatomic) IBOutlet APPinView *pinCodeView;

//You can set it on order to compare entered pin code with this var.
@property (nonatomic, strong) NSString *pinCodeToCheck;

//Failed attempts incrementer
@property (nonatomic, readonly) NSUInteger failedAttempts;

//Set this property to YES if you want to reset your current pinCode.
//Note: self.pinCodeToCheck must be non nil; Will raise an exception othervise
@property (nonatomic) BOOL shouldResetPinCode;

//Delegate
@property (nonatomic, weak) id <APPinViewControllerDelegate> delegate;

//You can override it for initial properties
- (void)commonInit;

/*
 Strings.
 You can override all of them to show messages like alerts, set labels, etc...
 */

@property (nonatomic, strong) NSString *enterYourPinString;
@property (nonatomic, strong) NSString *createYourPinString;
@property (nonatomic, strong) NSString *pinVerifiedString;

@property (nonatomic, strong) NSString *pinsDontMatchTryOnceAgainString;
@property (nonatomic, strong) NSString *pinCreatedString;
@property (nonatomic, strong) NSString *enterOnceAgainString;


/*
 
 If not overrided, all of them will just NSLog about what message was shown.
 You should override them to show message in your custom UI (labels, alerts, etc...);
 
 */

- (void)showCreateThePinMessage;
- (void)showEnterYourPinMessage;
- (void)showPinsDontMatchMessage;
- (void)showPinCreatedMessage;
- (void)showEnterOnceAgainMessage;
- (void)showPinVerifiedMessage;
@end

@protocol APPinViewControllerDelegate <NSObject>
@optional

/*
 Will be called when pinCodeToCheck isEqualTo: entered PinCode
 */

- (void)pinCodeViewController:(APPinViewController *)controller didVerifiedPincodeSuccessfully:(NSString *)pinCode;

/*
 Will be called when entered pin code don't match pinCodeToCheck;
 */

- (void)pinCodeViewController:(APPinViewController *)controller didFailVerificationWithCount:(NSUInteger)failsCount;

/*
 Will be called when pin code created
 */

- (void)pinCodeViewController:(APPinViewController *)controller didCreatePinCode:(NSString *)pinCode;


/*
 Will be called when pin code changed
 */

- (void)pinCodeViewController:(APPinViewController *)controller didChangePinCode:(NSString *)pinCode;


@end