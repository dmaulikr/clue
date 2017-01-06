#ifndef CLUE_TOUCH_H
#define CLUE_TOUCH_H

#include <stddef.h>

#include "clue/internal.h"

CLUE_BEGIN_C

typedef struct clue_touch
{
	uint8_t index;
	float x;
	float y;
	float force;
	float maximumPossibleForce;
} clue_touch_t;

void clue_hook_touch_down(const clue_touch_t* touch);
void clue_hook_touch_move(const clue_touch_t* touch);
void clue_hook_touch_up(const clue_touch_t* touch);

CLUE_END_C

#endif
