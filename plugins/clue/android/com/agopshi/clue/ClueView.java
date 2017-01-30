
package com.agopshi.clue;


import android.content.Context;
import android.graphics.PixelFormat;
import android.opengl.GLSurfaceView;
import android.util.Log;

import javax.microedition.khronos.egl.EGL10;
import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.egl.EGLContext;
import javax.microedition.khronos.egl.EGLDisplay;
import javax.microedition.khronos.opengles.GL10;

class ClueView extends GLSurfaceView {
	public ClueView(Context context)
	{
		super(context);
		init(false, 8, 8);
	}

	private void init(boolean translucent, int depth, int stencil) {
		setEGLContextFactory(new ContextFactory());
		setEGLConfigChooser(new ConfigChooser(8, 8, 8, 8, depth, stencil));
		setRenderer(new Renderer());
	}

	private static class ContextFactory implements GLSurfaceView.EGLContextFactory {
		private static int EGL_CONTEXT_CLIENT_VERSION = 0x3098;
		public EGLContext createContext(EGL10 egl, EGLDisplay display, EGLConfig eglConfig) {
			int[] attrib_list = { EGL_CONTEXT_CLIENT_VERSION, 2, EGL10.EGL_NONE };
			return egl.eglCreateContext(display, eglConfig, EGL10.EGL_NO_CONTEXT, attrib_list);
		}

		public void destroyContext(EGL10 egl, EGLDisplay display, EGLContext context) {
			egl.eglDestroyContext(display, context);
		}
	}

	private static class ConfigChooser implements GLSurfaceView.EGLConfigChooser {
		public ConfigChooser(int r, int g, int b, int a, int depth, int stencil) {
			mRedSize = r;
			mGreenSize = g;
			mBlueSize = b;
			mAlphaSize = a;
			mDepthSize = depth;
			mStencilSize = stencil;
		}

		/* This EGL config specification is used to specify 2.0 rendering.
		 * We use a minimum size of 4 bits for red/green/blue, but will
		 * perform actual matching in chooseConfig() below.
		 */
		private static int EGL_OPENGL_ES2_BIT = 4;
		private static int[] s_configAttribs2 =
		{
			EGL10.EGL_RED_SIZE, 4,
			EGL10.EGL_GREEN_SIZE, 4,
			EGL10.EGL_BLUE_SIZE, 4,
			EGL10.EGL_RENDERABLE_TYPE, EGL_OPENGL_ES2_BIT,
			EGL10.EGL_NONE
		};

		public EGLConfig chooseConfig(EGL10 egl, EGLDisplay display)
		{
			int[] configAttribs = {
				EGL10.EGL_RED_SIZE, 8,
				EGL10.EGL_GREEN_SIZE, 8,
				EGL10.EGL_BLUE_SIZE, 8,
				EGL10.EGL_DEPTH_SIZE, 8,
				//EGL10.EGL_STENCIL_SIZE, 8,
				EGL10.EGL_RENDERABLE_TYPE, EGL_OPENGL_ES2_BIT,
				EGL10.EGL_NONE
			};

			int[] numConfigs;
			EGLConfig[] configs = new EGLConfig[1];
			egl.eglChooseConfig(display, configAttribs, configs, 1, numConfigs);

			if (numConfigs[0] == 0) {
				throw new Exception("No configs match configSpec");
			}

			return chooseConfig(egl, display, configs);
		}

		// Subclasses can adjust these values:
		protected int mRedSize;
		protected int mGreenSize;
		protected int mBlueSize;
		protected int mAlphaSize;
		protected int mDepthSize;
		protected int mStencilSize;
		private int[] mValue = new int[1];
	}

	private static class Renderer implements GLSurfaceView.Renderer
	{
		public void onDrawFrame(GL10 gl)
		{
			ClueLib.step();
		}

		public void onSurfaceChanged(GL10 gl, int width, int height)
		{
			ClueLib.init(width, height);
		}

		public void onSurfaceCreated(GL10 gl, EGLConfig config)
		{
		}
	}
}
