#ifndef CLUE_INTERNAL_H
#define CLUE_INTERNAL_H

#ifdef __cplusplus
	#define CLUE_BEGIN_C extern "C" {
	#define CLUE_END_C }
	#define CLUE_EXTERN extern "C"
#else
	#define CLUE_BEGIN_C
	#define CLUE_END_C
	#define CLUE_EXTERN
#endif

#endif
