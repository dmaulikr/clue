#include <stddef.h>

#include "clue/hook.h"

clue_hook_t clue_hook_will_become_inactive = NULL;
clue_hook_t clue_hook_did_become_inactive = NULL;
clue_hook_t clue_hook_will_become_active = NULL;
clue_hook_t clue_hook_did_become_active = NULL;
clue_hook_t clue_hook_will_terminate = NULL;
clue_hook_str_t clue_hook_universal_link = NULL;
clue_hook_t clue_hook_share_complete = NULL;

/* iOS-specific hooks. */
clue_hook_t clue_hook_ios_memory_warning = NULL;
