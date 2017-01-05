#ifndef CLUE_H
#define CLUE_H

#include <OpenGLES/ES2/gl.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Required hooks. */
void clue_hook_setup(void);
void clue_hook_loaded(void);
void clue_hook_update(double deltaTime);
void clue_hook_render(void);
void clue_hook_teardown(void);

typedef void (*clue_hook_t)(void);

/* Optional hooks. If desired, assign during clue_hook_setup(). */
extern clue_hook_t clue_hook_will_become_inactive;
extern clue_hook_t clue_hook_did_become_inactive;
extern clue_hook_t clue_hook_will_become_active;
extern clue_hook_t clue_hook_did_become_active;
extern clue_hook_t clue_hook_will_terminate;

/* iOS-specific hooks. */
extern clue_hook_t clue_ios_hook_memory_warning;

#define CLUE_HOOK_INVOKE(hook, ...) do { if (clue_hook_##hook) clue_hook_##hook(__VA_ARGS__); } while (false)
#define CLUE_HOOK_DEFINE(hook, impl) do { clue_hook_##hook = impl; } while (false)

#ifdef __cplusplus
}
#endif

#endif
