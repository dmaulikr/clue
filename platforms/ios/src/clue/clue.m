#include <stddef.h>

#include "clue/hooks.h"

clue_hook_t clue_hook_will_become_inactive = NULL;
clue_hook_t clue_hook_did_become_inactive = NULL;
clue_hook_t clue_hook_will_become_active = NULL;
clue_hook_t clue_hook_did_become_active = NULL;
clue_hook_t clue_hook_will_terminate = NULL;

/* iOS-specific hooks. */
clue_hook_t clue_ios_hook_memory_warning = NULL;
