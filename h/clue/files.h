#ifndef CLUE_FILES_H
#define CLUE_FILES_H

#include "clue/internal.h"

CLUE_BEGIN_C

const char* clue_get_read_dir(void);
const char* clue_get_user_write_dir(void);
const char* clue_get_app_write_dir(void);
const char* clue_get_temp_write_dir(void);

CLUE_END_C

#endif
