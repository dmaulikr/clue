#ifndef CLUE_SOUND_H
#define CLUE_SOUND_H

#include "clue/internal.h"

#include <stdlib.h>
#include <stdbool.h>

CLUE_BEGIN_C

typedef uint32_t clue_sound_channel_t;

void clue_sound_start(void);

clue_sound_channel_t clue_sound_get_channel(void);
void clue_sound_play(clue_sound_channel_t channel, void* buffer, size_t buffer_size, bool loop);

CLUE_END_C

#endif
