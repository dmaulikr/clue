#include "clue/log.h"

#include <android/log.h>

void clue_log(const char* channel, const char* str)
{
	__android_log_print(ANDROID_LOG_INFO, channel, "CLUE_LOG_%s: %s", channel, str);
}
