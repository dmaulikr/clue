#ifndef CLUE_SOUND_H
#define CLUE_SOUND_H

#include "clue/internal.h"

#include <stdlib.h>
#include <stdbool.h>

CLUE_BEGIN_C

typedef uint32_t clue_sound_buffer_t;
typedef uint32_t clue_sound_channel_t;

void clue_sound_start(void);
void clue_sound_stop(void);

clue_sound_buffer_t clue_sound_buffer_create(void* data, size_t data_size);
void clue_sound_buffer_destroy(clue_sound_buffer_t buffer);

clue_sound_channel_t clue_sound_channel_create(void);
void clue_sound_channel_destroy(clue_sound_channel_t channel);

bool clue_sound_channel_is_playing(clue_sound_channel_t channel);
void clue_sound_channel_set_loop(clue_sound_channel_t channel, bool loop);
void clue_sound_channel_set_volume(clue_sound_channel_t channel, float volume);
void clue_sound_channel_set_buffer(clue_sound_channel_t channel, clue_sound_buffer_t buffer);

void clue_sound_channel_play(clue_sound_channel_t channel);
void clue_sound_channel_stop(clue_sound_channel_t channel);

CLUE_END_C

#endif
