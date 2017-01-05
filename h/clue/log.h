#ifndef CLUE_LOG_H
#define CLUE_LOG_H

#include <stdlib.h>
#include <stddef.h>
#include <stdio.h>

#include "clue/internal.h"

#define CLUE_LOG(channel, str, ...) do { if (CLUE_LOG_##channel) {	\
	size_t size = snprintf(NULL, 0, str, __VA_ARGS__);				\
	char* buffer = (char*)malloc(size + 1);								\
	snprintf(buffer, size + 1, str, __VA_ARGS__);					\
	clue_log(#channel, buffer);												\
	free(buffer);													\
} } while (false)

#ifndef CLUE_LOG_DEFAULT
#define CLUE_LOG_DEFAULT 1
#endif

CLUE_BEGIN_C

void clue_log(const char* channel, const char* str);

CLUE_END_C

#endif
