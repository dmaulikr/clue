#include "clue/clue.h"

#include <fstream>
#include <string>
#include <vector>

namespace
{
	void read_file(std::string fileName, std::vector<uint8_t>& data)
	{
		std::string absFileName = std::string(clue_get_read_dir()) + fileName;
		std::ifstream file(absFileName.c_str(), std::ios::in | std::ios::binary);
		
		file.seekg(0, std::ios::end);
		size_t fileSize = (size_t)file.tellg();
		file.seekg(0, std::ios::beg);
		
		data.resize(fileSize);
		file.read((std::ifstream::char_type*)&data[0], fileSize);
		
		file.close();
	}
}

CLUE_EXTERN void clue_hook_before_start(void)
{
}

CLUE_EXTERN void clue_hook_start(void)
{
	std::vector<uint8_t> data;
	read_file("data/sound.snd", data);

	clue_sound_start();
	
	clue_sound_channel_t channel = clue_sound_channel_create();
	clue_sound_buffer_t buffer = clue_sound_buffer_create(&data[0], data.size());
	
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
