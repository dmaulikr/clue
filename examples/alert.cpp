#include "clue/clue.h"

#include <cstring>

namespace
{
	const char* alert_buttons[3] = { "Foo", "Bar", "OK" };
	size_t alert_buttons_size = 3;
	
	void alert_button_callback(size_t index, void* user)
	{
		CLUE_LOG(DEFAULT, "Pressed button: %s", alert_buttons[index]);
	}
	
	void alert_complete_callback(void* user)
	{
		CLUE_LOG(DEFAULT, "Alert complete!");
	}
}

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
	char* message = NULL;
	CLUE_LOG_PRINTF(message, "(%f, %f)", touch->nx, touch->ny);
	clue_alert("Touch Up", message, alert_buttons, alert_buttons_size, alert_button_callback, alert_complete_callback, NULL);
	free(message);
}
