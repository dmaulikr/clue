#include "clue/file.h"

#import "clue/ios/AppDelegate.h"

#include <stddef.h>

const char* clue_get_read_dir(void)
{
	ClueAppDelegate* appDelegate = clue_ios_get_app_delegate();
	return appDelegate ? [appDelegate.readDir UTF8String] : NULL;
}

const char* clue_get_user_write_dir(void)
{
	ClueAppDelegate* appDelegate = clue_ios_get_app_delegate();
	return appDelegate ? [appDelegate.userWriteDir UTF8String] : NULL;
}

const char* clue_get_app_write_dir(void)
{
	ClueAppDelegate* appDelegate = clue_ios_get_app_delegate();
	return appDelegate ? [appDelegate.appWriteDir UTF8String] : NULL;
}

const char* clue_get_temp_write_dir(void)
{
	ClueAppDelegate* appDelegate = clue_ios_get_app_delegate();
	return appDelegate ? [appDelegate.tempWriteDir UTF8String] : NULL;
}
