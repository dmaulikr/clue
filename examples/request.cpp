#include "clue/clue.h"

#include <cstring>

namespace
{
	void handle_response(const clue_response_t* resp, void* user)
	{
		if (resp->error)
		{
			CLUE_LOG(DEFAULT, "Response error: %s", resp->error);
		}
		else
		{
			CLUE_LOG(DEFAULT, "Response success: HTTP %u", (uint32_t)resp->code);
			CLUE_LOG(DEFAULT, "Headers: %s", resp->headers);
			if (resp->body) CLUE_LOG(DEFAULT, "Body: %.*s", (int)resp->body_size, resp->body);
			else CLUE_LOG(DEFAULT, "No body!");
		}
	}
}

CLUE_EXTERN void clue_hook_before_start(void)
{
}

CLUE_EXTERN void clue_hook_start(void)
{
	clue_request_t req;
	clue_request_init(&req);
	req.method = "POST";
	req.url = "https://httpbin.org/post";
	req.headers = "Authorization: Bearer foo\nContent-Type: application/json";
	req.body = "{ \"foo\": \"bar\" }";
	req.body_size = (size_t)strlen((const char*)req.body);
	void* handle = clue_request_send(&req, handle_response, NULL);
	clue_request_finalize(handle);
}

CLUE_EXTERN void clue_hook_stop(void)
{
}

CLUE_EXTERN void clue_hook_update(double deltaTime)
{
}

CLUE_EXTERN void clue_hook_render(void)
{
	glClearColor(0.7f, 0.7f, 0.7f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}

CLUE_EXTERN void clue_hook_touch_down(const clue_touch_t* touch)
{
}

CLUE_EXTERN void clue_hook_touch_move(const clue_touch_t* touch)
{
}

CLUE_EXTERN void clue_hook_touch_up(const clue_touch_t* touch)
{
}
