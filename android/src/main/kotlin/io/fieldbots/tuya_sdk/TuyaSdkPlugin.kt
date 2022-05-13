package io.fieldbots.tuya_sdk

import android.app.Application
import android.content.Context
import android.os.Handler
import android.os.Looper
import android.util.Log
import androidx.annotation.NonNull
import com.tuya.iotapp.activator.bean.DeviceRegistrationResultBean
import com.tuya.iotapp.activator.bean.RegistrationTokenBean
import com.tuya.iotapp.activator.builder.ActivatorBuilder
import com.tuya.iotapp.activator.config.IAPActivator
import com.tuya.iotapp.activator.config.TYActivatorManager
import com.tuya.iotapp.common.kv.KvManager
import com.tuya.iotapp.common.utils.IoTCommonUtil
import com.tuya.iotapp.componet.TuyaIoTSDK
import com.tuya.iotapp.jsonparser.api.JsonParser
import com.tuya.iotapp.network.api.RegionHostConst
import com.tuya.iotapp.network.interceptor.token.AccessTokenManager
import com.tuya.iotapp.network.interceptor.token.AccessTokenManager.accessTokenRepository
import com.tuya.iotapp.network.interceptor.token.bean.TokenBean
import com.tuya.iotapp.network.response.BizResponse
import com.tuya.iotapp.network.response.ResultListener
import com.tuya.iotapp.user.api.TYUserManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import java.io.IOException


/** TuyaSdkPlugin */
class TuyaSdkPlugin: FlutterPlugin, TuyaSdkGenerated.TuyaSdk {

    lateinit var mHandler: Handler
    lateinit var applicationContext: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = flutterPluginBinding.applicationContext
        mHandler = Handler(Looper.getMainLooper())
        TuyaSdkGenerated.TuyaSdk.setup(flutterPluginBinding.binaryMessenger, this)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        //channel.setMethodCallHandler(null)
    }

    override fun init(
        appKey: String,
        appSecret: String,
        username: String,
        password: String,
        result: TuyaSdkGenerated.Result<Void>
    ) {

        TuyaIoTSDK.builder().init(applicationContext as Application, appKey, appSecret)
            .hostConfig(RegionHostConst.REGION_HOST_EU)
            .debug(false)
            .build()

        TYUserManager.userBusiness.login(username, password, object: ResultListener<BizResponse> {
            override fun onFailure(errorCode: String?, errorMsg: String?) {
                result.error(IOException("$errorCode $errorMsg"))
            }

            override fun onSuccess(bizResult: BizResponse?) {
                val convertString = JsonParser.convertUnderLineToHump(bizResult!!.result.toString())
                val tokenBean = JsonParser.parseAny(convertString, TokenBean::class.java)
                // Store Token

                AccessTokenManager.storeInfo(tokenBean, bizResult.t)
                result.success(null)
            }
        })
    }

    override fun getPairingToken(assetId: String, result: TuyaSdkGenerated.Result<TuyaSdkGenerated.PairingToken>) {

        TYActivatorManager.activator.getRegistrationToken(
            assetId,
            "AP",
            IoTCommonUtil.getTimeZoneId(),
            "",
            object : ResultListener<RegistrationTokenBean> {
                override fun onFailure(errorCode: String?, errorMsg: String?) {
                    result.error(IOException("$errorCode $errorMsg"))
                }

                override fun onSuccess(bizResult: RegistrationTokenBean?) {
                    result.success(TuyaSdkGenerated.PairingToken().apply {
                        this.token = bizResult!!.token
                        this.region = bizResult.region
                        this.secret = bizResult.secret
                    })
                }
            }
        )
    }

    override fun connectToWifi(
        token: TuyaSdkGenerated.PairingToken,
        ssid: String,
        password: String,
        result: TuyaSdkGenerated.Result<TuyaSdkGenerated.Device>
    ) {

        val mBuilder = ActivatorBuilder(
            applicationContext,
            ssid,
            password,
            token.region!!,
            token.token!!,
            token.secret!!
        )
        val mApConfig = TYActivatorManager.newAPActivator(mBuilder)
        mApConfig.start()

        queryRegistrations(token, result, mApConfig, 0)

    }

    private fun queryRegistrations(
        token: TuyaSdkGenerated.PairingToken,
        result: TuyaSdkGenerated.Result<TuyaSdkGenerated.Device>,
        mApConfig: IAPActivator,
        tries: Int
    ) {

    }
}
