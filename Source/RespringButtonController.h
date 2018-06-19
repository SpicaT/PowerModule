#import <ControlCenterUIKit/CCUILabeledRoundButtonViewController.h>

@interface RespringButtonController : CCUILabeledRoundButtonViewController
//the width of the module, set by the moduleViewController in it's viewDidLoadSubview method
@property CGFloat mWidth;

@property BOOL isExpanded;
//resprings the device
-(void)respring;
@end
