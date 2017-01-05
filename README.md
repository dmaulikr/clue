# clue

C glue for iOS and Android games written in C/C++.

Instead of writing your own Objective C and Java to glue your cross-platform C/C++ to iOS and Android, use clue.

clue takes the stupid-simple approach:

- No libraries to compile or link. clue is included and compiled directly as part of your project.
- No project file abstractions. With clue, you have an Xcode project for iOS and an Android Studio project for Android. Both projects simply reference the shared C/C++ code and the platform-specific clue code.
- No listeners, event loops, or other callback abstractions. clue callbacks are simply functions with C linkage that you must define in your project.

Thanks to these basic principles, you can write fully cross-platform C/C++ without sacrificing the ability to easily integrate platform-specific frameworks and tools.

Example clue project:

```cpp
#include "clue/clue.h"

extern "C" void clue_hook_setup(void)
{
	// Set up optional clue hooks for touches, application activity, etc.
}

extern "C" void clue_hook_loaded(void)
{
}

extern "C" void clue_hook_update(double deltaTime)
{
	// Do some updates based on deltaTime.
}

extern "C" void clue_hook_render(void)
{
	glClearColor(1.0f, 0.0f, 1.0f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}

extern "C" void clue_hook_teardown(void)
{
}
```

Alternatives to clue include:

- Marmalade SDK
- SDL2
- Unreal Engine

However, they all have drawbacks. Marmalade was discontinued and then acquired by a Japanese cloud computing firm, so its future is completely unknown. SDL2 has a cumbersome build process for iOS and Android projects, and it becomes messy when integrating with native frameworks. Unreal Engine isn't feasible if you have a completely custom GLES renderer.
