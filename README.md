APPinViewController
=======================

Easy drop-in component for iOS developers to deal easy with pin code logic. 
We've tried to make make it reusable and customizable to save development time in our projects.

####How to use:
1). Subclass APPinViewController:

    @interface SamplePinViewController : APPinViewController
    
2). Bind your APPinView with File Owner's 'pinCodeView' in Xib on StoryBoard. [Link](https://dl.dropboxusercontent.com/u/11819370/APPin/screen.png)

..and this is it.

###To set pin:
    SamplePinViewController *pinVC = [SamplePinViewController new];
    [self.navigationController pushViewController:pinVC animated:YES];

Delegate:

    - (void)pinCodeViewController:(APPinViewController *)controller didCreatePinCode:(NSString *)pinCode {
        //Handle your pin code here
        //
        [self.navigationController popViewControllerAnimated:YES];
    }
    
###To verify pin:

    SamplePinViewController *pinVC = [SamplePinViewController new];
    pinVC.pinCodeToCheck = <#Your Pin To Verify#>;
    [self.navigationController pushViewController:pinVC animated:YES];
    
Delegate:

    - (void)pinCodeViewController:(APPinViewController *)controller didVerifiedPincodeSuccessfully:(NSString *)pinCode {
        //Pin code verified
        [self.navigationController popViewControllerAnimated:YES];
    }
    
###To Change pin:

    SamplePinViewController *pinVC = [SamplePinViewController new];
    pinVC.pinCodeToCheck = <#Your Pin To Change#>;
    pinVC.shouldResetPinCode = YES;
    [self.navigationController pushViewController:pinVC animated:YES];
    
Delegate:

    - (void)pinCodeViewController:(APPinViewController *)controller didChangePinCode:(NSString *)pinCode {
        //Handle your new pin code here
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
### To handle unsuccessful attempts:

    - (void)pinCodeViewController:(APPinViewController *)controller didFailVerificationWithCount:(NSUInteger)failsCount;

####...and one more thing.
You can feel free to customize pin view by changing its frame and position and set image for pins:

    self.pinCodeView.selectedPinImage = <#Your UIImage#>
    self.pinCodeView.normalPinImage = <#Your UIImage#>
