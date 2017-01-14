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
	const void* body;
	size_t body_size;
} clue_request_t;

typedef struct
{
	uint16_t code;
	const char* headers;
	const void* body;
	size_t body_size;
	const char* error;
} clue_response_t;

typedef void (*clue_request_callback_t)(const clue_response_t* resp, void* user);

void clue_request_init(clue_request_t* req);
void clue_response_init(clue_response_t* resp);

void* clue_request_send(const clue_request_t* req, clue_request_callback_t callback, void* user);
void clue_request_cancel(void* handle);
void clue_request_finalize(void* handle);

CLUE_END_C

#endif
