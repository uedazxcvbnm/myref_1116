package com.example.app_testmode1

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        setAndroidChannel(flutterEngine)
    }

    private fun setAndroidChannel(flutterEngine: FlutterEngine) {
        var channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.sample.sample/sample")
        channel.setMethodCallHandler { methodCall: MethodCall, result: MethodChannel.Result ->
            if (methodCall.method == "sample") {
                var intent = Intent(this, MainActivity::class.java)
                startActivity(intent)
            }
            else {
                result.notImplemented()
            }
        }
    }
}