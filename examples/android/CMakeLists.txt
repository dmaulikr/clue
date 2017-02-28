cmake_minimum_required(VERSION 3.4.1)

include(cmake/clue_srcs.txt)

add_library(clue SHARED ${CLUE_SRCS} ../basic.cpp)

# add lib dependencies
target_link_libraries(clue android log EGL GLESv2)
