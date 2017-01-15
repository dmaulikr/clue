#include "clue/sound.h"

#include <OpenAl/al.h>
#include <OpenAl/alc.h>

ALCdevice* clue_alc_device = NULL;
ALCcontext* clue_alc_context = NULL;

void clue_sound_start(void)
{
	clue_alc_device = alcOpenDevice(NULL);
	
	clue_alc_context = alcCreateContext(clue_alc_device, NULL);
	alcMakeContextCurrent(clue_alc_context);
}

void clue_sound_stop(void)
{
	alcMakeContextCurrent(NULL);
	alcDestroyContext(clue_alc_context);
	alcCloseDevice(clue_alc_device);
}

clue_sound_buffer_t clue_sound_buffer_create(void* data, size_t data_size)
{
	clue_sound_buffer_t buffer;
	alGenBuffers(1, &buffer);
	
	alBufferData(buffer, AL_FORMAT_STEREO16, data, (ALsizei)data_size, 44100);
	
	return buffer;
}

void clue_sound_buffer_destroy(clue_sound_buffer_t buffer)
{
	alDeleteBuffers(1, &buffer);
}

clue_sound_channel_t clue_sound_channel_create(void)
{
	clue_sound_channel_t channel;
	alGenSources(1, &channel);
	return channel;
}

void clue_sound_channel_destroy(clue_sound_channel_t channel)
{
	alDeleteSources(1, &channel);
}

bool clue_sound_channel_is_playing(clue_sound_channel_t channel)
{
	ALint state;
	alGetSourcei(channel, AL_SOURCE_STATE, &state);
	return state == AL_PLAYING;
}

void clue_sound_channel_set_loop(clue_sound_channel_t channel, bool loop)
{
	alSourcei(channel, AL_LOOPING, loop ? 1 : 0);
}

void clue_sound_channel_set_volume(clue_sound_channel_t channel, float volume)
{
	alSourcef(channel, AL_GAIN, volume);
}

void clue_sound_channel_set_buffer(clue_sound_channel_t channel, clue_sound_buffer_t buffer)
{
	alSourcei(channel, AL_BUFFER, buffer);
}

void clue_sound_channel_play(clue_sound_channel_t channel)
{
	alSourcePlay(channel);
}

void clue_sound_channel_stop(clue_sound_channel_t channel)
{
	alSourceStop(channel);
}
