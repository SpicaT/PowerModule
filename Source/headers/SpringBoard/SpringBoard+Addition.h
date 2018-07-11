#import <SpringBoard/SpringBoard.h>

@interface SBRestartManager : NSObject
- (void)restartWithTransitionRequest:(id)arg1;
@end

@interface SBRestartTransitionRequest : NSObject
@property(nonatomic) int restartType;
- (instancetype)initWithRequester:(id)arg1 reason:(id)arg2;
@property(nonatomic) double delay;
@end

@interface SpringBoard (Addition)
@property(readonly, nonatomic) SBRestartManager *restartManager;
@end