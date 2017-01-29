package com.agopshi.clue;

import android.app.Activity;
import android.os.Bundle;

public class ClueActivity extends Activity {

    ClueView mView;

    @Override protected void onCreate(Bundle icicle) {
        super.onCreate(icicle);
        mView = new ClueView(getApplication());
		setContentView(mView);
    }

    @Override protected void onPause() {
        super.onPause();
        mView.onPause();
    }

    @Override protected void onResume() {
        super.onResume();
        mView.onResume();
    }
}
