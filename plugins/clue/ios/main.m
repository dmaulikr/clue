#include "clue/clue.h"

#import "clue/ios/AppDelegate.h"
#import <UIKit/UIKit.h>

int main(int argc, char* argv[])
{
	@autoreleasepool
	{
		clue_hook_before_start();
		int ret = UIApplicationMain(argc, argv, nil, NSStringFromClass([ClueAppDelegate class]));
		return ret;
	}
}
