#include "clue/clue.h"

#import "AppDelegate.h"
#import <UIKit/UIKit.h>

int main(int argc, char* argv[])
{
	@autoreleasepool
	{
		clue_hook_before_start();
	    int ret = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
		return ret;
	}
}
