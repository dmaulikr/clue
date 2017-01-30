#include "clue/hook.h"

#include <jni.h>

#include <GLES2/gl2.h>

JNIEXPORT void JNICALL Java_com_agopshi_clue_ClueLib_init(JNIEnv* env, jobject obj, jint width, jint height)
{
	clue_hook_before_start();
	clue_hook_start();
}

JNIEXPORT void JNICALL Java_com_agopshi_clue_ClueLib_step(JNIEnv* env, jobject obj)
{
	clue_hook_update(1.0 / 60.0);
	clue_hook_render();
}
