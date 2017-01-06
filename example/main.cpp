#include "clue/clue.h"

namespace
{
	float col = 0.0f;
	bool isActive = true;
}

CLUE_EXTERN void example_will_become_inactive(void)
{
	isActive = false;
}

CLUE_EXTERN void example_will_become_active(void)
{
	isActive = true;
}

CLUE_EXTERN void clue_hook_setup(void)
{
	CLUE_HOOK_DEFINE(will_become_inactive, example_will_become_inactive);
	CLUE_HOOK_DEFINE(will_become_active, example_will_become_active);
}

CLUE_EXTERN void clue_hook_loaded(void)
{
	CLUE_LOG(DEFAULT, "Application loaded!");
	CLUE_LOG(DEFAULT, "Read dir: %s", clue_get_read_dir());
	CLUE_LOG(DEFAULT, "User write dir: %s", clue_get_user_write_dir());
	CLUE_LOG(DEFAULT, "App write dir: %s", clue_get_app_write_dir());
	CLUE_LOG(DEFAULT, "Temp write dir: %s", clue_get_temp_write_dir());
}

CLUE_EXTERN void clue_hook_update(double deltaTime)
{
	float dt = (float)deltaTime;
	col += dt;
	if (col >= 3.0f) col = 0.0f;
}

CLUE_EXTERN void clue_hook_render(void)
{
	float r = col > 1.0f ? 1.0f : col;
	float g = col > 2.0f ? 1.0f : col - 1.0f;
	float b = col > 3.0f ? 1.0f : col - 2.0f;
	glClearColor(r, g, b, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}

CLUE_EXTERN void clue_hook_teardown(void)
{
}

CLUE_EXTERN void clue_hook_touch_down(const clue_touch_t* touch)
{
	CLUE_LOG(DEFAULT, "down %lu (%f, %f) f %f", touch->index, touch->x, touch->y, touch->force);
}

CLUE_EXTERN void clue_hook_touch_move(const clue_touch_t* touch)
{
	CLUE_LOG(DEFAULT, "move %lu (%f, %f) f %f", touch->index, touch->x, touch->y, touch->force);
}

CLUE_EXTERN void clue_hook_touch_up(const clue_touch_t* touch)
{
	CLUE_LOG(DEFAULT, "up %lu (%f, %f) f %f", touch->index, touch->x, touch->y, touch->force);
}
