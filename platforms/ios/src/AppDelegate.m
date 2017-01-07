#include "clue/hook.h"

#import "AppDelegate.h"
#import "ViewController.h"

AppDelegate* clue_ios_get_app_delegate(void)
{
	return (AppDelegate*)UIApplication.sharedApplication.delegate;
}

NSString* clue_ios_get_dir(NSSearchPathDirectory dir)
{
	// https://developer.apple.com/library/content/technotes/tn2406/_index.html
	return [NSFileManager.defaultManager URLsForDirectory:dir inDomains:NSUserDomainMask].lastObject.path;
}

@implementation AppDelegate

- (id)init
{
	self = [super init];
	
	if (self)
	{
		self.readDir = NSBundle.mainBundle.resourcePath;
		
		// https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html
		self.userWriteDir = clue_ios_get_dir(NSDocumentDirectory);
		self.appWriteDir = clue_ios_get_dir(NSApplicationSupportDirectory);
		self.tempWriteDir = clue_ios_get_dir(NSCachesDirectory);
	}
	
	return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = [[CustomViewController alloc] init];
    [self.window makeKeyAndVisible];
	
	clue_hook_loaded();
	
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	CLUE_HOOK_INVOKE(will_become_inactive);
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
	CLUE_HOOK_INVOKE(did_become_inactive);
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
	CLUE_HOOK_INVOKE(will_become_active);
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
	CLUE_HOOK_INVOKE(did_become_active);
}


- (void)applicationWillTerminate:(UIApplication *)application
{
	CLUE_HOOK_INVOKE(will_terminate);
}

@end
