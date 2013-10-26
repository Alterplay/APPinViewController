APPinViewController
=======================

Easy drop-in component for iOS developers to deal easy with PIN (4 digit passcode) logic. 
This is the first version but we truly tried to make it reusable and customizable enough to save development time.

###How to Use:
1) Subclass APPinViewController:

    @interface SamplePinViewController : APPinViewController
    
2) Bind your APPinView with File Owner's 'pinCodeView' in Xib on StoryBoard. ([How to do it?](https://dl.dropboxusercontent.com/u/11819370/APPin/screen.png))

..and this is it.

####To Set PIN:
    SamplePinViewController *pinVC = [SamplePinViewController new];
    [self.navigationController pushViewController:pinVC animated:YES];

Delegate:

    - (void)pinCodeViewController:(APPinViewController *)controller didCreatePinCode:(NSString *)pinCode {
        //Handle your pin code here
        //
        [self.navigationController popViewControllerAnimated:YES];
    }
    
####To Verify PIN:

    SamplePinViewController *pinVC = [SamplePinViewController new];
    pinVC.pinCodeToCheck = <#Your Pin To Verify#>;
    [self.navigationController pushViewController:pinVC animated:YES];
    
Delegate:

    - (void)pinCodeViewController:(APPinViewController *)controller didVerifiedPincodeSuccessfully:(NSString *)pinCode {
        //Pin code verified
        [self.navigationController popViewControllerAnimated:YES];
    }
    
####To Change PIN:

    SamplePinViewController *pinVC = [SamplePinViewController new];
    pinVC.pinCodeToCheck = <#Your Pin To Change#>;
    pinVC.shouldResetPinCode = YES;
    [self.navigationController pushViewController:pinVC animated:YES];
    
Delegate:

    - (void)pinCodeViewController:(APPinViewController *)controller didChangePinCode:(NSString *)pinCode {
        //Handle your new pin code here
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
#### To Handle Unsuccessful Attempts:

    - (void)pinCodeViewController:(APPinViewController *)controller didFailVerificationWithCount:(NSUInteger)failsCount;

####...and One More Thing:
You can feel free to customize pin view by changing its frame and position and set image for pins:

    self.pinCodeView.selectedPinImage = <#Your UIImage#>
    self.pinCodeView.normalPinImage = <#Your UIImage#>

If you have improvements or concerns, feel free to post [an issue](https://github.com/Alterplay/APPinViewController/issues) and write details.

=======================
*[Check out](https://github.com/Alterplay) all Alterplay's GitHub projects.*
*[Email us](mailto:hello@alterplay.com?subject=From%20GitHub%20APPinViewController) with other ideas and projects.*
