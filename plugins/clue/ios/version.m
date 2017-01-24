#include "version.h"

#import <Foundation/NSBundle.h>

const char* clue_version(void)
{
	NSString* version = [NSBundle.mainBundle.infoDictionary objectForKey:@"CFBundleShortVersionString"];
	return version.UTF8String;
}
