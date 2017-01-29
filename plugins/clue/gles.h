#ifndef CLUE_GLES_H
#define CLUE_GLES_H

#if defined(__APPLE__) && TARGET_OS_IOS
	#include <OpenGLES/ES2/gl.h>
#elif defined(__ANDROID__)
	#include <GLES2/gl2.h>
	#include <GLES2/gl2ext.h>
#endif

#endif
