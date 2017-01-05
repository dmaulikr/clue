#include "clue/clue.h"

namespace {
	float col = 0.0f;
	
	bool isActive = true;
}

extern "C" void example_will_become_inactive(void)
{
	isActive = false;
}

extern "C" void example_will_become_active(void)
{
	isActive = true;
}

extern "C" void clue_hook_setup(void)
{
	CLUE_HOOK_DEFINE(will_become_inactive, example_will_become_inactive);
	CLUE_HOOK_DEFINE(will_become_active, example_will_become_active);
}

extern "C" void clue_hook_loaded(void)
{
}

extern "C" void clue_hook_update(double deltaTime)
{
	float dt = (float)deltaTime;
	col += dt;
	if (col >= 3.0f) col = 0.0f;
}

extern "C" void clue_hook_render(void)
{
	float r = col > 1.0f ? 1.0f : col;
	float g = col > 2.0f ? 1.0f : col - 1.0f;
	float b = col > 3.0f ? 1.0f : col - 2.0f;
	glClearColor(r, g, b, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}

extern "C" void clue_hook_teardown(void)
{
}
