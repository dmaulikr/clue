#include "clue/clue.h"

CLUE_EXTERN void clue_hook_before_start(void)
{
}

CLUE_EXTERN void clue_hook_start(void)
{
	clue_sound_start();
	
	clue_sound_channel_t channel = clue_sound_channel_create();
	clue_sound_buffer_t buffer = clue_sound_buffer_create(NULL, 0);
	
	clue_sound_channel_set_buffer(channel, buffer);
	clue_sound_channel_set_loop(channel, true);
	
	clue_sound_channel_play(channel);
}

CLUE_EXTERN void clue_hook_stop(void)
{
	clue_sound_stop();
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
