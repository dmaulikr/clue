#include "clue/screen.h"

#import "clue/ios/ViewController.h"
#import <UIKit/UIKit.h>

void clue_screen_get_size(float* w, float* h)
{
	CGRect screenBounds = UIScreen.mainScreen.bounds;
	if (w) *w = screenBounds.size.width;
	if (h) *h = screenBounds.size.height;
}

int clue_screen_get_framebuffer(void)
{
	ClueViewController* viewController = clue_ios_get_view_controller();
	return viewController.glFramebuffer;
}
