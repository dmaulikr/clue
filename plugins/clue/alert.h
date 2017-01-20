#ifndef CLUE_ALERT_H
#define CLUE_ALERT_H

#include "clue/internal.h"

#include <stdlib.h>

CLUE_BEGIN_C

typedef void (*clue_alert_button_callback_t)(size_t index, void* user);
typedef void (*clue_alert_complete_callback_t)(void* user);

void clue_alert(
	const char* title,
	const char* message,
	const char** buttons,
	size_t buttons_size,
	clue_alert_button_callback_t button_callback,
	clue_alert_complete_callback_t complete_callback,
	void* user
);

CLUE_END_C

#endif
