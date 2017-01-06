#include "clue/log.h"

#import <Foundation/NSObjCRuntime.h>

void clue_log(const char* channel, const char* str)
{
	NSLog(@"CLUE_LOG_%s: %s", channel, str);
}
