package com.agopshi.clue;

public class ClueLib
{
	static
	{
		System.loadLibrary("clue");
	}

	public static native void init(int width, int height);
	public static native void step();
}
