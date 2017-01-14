#ifndef CLUE_LOG_H
#define CLUE_LOG_H

#include "clue/internal.h"

#include <stdlib.h>
#include <stdio.h>

#define CLUE_LOG_IDENTITY(...) __VA_ARGS__
#define CLUE_LOG_CALL(a, b) a b

/*
Support for alternative invocation using nested parenthesis:
	CLUE_LOG_ALT(DEFAULT, ("%s", "foo"));
*/
#define CLUE_LOG_ALT(channel, args) CLUE_LOG(channel, CLUE_LOG_CALL(CLUE_LOG_IDENTITY, args))

#define CLUE_LOG(channel, ...) do { if (CLUE_LOG_##channel) {	\
	size_t size = snprintf(NULL, 0, __VA_ARGS__);				\
	char* buffer = (char*)malloc(size + 1);						\
	snprintf(buffer, size + 1, __VA_ARGS__);					\
	clue_log(#channel, buffer);									\
	free(buffer);												\
} } while (false)

#ifndef CLUE_LOG_DEFAULT
#define CLUE_LOG_DEFAULT 1
#endif

CLUE_BEGIN_C

void clue_log(const char* channel, const char* str);

CLUE_END_C

#endif
