#include "clue/screen.h"

#import "clue/ios/ViewController.h"
#import <UIKit/UIKit.h>

void clue_screen_get_size(float* w, float* h)
{
	CGRect screenBounds = UIScreen.mainScreen.bounds;
	// Using nativeScale so that we get the physical 1920x1080 instead of the virtual 2208x1242 on Plus devices. On non-Plus devices, nativeScale should be the same as scale. Furthermore, on simulated Plus devices, nativeScale is also the same as scale, rendering at a physical 2208x1242, which is different from real devices.
	CGFloat screenScale = UIScreen.mainScreen.nativeScale;
	if (w) *w = screenBounds.size.width * screenScale;
	if (h) *h = screenBounds.size.height * screenScale;
}

int clue_screen_get_framebuffer(void)
{
	ClueViewController* viewController = clue_ios_get_view_controller();
	return viewController.glFramebuffer;
}
