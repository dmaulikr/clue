#include "clue/request.h"

#include <string.h>

void clue_request_init(clue_request_t* req)
{
	req->method = NULL;
	req->url = NULL;
	req->headers = NULL;
	req->body = NULL;
	req->body_size = 0;
}

void clue_response_init(clue_response_t* resp)
{
	resp->code = 0;
	resp->headers = NULL;
	resp->body = NULL;
	resp->error = NULL;
}
