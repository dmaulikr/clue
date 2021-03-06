#include "clue/hook.h"

#import "clue/ios/AppDelegate.h"
#import "clue/ios/ViewController.h"

ClueAppDelegate* clue_ios_get_app_delegate(void)
{
	return (ClueAppDelegate*)UIApplication.sharedApplication.delegate;
}

NSString* clue_ios_append_slash(NSString* str)
{
	if ([str characterAtIndex:str.length - 1] != '/')
	{
		return [str stringByAppendingString:@"/"];
	}
	
	return str;
}

NSString* clue_ios_get_dir(NSSearchPathDirectory dir)
{
	NSFileManager* fm = NSFileManager.defaultManager;
	
	// https://developer.apple.com/library/content/technotes/tn2406/_index.html
	NSString* path = [fm URLsForDirectory:dir inDomains:NSUserDomainMask].lastObject.path;
	
	if (![fm fileExistsAtPath:path isDirectory:nil])
	{
		NSError* error = nil;

		if (![fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error])
		{
			return nil;
		}
	}
	
	return clue_ios_append_slash(path);
}

NSString* clue_ios_get_read_dir()
{
	return clue_ios_append_slash(NSBundle.mainBundle.resourcePath);
}

@implementation ClueAppDelegate

- (id)init
{
	self = [super init];
	
	if (self)
	{
		self.readDir = clue_ios_get_read_dir();
		
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
    self.window.rootViewController = [[ClueViewController alloc] init];
    [self.window makeKeyAndVisible];
	
	clue_hook_start();
	
	return YES;
}

- (BOOL)application:(UIApplication*)application
	continueUserActivity:(NSUserActivity*)userActivity
	restorationHandler:(void(^)(NSArray* restorableObjects))restorationHandler
{
	if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb])
	{
		NSString* url = userActivity.webpageURL.absoluteString;
		CLUE_HOOK_INVOKE(universal_link, url.UTF8String);
	}
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
	clue_hook_stop();
}

@end
