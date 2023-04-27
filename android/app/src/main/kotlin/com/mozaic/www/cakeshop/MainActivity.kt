package com.mozaic.www.maroufcoffee

import android.content.*
import android.os.IBinder
import android.preference.PreferenceManager
import android.util.Log
import androidx.annotation.NonNull
import com.google.android.gms.common.ConnectionResult
import com.google.android.gms.common.GoogleApiAvailability
import com.huawei.hms.api.HuaweiApiAvailability
import com.oppwa.mobile.connect.checkout.dialog.CheckoutActivity
import com.oppwa.mobile.connect.checkout.meta.CheckoutSettings
import com.oppwa.mobile.connect.checkout.meta.CheckoutStorePaymentDetailsMode
import com.oppwa.mobile.connect.exception.PaymentError
import com.oppwa.mobile.connect.exception.PaymentException
import com.oppwa.mobile.connect.provider.*
import com.oppwa.mobile.connect.provider.Connect.*
import com.oppwa.mobile.connect.provider.Connect.ProviderMode.*
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONException
import org.json.JSONObject

class MainActivity: FlutterActivity() , ITransactionListener {
    val checkoutRequestCode: Int=1000
    private var shopperUrl: String = ""
    private var isResultOk: Boolean = false
    private val hmsGsmCHANNEL = "com.mozaic.www.maroufcoffee/isHmsGmsAvailable"
    private val hyperPayCHANNEL = "com.mozaic.www.maroufcoffee/getPaymentMethod"
    private val sharedPreference = "com.mozaic.www.maroufcoffee/sharedPreference"
    var methodResult: MethodChannel.Result? = null
    var concurrentContext = this@MainActivity.context

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {

        //shared preference
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            sharedPreference
        ).setMethodCallHandler { call, result ->
            val preferences = PreferenceManager.getDefaultSharedPreferences(context)
            if (call.method.equals("IsCompleted")) {
                val isCompleted = preferences.getString("isCompleted", "").toBoolean()
                print("IsCompleted: $isCompleted")
                result.success(isCompleted)
            } else if (call.method.equals("SessionToken")) {
                val sessionToken = preferences.getString("SessionToken", "")
                print("SessionToken: $sessionToken")
                result.success(preferences.getString("SessionToken", ""))
            } else if (call.method.equals("HasReferral")) {
                result.success(preferences.getString("HasReferral", "").toBoolean())
            } else if (call.method.equals("Authorization")) {
                result.success(preferences.getString("AccessToken", ""))
            } else if (call.method.equals("MobileNumber")) {
                result.success(preferences.getString("customerMobile", ""))
            }else if (call.method.equals("printKeys")) {
                val keys = preferences.all
                print("HasKeys: $keys")
                result.success(keys)
            } else if (call.method.equals("HasKeys")) {
                val keys = preferences.all
                print("HasKeys: $keys")
                val hasKeys=keys.isNotEmpty()
                result.success(hasKeys)
            } else {
                result.notImplemented()
            }
        }


