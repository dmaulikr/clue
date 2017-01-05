#import <UIKit/UIKit.h>

#import "AppDelegate.h"

#include "clue/clue.h"

int main(int argc, char * argv[]) {
	@autoreleasepool {
		clue_hook_setup();
	    int ret = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
		clue_hook_teardown();
		return ret;
	}
}
