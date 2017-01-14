#ifndef CLUE_TOUCH_H
#define CLUE_TOUCH_H

#include "clue/internal.h"

#include <stdlib.h>

CLUE_BEGIN_C

typedef struct
{
	size_t index;
	float x;
	float y;
	float nx;
	float ny;
	float force;
	float maximumPossibleForce;
} clue_touch_t;

void clue_hook_touch_down(const clue_touch_t* touch);
void clue_hook_touch_move(const clue_touch_t* touch);
void clue_hook_touch_up(const clue_touch_t* touch);

CLUE_END_C

#endif
