cmake_minimum_required(VERSION 3.4.1)

file(GLOB CLUE_GENERIC_SRC ../../plugins/clue/*.c)
file(GLOB CLUE_ANDROID_SRC ../../plugins/clue/android/*.c)

add_library(clue SHARED ../../plugins/clue/android/clue.c
                        ../../plugins/clue/android/file.c
                        ../../plugins/clue/android/log.c
                        ../../plugins/clue/hook.c
                        ../../plugins/clue/request.c
                        ../basic.cpp)

# add lib dependencies
target_link_libraries(clue android log EGL GLESv2)
