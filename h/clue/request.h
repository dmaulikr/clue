#ifndef CLUE_REQUEST_H
#define CLUE_REQUEST_H

#include "clue/internal.h"

#include <stdlib.h>

CLUE_BEGIN_C

typedef struct
{
	const char* method;
	const char* url;
	const char* headers;
	const char* body;
} clue_request_t;

typedef struct
{
	uint16_t code;
	const char* headers;
	const char* body;
} clue_response_t;

typedef void (*clue_request_callback_t)(const clue_response_t* resp, void* user);

void clue_request(const clue_request_t* req, clue_request_callback_t callback, void* user);

CLUE_END_C

#endif
