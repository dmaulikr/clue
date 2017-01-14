#import <OpenAl/al.h>
#import <OpenAl/alc.h>

#include "clue/clue.h"

CLUE_EXTERN void clue_hook_before_start(void)
{
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
}
