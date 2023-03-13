package com.app.claimizer;

import android.app.Activity;
import android.app.Application;

import androidx.annotation.CallSuper;

import io.flutter.FlutterInjector;


public class App extends Application {

    @Override
    @CallSuper
    public void onCreate() {
        super.onCreate();
        FlutterInjector.instance().flutterLoader().startInitialization(this);


    }

    private Activity mCurrentActivity = null;

    public Activity getCurrentActivity() {
        return mCurrentActivity;
    }

    public void setCurrentActivity(Activity mCurrentActivity) {
        this.mCurrentActivity = mCurrentActivity;
    }

}
