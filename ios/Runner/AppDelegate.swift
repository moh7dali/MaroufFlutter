import UIKit
import Flutter
import GoogleMaps
import Foundation

var GlobalPaymentTransactionString = ""

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

    var checkoutProvider: OPPCheckoutProvider?
    var flutterResult:FlutterResult?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyAZ13Kb0wLcug1dD8VWEvAOfWiurJHwHM8")


      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController


      // MARK: - Get UserDefault
      //UserDefault
      let userDefault = FlutterMethodChannel(name: "com.mozaic.www.maroufcoffee/userDefault",
                                                   binaryMessenger: controller.binaryMessenger)

      userDefault.setMethodCallHandler({
          (call: FlutterMethodCall, result: FlutterResult) -> Void in
          if (call.method == "SessionToken") {
              result(UserDefaults.standard.string(forKey: "SessionToken"))
          } else if (call.method == "Authorization") {
              result(UserDefaults.standard.string(forKey: "Authorization"))
          } else if (call.method == "MobileNumber") {
              result(UserDefaults.standard.string(forKey: "MobileNumber"))
          } else if (call.method == "IsCompleted") {
              result(UserDefaults.standard.bool(forKey: "IsCompleted"))
          } else if (call.method == "HasReferral") {
              result(UserDefaults.standard.bool(forKey: "HasReferral"))
          }else if (call.method == "HasKeys") {
              result(!UserDefaults.standard.dictionaryRepresentation().isEmpty)
          }
      })


      // payemnt
      let paymentChannel = FlutterMethodChannel(name: "com.mozaic.www.maroufcoffee/getPaymentMethod",
                                                   binaryMessenger: controller.binaryMessenger)
      let provider = OPPPaymentProvider(mode: OPPProviderMode.live)

      let checkoutSettings = OPPCheckoutSettings()

      // Set available payment brands for your shop
      checkoutSettings.paymentBrands = ["VISA", "MASTER"]

      // Set shopper result URL
      checkoutSettings.shopperResultURL = "com.Mozaic.Burgerizz.ios.payments://result"





      paymentChannel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        // Note: this method is invoked on the UI thread.
        // Handle battery messages.
          self.flutterResult = result

       guard call.method == "getPaymentMethod" else {
         result(FlutterMethodNotImplemented)
         return
       }

          self.checkoutProvider = OPPCheckoutProvider(paymentProvider: provider, checkoutID: call.arguments as! String, settings: checkoutSettings)

          self.checkoutProvider?.presentCheckout(forSubmittingTransactionCompletionHandler: { [self] (transaction1, error) in
              guard let transaction = transaction1 else {
                  // Handle invalid transaction, check error
                  flutterResult!("ERROR#error)")
                  return
              }

              GlobalPaymentTransactionString = self.convertTransactionToDictionary(transation: transaction)
              print("Transaction: \(GlobalPaymentTransactionString)")
              if transaction.type == .synchronous {
                  // If a transaction is synchronous, just request the payment status
                  // You can use transaction.resourcePath or just checkout ID to do it
                  flutterResult!("SYNC#\(GlobalPaymentTransactionString)")
              } else if transaction.type == .asynchronous {
                  // The SDK opens transaction.redirectUrl in a browser
                  // See 'Asynchronous Payments' guide for more details

                  NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveAsynchronousPaymentCallback), name: Notification.Name(rawValue: "RecievedPaymentStatus"), object: nil)
//                  flutterResult!("ASYNC#\(paymentTransaction!)")
              } else {
                  // Executed in case of failure of the transaction for any reason
                  flutterResult!("FAIL#\(GlobalPaymentTransactionString)")
              }
          }, cancelHandler: {
              // Executed if the shopper closes the payment page prematurely
              result("CANCEL#cancel")
          })
      })





      GeneratedPluginRegistrant.register(with: self)
          return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }


    // MARK: - Async payment callback
        @objc func didReceiveAsynchronousPaymentCallback() {
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "RecievedPaymentStatus"), object: nil)
            self.checkoutProvider?.dismissCheckout(animated: true) {
                DispatchQueue.main.async {
                    //getPaymentStatusBy
                    self.flutterResult!("SYNC#\(GlobalPaymentTransactionString)")
                }
            }
        }




    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
            if url.scheme?.caseInsensitiveCompare("com.Mozaic.Burgerizz.ios.payments") == .orderedSame {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "RecievedPaymentStatus"), object: nil)
                return true
            }
            return false
        }

    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }


    func convertTransactionToDictionary(transation: OPPTransaction) -> String{
           let dictionary = NSMutableDictionary()

//           let aliPaySigneOrderInfo = transation.alipaySignedOrderInfo ?? ""
//           dictionary["AliPaySigneOrderInfo"] = aliPaySigneOrderInfo

           let paymentParamsDic = NSMutableDictionary()
           let paymentParams = transation.paymentParams

           let paymentBrand = paymentParams.paymentBrand
           let paymentCheckOutId = paymentParams.checkoutID
           let shopperResultURL = paymentParams.shopperResultURL ?? ""
           let customeParams = paymentParams.customParams
           paymentParamsDic["PaymentBrand"] = paymentBrand
           paymentParamsDic["PaymentCheckOutId"] = paymentCheckOutId
           paymentParamsDic["ShopperResultURL"] = shopperResultURL
           paymentParamsDic["CustomeParams"] = customeParams
           dictionary["PaymentParams"] = paymentParamsDic

           let redirectURL = transation.redirectURL?.absoluteString ?? ""
           dictionary["RedirectURL"] = redirectURL

           let resourcePath = transation.resourcePath ?? ""
           dictionary["ResourcePath"] = resourcePath

           let transactionType = transation.type
           switch transactionType {
           case .asynchronous:
               dictionary["TransactionType"] = "Asynchronous"
           case .synchronous:
               dictionary["TransactionType"] = "Synchronous"
           case .undefined:
               dictionary["TransactionType"] = "Undefined"
           @unknown default:
               dictionary["TransactionType"] = "Undefined"
           }
//           let result = HttpRestManager.convertDictionaryToJSON(dictionary: dictionary) ?? ""
        var finalResult = ""
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) {
           let result = String(data: theJSONData,
                                       encoding: .ascii)
            finalResult = result!
        }
        return finalResult
        }
}





