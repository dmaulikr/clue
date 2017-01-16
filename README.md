# clue

C glue for iOS and Android games written in C/C++.

---

Instead of writing your own Objective-C and Java to glue your cross-platform C/C++ to iOS and Android, use clue.

clue takes the stupid-simple approach, which results in numerous benefits:

- No libraries to compile or link. clue is included and compiled directly as part of your project.
- No project file abstractions. With clue, you have an Xcode project for iOS and an Android Studio project for Android. Both projects simply reference your shared C/C++ code and the platform-specific clue code.
- No complex plugins architecture. Including clue wrappers of platform-specific libraries is as simple as including clue itself.
- Debugging is completely native to the platform. Step directly into your native C/C++ code as well as the platform-specific clue code.

This is what a minimal clue project looks like:

```cpp
#include "clue/clue.h"

CLUE_EXTERN void clue_hook_before_start(void)
{
}

CLUE_EXTERN void clue_hook_start(void)
{
	game->start();
}

CLUE_EXTERN void clue_hook_stop(void)
{
	game->stop();
}

CLUE_EXTERN void clue_hook_update(double deltaTime)
{
	game->update(deltaTime);
}

CLUE_EXTERN void clue_hook_render(void)
{
	glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	game->render();
}

CLUE_EXTERN void clue_hook_touch_down(const clue_touch_t* touch)
{
	game->on_touch_down(touch->id, touch->x, touch->y);
}

CLUE_EXTERN void clue_hook_touch_move(const clue_touch_t* touch)
{
	game->on_touch_move(touch->id, touch->x, touch->y);
}

CLUE_EXTERN void clue_hook_touch_up(const clue_touch_t* touch)
{
	game->on_touch_up(touch->id, touch->x, touch->y);
}
```

See examples directory for more examples.

Alternatives to clue include:

- Marmalade SDK: Originally discontinued, then sold to GMO CLOUD K.K. At the time of writing, Marmalade's future is completely unknown, which is why I've jumped ship and started clue.
- SDL2: Great cross-platform framework. Far more features than clue, but much more cumbersome to work with for iOS and Android.
- Unreal Engine: Amazing engine, but not a good fit if you have a custom game engine and/or renderer.
- Unity: Unity does support C/C++, but just like Unreal, it's not a good fit for an existing codebase.
- Cocos2d-x: Another cross-platform game engine. Again, not a good fit for an existing codebase.
