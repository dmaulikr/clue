#include "platform.h"

#import "clue/ios/ViewController.h"

void* clue_platform_view(void)
{
	ClueViewController* viewController = clue_ios_get_view_controller();
	
	return (__bridge void*)viewController.view;
}
