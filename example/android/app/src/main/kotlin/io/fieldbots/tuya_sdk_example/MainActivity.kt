package io.fieldbots.tuya_sdk_example

import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.widget.Toast
import io.fieldbots.tuya_sdk.TuyaSdkGenerated
import io.fieldbots.tuya_sdk.TuyaSdkPlugin
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Toast.makeText(this, "Hello", Toast.LENGTH_LONG).show()


        val handler = Handler(Looper.getMainLooper())

        val sdk = TuyaSdkPlugin()
        sdk.applicationContext = applicationContext
        sdk.mHandler = handler
        doIt(sdk, handler)
    }

    private fun doIt(sdk: TuyaSdkPlugin, handler: Handler) {
        sdk.init(
            "...",
            "...",
            "...@accounts.fieldbots.io",
            "...",
            object : TuyaSdkGenerated.Result<Void> {
                override fun success(result: Void?) {

                }

                override fun error(error: Throwable?) {

                    handler.postDelayed({
                        doIt(sdk, handler)
                    }, 2000)

                }
            })
    }

}
