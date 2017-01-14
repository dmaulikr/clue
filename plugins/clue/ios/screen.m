#include "clue/screen.h"

#import <UIKit/UIKit.h>

void clue_get_screen_size(float* w, float* h)
{
	CGRect screenBounds = UIScreen.mainScreen.bounds;
	if (w) *w = screenBounds.size.width;
	if (h) *h = screenBounds.size.height;
}