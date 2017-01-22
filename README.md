# clue

C glue for cross-platform mobile games written in C/C++. Currently targeting iOS and Android, with WP8 and others down the line. Implemented as a set of cross-platform C headers and platform-specific implementation files.

---

Instead of writing your own Objective-C and Java to glue your cross-platform C/C++ to iOS and Android, use clue.

clue takes the stupid-simple approach, which results in numerous benefits:

- No libraries to compile or link. clue is included and compiled directly as part of your project.
- No project file abstractions. With clue, you have an Xcode project for iOS and an Android Studio project for Android. Both projects simply reference your shared C/C++ code and the platform-specific clue code.
- No complex plugins architecture. Including clue wrappers of platform-specific libraries is as simple as including clue itself.
- Debugging is completely native to the platform. Step directly into your native C/C++ code as well as the platform-specific clue code.

## Features and Abstractions

- Alert dialog.
- Trigger another app to open a link.
- Retrieve specific directories:
	- Read-only assets.
	- User data.
	- App data.
	- Temporary data.
- OpenGL ES (exposed as-is, no wrappers).
- Logging via `printf`-style macro.
- HTTPS requests for API consumption.
- Screen information.
- Share dialog.
- Sounds (OpenAL on iOS, OpenSL on Android).
- Touch events.

Since clue is currently undergoing heavy development, new features are being implemented every day. Abstractions of built-in features are part of the core clue repository, and abstractions of 3rd party SDKs are put into separate repositories (e.g. `clue-flurry`).

## Platforms

Current:

- iOS: In active development.
- Android: Due to personal priorities, will be started after the iOS implementation. Pull requests welcome!

Future:

- WP8: Very possible through the ANGLE project. Pull requests welcome.

## Example

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

clue handles all of the platform-specific code and calls your shared code. See examples directory for more examples.

## Alternatives to clue

- Marmalade SDK: Originally discontinued, then sold to GMO CLOUD K.K. At the time of writing, Marmalade's future is completely unknown, which is why I've jumped ship and started clue.
- SDL2: Great cross-platform framework, but its roots are not in mobile games. Although it supports iOS and Android, it's very cumbersome to work with (and extend) on these platforms.
- Unreal Engine: Amazing engine, but not a great fit if you have a custom game engine and/or renderer.
- Unity: Contrary to popular belief, Unity does support C/C++. However, just like Unreal, it's not a great fit for an existing codebase.
- Cocos2d-x: Another cross-platform C++ game engine. Same issue as Unreal and Unity.
