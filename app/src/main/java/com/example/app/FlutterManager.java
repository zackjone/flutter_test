package com.example.app;
import android.content.Context;
import android.content.Intent;
import androidx.annotation.NonNull;
import java.util.UUID;

import io.flutter.FlutterInjector;
import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.FlutterEngineGroup;
import io.flutter.embedding.engine.dart.DartExecutor;

public class FlutterManager {

    private static FlutterManager instance;
    private FlutterEngineGroup flutterEngineGroup;
    private DartExecutor.DartEntrypoint dartEntrypoint;

    private Context appContext;


    // 私有构造函数
    private FlutterManager() {

    }

    // 获取单例实例
    public static synchronized FlutterManager getInstance() {
        if (instance == null) {
            instance = new FlutterManager();
        }
        return instance;
    }

    public void init(Context context) {
        appContext = context;
        this.flutterEngineGroup = new FlutterEngineGroup(context.getApplicationContext());
        dartEntrypoint = new DartExecutor.DartEntrypoint(
                FlutterInjector.instance().flutterLoader().findAppBundlePath(),
                "main" // Dart 入口函数名称，如果为 null 则默认为 "main"
        );
        flutterEngineGroup.createAndRunEngine(
                context, // 上下文
                dartEntrypoint);
    }

    public void goToFlutterPage(@NonNull Context context, String pageName) {
        if (flutterEngineGroup == null) {
            flutterEngineGroup = new FlutterEngineGroup(appContext.getApplicationContext());
        }
        FlutterEngine flutterEngine = flutterEngineGroup.createAndRunEngine(
                context,
                dartEntrypoint,
                pageName);
        flutterEngine.getDartExecutor().getBinaryMessenger().enableBufferingIncomingMessages();
        String engineId = "engine_" + UUID.randomUUID().toString();
        FlutterEngineCache
                .getInstance()
                .put(engineId, flutterEngine);
        FlutterFragmentActivity.CachedEngineIntentBuilder builder = new FlutterFragmentActivity.CachedEngineIntentBuilder(FlutterMainActivity.class, engineId);
        Intent intent = builder.build(context);
        context.startActivity(intent);
    }
}
