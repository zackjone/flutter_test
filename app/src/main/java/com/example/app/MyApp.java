package com.example.app;

import android.app.Application;

public class MyApp extends Application {

    @Override
    public void onCreate() {
        super.onCreate();
        FlutterManager.getInstance().init(this);
    }
}
