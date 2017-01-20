#include "clue/clue.h"

#include <cstring>

namespace
{
	bool share_complete = false;
	void share_complete_callback()
	{
		share_complete = true;
	}
}

CLUE_EXTERN void clue_hook_before_start(void)
{
	CLUE_HOOK_DEFINE(share_complete, share_complete_callback);
}

CLUE_EXTERN void clue_hook_start(void)
{
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
	clue_share("Example text.", "https://example.com", touch->nx, touch->ny);
}