        //hmsGsmCHANNEL
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            hmsGsmCHANNEL
        ).setMethodCallHandler { call, result ->
            // Note: this method is invoked on the main thread.

            if (call.method.equals("isHmsAvailable")) {
                result.success(isHmsAvailable())
            } else if (call.method.equals("isGmsAvailable")) {
                result.success(isGmsAvailable())
            } else {
                result.notImplemented()
            }
        }

        //hyperPayCHANNEL
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            hyperPayCHANNEL
        ).setMethodCallHandler { call, result ->
            // Note: this method is invoked on the main thread.
            if (call.method.equals("getPaymentMethod")) {


//                binder!!.addTransactionListener(this@MainActivity)
                methodResult = result
                shopperUrl = "Marouf://com.mozaic.www.maroufcoffee"
//                binder!!.addTransactionListener()

                val paymentBrands = hashSetOf("VISA", "MASTER")

                print("CheckoutID: ${call.arguments as String} ------ \n")
                print("paymentBrands: $paymentBrands ------")
                var checkoutId: String = call.arguments.toString()

                val checkoutSettings = CheckoutSettings(
                    checkoutId,
                    paymentBrands,
                    TEST
                )
                // Set shopper result URL
                checkoutSettings.shopperResultUrl = shopperUrl
                checkoutSettings.setLocale("ar")
                checkoutSettings.setStorePaymentDetailsMode(CheckoutStorePaymentDetailsMode.PROMPT)
                val intent = checkoutSettings.createCheckoutActivityIntent(this)
                startActivityForResult(intent, CheckoutActivity.REQUEST_CODE_CHECKOUT)
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        //  Log.e("onNewIntent", "onNewIntent");
        //  Log.e("onNewIntent", intent.getScheme() + "!");
        if (intent.scheme != null) {
            if (intent.scheme == "Marouf" && !isResultOk) {
                methodResult!!.success(paymentResult("SYNC", paymentTransactionPayment))
            }
        }
    }

    override fun onStart() {
        super.onStart()
        try {
            val intent = Intent(this, Connect::class.java)
            startService(intent)
            bindService(intent, serviceConnection, BIND_AUTO_CREATE)

        } catch (e: IllegalStateException) {
            Log.e("IllegalStateException", e.message!!);
        }
    }

    private fun paymentResult(result: String, json: String): String {

        return "$result#$json"
    }

    private var paymentTransactionPayment: String = "Null transaction response from SDK"

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == CheckoutActivity.REQUEST_CODE_CHECKOUT) {
            val transaction =
                data!!.getParcelableExtra<Transaction>("com.oppwa.mobile.connect.checkout.dialog.CHECKOUT_RESULT_TRANSACTION")
            if (transaction != null) {
                paymentTransactionPayment = convertTransactionToString(transaction)!!
            }
            print("requestCode: $requestCode ------ \n")
            print("resultCode: $resultCode ------ \n")
            print("paymentTransactionPayment: $paymentTransactionPayment ------ \n")

            when (resultCode) {
                CheckoutActivity.RESULT_OK -> {
                    /* transaction completed */
                    val transaction: Transaction =
                        data.getParcelableExtra(CheckoutActivity.CHECKOUT_RESULT_TRANSACTION)!!

                    /* resource path if needed */
                    val resourcePath =
                        data.getStringExtra(CheckoutActivity.CHECKOUT_RESULT_RESOURCE_PATH)


                    if (transaction.transactionType == TransactionType.ASYNC) {
                        /* check the result of synchronous transaction */
                        isResultOk = true
                        methodResult!!.success(paymentResult("ASYNC", paymentTransactionPayment))
                    } else if (transaction.transactionType == TransactionType.SYNC) {
                        /* check the result of synchronous transaction */
                        isResultOk = true
                        methodResult!!.success(paymentResult("SYNC", paymentTransactionPayment))
                    } else {
                        /* wait for the asynchronous transaction callback in the onNewIntent() */
                        isResultOk = true
                        methodResult!!.success(paymentResult("FAIL", paymentTransactionPayment))
                    }
                }

                CheckoutActivity.RESULT_CANCELED -> {
                    /* shopper cancelled the checkout process */

                    print("Transaction canceled")
                    print("paymentTransactionPayment : $paymentTransactionPayment")
                    isResultOk = true
                    methodResult!!.success("CANCEL#$paymentTransactionPayment")
                }

                CheckoutActivity.RESULT_ERROR -> {
                    /* error occurred */

                    val error: PaymentError
                    ? =
                        data.getParcelableExtra("com.oppwa.mobile.connect.checkout.dialog.CHECKOUT_RESULT_ERROR")
                    print("Transaction error")
                    print("paymentTransactionPayment : ${error!!.errorMessage}")
                    isResultOk = true
                    methodResult!!.success(paymentResult("ERROR", error.errorMessage))

                }
            }
        }
    }

    private fun convertTransactionToString(transaction: Transaction): String? {
        return try {
            val jsonObject = JSONObject()
            val jsonObject2 = JSONObject()
            if (transaction.transactionType != null) {
                if (transaction.transactionType == TransactionType.ASYNC) {
                    jsonObject.put("TransactionType", "ASYNC")
                } else if (transaction.transactionType == TransactionType.SYNC) {
                    jsonObject.put("TransactionType", "SYNC")
                } else {
                    jsonObject.put("TransactionType", "Empty")
                }
            } else {
                jsonObject.put("TransactionType", "Null")
            }
            if (transaction.paymentParams != null) {
                jsonObject.put("PaymentCheckOutId", transaction.paymentParams.checkoutId)
                jsonObject.put("ShopperResultUrl", transaction.paymentParams.shopperResultUrl)
                jsonObject.put("PaymentBrand", transaction.paymentParams.paymentBrand)
                jsonObject2.put(
                    "SHOPPER_OS",
                    transaction.paymentParams.paramsForRequest["customParameters[SHOPPER_OS]"]
                )
                jsonObject2.put(
                    "SHOPPER_MSDKIntegrationType",
                    transaction.paymentParams.paramsForRequest["customParameters[SHOPPER_MSDKIntegrationType]"]
                )
                jsonObject2.put(
                    "SHOPPER_MSDKVersion",
                    transaction.paymentParams.paramsForRequest["customParameters[SHOPPER_MSDKVersion]"]
                )
                jsonObject2.put(
                    "SHOPPER_device",
                    transaction.paymentParams.paramsForRequest["customParameters[SHOPPER_MSDKVersion]"]
                )
            }
            jsonObject.put("CustomeParams", jsonObject2)
            jsonObject.toString()
        } catch (e1: JSONException) {
            "ExceptionInConvert" + e1.message
        } catch (e2: Exception) {
            "Exception e2" + e2.message
        }
    }

    private var binder: OppPaymentProvider? = null

    val serviceConnection = object : ServiceConnection {

        override fun onServiceConnected(className: ComponentName, service: IBinder) {
            //Something to do
            binder = service as OppPaymentProvider
            try {
                binder= OppPaymentProvider(this@MainActivity.context, TEST)
            } catch (ee: PaymentException) {

                Log.d("PaymentException", ee.message + " !")
            }

        }

        override fun onServiceDisconnected(arg0: ComponentName) {
            //Something to do
            binder = null
        }
    }

    override fun attachBaseContext(newBase: Context?) {
        super.attachBaseContext(newBase)
    }

    private fun isHmsAvailable(): Boolean {
        var isAvailable = false
        val context: Context = concurrentContext
        if (null != context) {
            val result =
                HuaweiApiAvailability.getInstance().isHuaweiMobileServicesAvailable(context)
            isAvailable = ConnectionResult.SUCCESS == result
        }
        Log.i("MainActivity", "isHmsAvailable: $isAvailable")
        return isAvailable
    }

    private fun isGmsAvailable(): Boolean {
        var isAvailable = false
        val context: Context = concurrentContext
        if (null != context) {
            val result: Int =
                GoogleApiAvailability.getInstance().isGooglePlayServicesAvailable(context)
            isAvailable = com.google.android.gms.common.ConnectionResult.SUCCESS === result
        }
        Log.i("MainActivity", "isGmsAvailable: $isAvailable")
        return isAvailable
    }

    override fun transactionCompleted(p0: Transaction) {

    }

    override fun transactionFailed(p0: Transaction, p1: PaymentError) {

    }


}