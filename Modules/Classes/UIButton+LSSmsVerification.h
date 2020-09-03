#import <UIKit/UIKit.h>

@interface UIButton (LSSmsVerification)

//剩余时间
@property (copy, nonatomic) NSNumber *residueTime;

/**
 *  获取短信验证码倒计时
 *
 *  @param duration 倒计时时间
 */
- (void)startTimeWithDuration:(NSInteger)duration;

@end
