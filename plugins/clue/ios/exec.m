#include "clue/exec.h"

#import <UIKit/UIApplication.h>
#import <Foundation/NSURL.h>

void clue_exec(const char* url)
{
	NSURL* urlObj = [NSURL URLWithString:[NSString stringWithUTF8String:url]];
	NSDictionary* options = [[NSDictionary alloc] init];
	[UIApplication.sharedApplication openURL:urlObj options:options completionHandler:nil];
}
