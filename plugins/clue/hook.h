#ifndef CLUE_HOOKS_H
#define CLUE_HOOKS_H

#include "clue/internal.h"

CLUE_BEGIN_C

/* Required hooks. */
void clue_hook_before_start(void);
void clue_hook_start(void);
void clue_hook_stop(void);

void clue_hook_update(double deltaTime);
void clue_hook_render(void);

typedef void (*clue_hook_t)(void);
typedef void (*clue_hook_str_t)(const char*);

/* Optional hooks. If desired, assign during clue_hook_setup(). */
extern clue_hook_t clue_hook_will_become_inactive;
extern clue_hook_t clue_hook_did_become_inactive;
extern clue_hook_t clue_hook_will_become_active;
extern clue_hook_t clue_hook_did_become_active;
extern clue_hook_str_t clue_hook_universal_link;

/* iOS-specific hooks. */
extern clue_hook_t clue_hook_ios_memory_warning;

#define CLUE_HOOK_INVOKE(hook, ...) do { if (clue_hook_##hook) clue_hook_##hook(__VA_ARGS__); } while (false)
#define CLUE_HOOK_DEFINE(hook, impl) do { clue_hook_##hook = impl; } while (false)

CLUE_END_C

#endif
