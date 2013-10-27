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

#import "APPinView.h"

@interface APPinView () {
    NSArray *_pinViewsArray;
    UITextField *_fakeTextField;
}
@property (nonatomic, readonly, getter = isInitialized) BOOL initialized;
@end

@implementation APPinView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    if (!self.isInitialized) {
        //You can freely use background color in XIB's
        self.backgroundColor = [UIColor clearColor];
        
        _normalPinImage = [UIImage imageNamed:@"pinViewUnSelected"];
        _selectedPinImage = [UIImage imageNamed:@"pinViewSelected"];
        
        //Fake text field
        _fakeTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _fakeTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_fakeTextField addTarget:self action:@selector(textFieldTextChanged:)
                 forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_fakeTextField];
    
        //Build pins
        [self buildPins];
        
        //Tap gesture
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(tapGestureOccured:)];
        [self addGestureRecognizer:tapGesture];
        
        _initialized = YES;
    }
}

#pragma mark - Build View
- (void)buildPins {
    //Remove old pins
    [_pinViewsArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat width = self.bounds.size.width;
    CGFloat itemWidth = floor(width / (CGFloat)kDefinedPinsCount);
    
    //Add pincodes
    NSMutableArray *pinCodesContainer = [NSMutableArray new];
    for (NSInteger i = 0;i < kDefinedPinsCount; i++) {
        UIImageView *pinImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * itemWidth,
                                                                                  0.0f,
                                                                                  itemWidth,
                                                                                  self.bounds.size.height)];
        pinImageView.image = _normalPinImage;
        pinImageView.highlightedImage = _selectedPinImage;
        pinImageView.contentMode = UIViewContentModeCenter;
        pinImageView.autoresizingMask =
        UIViewAutoresizingFlexibleWidth
        | UIViewAutoresizingFlexibleHeight
        | UIViewAutoresizingFlexibleLeftMargin
        | UIViewAutoresizingFlexibleRightMargin;
        
        [self addSubview:pinImageView];
        
        [pinCodesContainer addObject:pinImageView];
    }
    _pinViewsArray = [pinCodesContainer copy];
}

#pragma mark - Images
- (void)setNormalPinImage:(UIImage *)normalPinImage {
    _normalPinImage = normalPinImage;
    
    //Set normal image
    [_pinViewsArray makeObjectsPerformSelector:@selector(setImage:)
                                    withObject:normalPinImage];
}

- (void)setSelectedPinImage:(UIImage *)selectedPinImage {
    _selectedPinImage = selectedPinImage;
    
    //Set selected image
    [_pinViewsArray makeObjectsPerformSelector:@selector(setHighlightedImage:)
                                    withObject:selectedPinImage];
}

#pragma mark - Responder
- (BOOL)becomeFirstResponder {
    [_fakeTextField becomeFirstResponder];
    return NO;
}

- (BOOL)resignFirstResponder {
    [_fakeTextField resignFirstResponder];
    return NO;
}

#pragma mark - UITextField
- (void)textFieldTextChanged:(UITextField *)textField {
    //Trimmed text
    textField.text = [self trimmedStringWithMaxLenght:textField.text];
    
    _pinCode = textField.text;
    
    //Colorize pins
    [self colorizePins];
    
    //Notify delegate if needed
    [self checkForEnteredPin];
}

- (void)setPinCode:(NSString *)pinCode {
    //Trimmed text
    NSString *enteredCode = [self trimmedStringWithMaxLenght:pinCode];
    
    _pinCode = enteredCode;
    _fakeTextField.text = enteredCode;
    
    //Colorize pins
    [self colorizePins];
    
    //Notify delegate if needed
    [self checkForEnteredPin];
}

#pragma mark - ColorizeViews
- (void)colorizePins {
    NSInteger pinsEntered = self.pinCode.length;
    NSInteger itemsCount = _pinViewsArray.count;
    for (NSInteger i = 0; i < itemsCount; i++) {
        UIImageView *pinImageView = _pinViewsArray[i];
        pinImageView.highlighted = i < pinsEntered;
    }
}

#pragma mark - Delegate
- (void)checkForEnteredPin {
    if (self.pinCode.length == kDefinedPinsCount) {
        if ([self.delegate respondsToSelector:@selector(pinCodeView:didEnterPin:)]) {
            [self.delegate pinCodeView:self didEnterPin:self.pinCode];
        }
    }
}

#pragma mark - Gestures
- (void)tapGestureOccured:(UITapGestureRecognizer *)tapGesture {
    [self becomeFirstResponder];
}

#pragma mark - Helpers
- (NSString *)trimmedStringWithMaxLenght:(NSString *)sourceString {
    if (sourceString.length > kDefinedPinsCount) {
        sourceString = [sourceString substringToIndex:kDefinedPinsCount];
    }
    return sourceString;
}

@end
