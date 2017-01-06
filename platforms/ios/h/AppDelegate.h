#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString* readDir;
@property (strong, nonatomic) NSString* userWriteDir;
@property (strong, nonatomic) NSString* appWriteDir;
@property (strong, nonatomic) NSString* tempWriteDir;

@end

AppDelegate* clue_ios_get_app_delegate(void);
