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

        /*val sdk = TuyaSdkPlugin()
        sdk.applicationContext = applicationContext
        sdk.mHandler = handler
        sdk.init(
            "...",
            "...",
            "...@accounts.fieldbots.io",
            "...",
            object : TuyaSdkGenerated.Result<Void> {
                override fun success(result: Void?) {

                    handler.postDelayed({
                        //doIt(sdk, handler)
                    }, 2000)

                }

                override fun error(error: Throwable?) {
                    TODO("Not yet implemented")
                }
            })*/
    }

    private fun doIt(sdk: TuyaSdkPlugin, handler: Handler) {
        sdk.getPairingToken("1486965680170455040", object: TuyaSdkGenerated.Result<TuyaSdkGenerated.PairingToken> {
            override fun success(result: TuyaSdkGenerated.PairingToken?) {
                doIt(sdk, handler)
                /*sdk.connectToWifi(result!!, "Turmbraeu", "Anno1503", object: TuyaSdkGenerated.Result<TuyaSdkGenerated.Device> {
                    override fun success(result: TuyaSdkGenerated.Device?) {
                        print(result?.toString())
                        doIt(sdk, handler)
                    }

                    override fun error(error: Throwable?) {
                        TODO("Not yet implemented")
                    }
                })*/
            }

            override fun error(error: Throwable?) {
                TODO("Not yet implemented")
            }
        })
    }

}
