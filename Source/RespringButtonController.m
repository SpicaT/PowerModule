#import "RespringButtonController.h"
#import <ControlCenterUIKit/CCUILabeledRoundButton.h>
#import <ControlCenterUIKit/CCUIRoundButton.h>
#import <SpringBoard/SpringBoard+Addition.h>

#define PLIST_PATH @"/var/mobile/Library/Preferences/com.muirey03.powermoduleprefs.plist"
#define prefsDict [NSDictionary dictionaryWithContentsOfFile:PLIST_PATH]

@implementation RespringButtonController
//here is where we set the width of the CCUILabeledRoundButton - the width of CCUIRoundButton is set automatically so we just use that to set the width of the CCUILabeledRoundButton
-(void)viewDidLayoutSubviews
{
    //this will be true if we are in the collapsed view, we don't want to position the buttons here if we are in the expanded view - that will be done in willTransitionToExpandedContentMode
    if (![self isExpanded] || self.view.window.bounds.size.width == 0)
    {
        //get the width of the CCUIRoundButton
        CGFloat bWidth = [[self buttonContainer] buttonView].frame.size.width;
        //this is the smaller distance (from the left of the module to the left of the top-left button)
        CGFloat leftF = ([self mWidth] - (2 * bWidth)) / 3;

        //each button is positioned differently - this one is the top-left - we also need to set the width here
        self.view.frame = CGRectMake(leftF, leftF, bWidth, bWidth);
    }

    //dirty ass fix for the background color being wrong:
    int i = 0;
    for (UIView* v in self.buttonContainer.buttonView.subviews)
    {
        if ([v isMemberOfClass:[NSClassFromString(@"MTMaterialView") class]])
        {
            v.alpha = i ? 0 : v.alpha;
            i++;
        }
    }
}

//this is what is called when the button is pressed, if you want to use it as a toggle, call [super buttonTapped:arg1]; - arg1 is where the button is selected or not
-(void)buttonTapped:(id)arg1
{
    if ([[prefsDict valueForKey:@"RespringConf"] boolValue])
    {
        UIAlertController* confirmation = [UIAlertController alertControllerWithTitle:@"Respring?" message:@"Are you sure you want to respring?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action)
        {
            [self respring];
        }];
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [confirmation addAction:actionOK];
        [confirmation addAction:cancel];
        [self presentViewController:confirmation animated:YES completion:nil];
    }
    else
    {
        [self respring];
    }
}

-(void)respring
{
    SpringBoard *springBoard = (SpringBoard *)[UIApplication sharedApplication];
    SBRestartTransitionRequest *request = [[NSClassFromString(@"SBRestartTransitionRequest") alloc] initWithRequester:@"PullToRespring" reason:@"Pulled"];
	request.delay = 0.5f;
	[springBoard.restartManager restartWithTransitionRequest:request];
}
@end
