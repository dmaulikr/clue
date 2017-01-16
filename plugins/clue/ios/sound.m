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

clue_sound_error_t clue_sound_get_error(void)
{
	return alGetError();
}

void clue_sound_set_volume(float volume)
{
	alListenerf(AL_GAIN, volume);
}

float clue_sound_get_volume(void)
{
	ALfloat volume;
	alGetListenerf(AL_GAIN, &volume);
	return volume;
}

clue_sound_buffer_t clue_sound_buffer_create(void* data, size_t data_size)
{
	clue_sound_buffer_t buffer;
	alGenBuffers(1, &buffer);
	
	alBufferData(buffer, AL_FORMAT_MONO16, data, (ALsizei)data_size, 44100);
	
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
	
	if (alGetError() != AL_NO_ERROR) return CLUE_SOUND_CHANNEL_INVALID;
	
	return channel;
}

void clue_sound_channel_destroy(clue_sound_channel_t channel)
{
	if (channel == CLUE_SOUND_CHANNEL_INVALID) return;
	alDeleteSources(1, &channel);
}

bool clue_sound_channel_is_playing(clue_sound_channel_t channel)
{
	if (channel == CLUE_SOUND_CHANNEL_INVALID) return false;
	
	ALint state;
	alGetSourcei(channel, AL_SOURCE_STATE, &state);
	return state == AL_PLAYING;
}

void clue_sound_channel_set_loop(clue_sound_channel_t channel, bool loop)
{
	if (channel == CLUE_SOUND_CHANNEL_INVALID) return;
	alSourcei(channel, AL_LOOPING, loop ? 1 : 0);
}

void clue_sound_channel_set_volume(clue_sound_channel_t channel, float volume)
{
	if (channel == CLUE_SOUND_CHANNEL_INVALID) return;
	alSourcef(channel, AL_GAIN, volume);
}

void clue_sound_channel_set_buffer(clue_sound_channel_t channel, clue_sound_buffer_t buffer)
{
	if (channel == CLUE_SOUND_CHANNEL_INVALID) return;
	alSourcei(channel, AL_BUFFER, buffer);
}

void clue_sound_channel_play(clue_sound_channel_t channel)
{
	if (channel == CLUE_SOUND_CHANNEL_INVALID) return;
	alSourceStop(channel);
	alSourceRewind(channel);
	alSourcePlay(channel);
}

void clue_sound_channel_stop(clue_sound_channel_t channel)
{
	if (channel == CLUE_SOUND_CHANNEL_INVALID) return;
	alSourceStop(channel);
}

void clue_sound_channel_pause(clue_sound_channel_t channel)
{
	if (channel == CLUE_SOUND_CHANNEL_INVALID) return;
	alSourcePause(channel);
}

void clue_sound_channel_resume(clue_sound_channel_t channel)
{
	if (channel == CLUE_SOUND_CHANNEL_INVALID) return;
	alSourcePlay(channel);
}
