package com.example.shortcuts

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example/native"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "getNativeData") {
                if (!call.hasArgument("name")) {
                    result.error("MissingArgumentError", "You must provide name parameter.", null)
                }
                val name: String = call.argument<String>("name")!!
                val data = getNativeData(name)
                result.success(data)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getNativeData(name: String): String {
        // Implement your native code logic here
        return "From Native: $name"
    }
}