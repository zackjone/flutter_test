package com.example.app;

import android.text.TextUtils;

import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;

public class FlutterMainActivity extends FlutterFragmentActivity {

    @Override
    protected void onDestroy() {
        super.onDestroy();
        try {
            String engineId = getCachedEngineId();
            if (!TextUtils.isEmpty(engineId)) {
                FlutterEngine flutterEngine = FlutterEngineCache.getInstance().get(engineId);
                if (flutterEngine != null) {
                    flutterEngine.destroy();
                    FlutterEngineCache.getInstance().remove(engineId);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
