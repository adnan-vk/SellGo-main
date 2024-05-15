// import 'dart:developer';

// import 'package:authentication/theme/colors.dart';
// import 'package:authentication/widgets/text_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// class PaymentScreen extends StatefulWidget {
//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   late Razorpay _razorpay;
//   TextEditingController _amountController = TextEditingController();

//   void openRazorpayPayment(int amount) async {
//     amount = amount * 100;
//     var options = {
//       'key': 'rzp_test_CYrnTOG3W2cDCB',
//       'amount': amount,
//       'name': 'Product Payment',
//       'prefill': {
//         'contact': '1234567890',
//         'email': 'test@gmail.com',
//       },
//       'external': {
//         'wallets': ['paytm'],
//       },
//     };

//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       debugPrint('Error while opening Razorpay payment: $e');
//     }
//   }

//   void handlePaymentSuccess(PaymentSuccessResponse response) {
//     Fluttertoast.showToast(
//       msg: "Payment successful: ${response.paymentId!}",
//       toastLength: Toast.LENGTH_SHORT,
//       backgroundColor: Colors.green,
//       textColor: Colors.white,
//     );
//     log('Payment successful: ${response.paymentId}');
//   }

//   void handlePaymentError(PaymentFailureResponse response) {
//     Fluttertoast.showToast(
//       msg: "Payment fail: ${response.message!}",
//       toastLength: Toast.LENGTH_SHORT,
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//     );
//     log('Payment error: ${response.message}');
//   }

//   void handleExternalWallet(ExternalWalletResponse response) {
//     Fluttertoast.showToast(
//       msg: "External wallet: ${response.walletName!}",
//       toastLength: Toast.LENGTH_SHORT,
//       backgroundColor: Colors.blue,
//       textColor: Colors.white,
//     );
//     log('External wallet: ${response.walletName}');
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _razorpay.clear();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: TextWidget().text(data: "Enter Amont", color: Colors.white),
//         backgroundColor: colors().blue,
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextFormField(
//               controller: _amountController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'Enter Amount',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.attach_money),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return "Please enter the amount";
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 try {
//                   if (_amountController.text.isNotEmpty) {
//                     int amount = int.parse(_amountController.text);
//                     openRazorpayPayment(amount);
//                     log('Entered Amount: $amount');
//                   }
//                 } catch (e) {
//                   log("Error: $e");
//                 }
//               },
//               child: Text('Proceed to Payment'),
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.white,
//                 backgroundColor: colors().blue,
//                 elevation: 3,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // key_id,key_secret
// // rzp_test_CYrnTOG3W2cDCB,Zq01KM6L54ebO4XpZyghHcRA

import 'dart:developer';

import 'package:authentication/theme/colors.dart';
import 'package:authentication/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay _razorpay;
  TextEditingController _amountController = TextEditingController();

  void openRazorpayPayment(int amount) async {
    amount = amount * 100;
    var options = {
      'key': 'rzp_test_CYrnTOG3W2cDCB',
      'amount': amount,
      'name': 'Product Payment',
      'prefill': {
        'contact': '1234567890',
        'email': 'test@gmail.com',
      },
      'external': {
        'wallets': ['paytm'],
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error while opening Razorpay payment: $e');
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
      msg: "Payment successful: ${response.paymentId!}",
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
    log('Payment successful: ${response.paymentId}');
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "Payment failed: ${response.message!}",
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
    log('Payment error: ${response.message}');
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "External wallet: ${response.walletName!}",
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    );
    log('External wallet: ${response.walletName}');
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget().text(
            data: "Enter Amount",
            color: Colors.white,
            size: 24.0,
            weight: FontWeight.bold),
        backgroundColor: colors().blue,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.blue.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Amount',
                labelStyle: TextStyle(
                    color: Colors.blueGrey, fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: colors().blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: colors().blue, width: 2.0),
                ),
                prefixIcon: Icon(Icons.attach_money, color: colors().blue),
                filled: true,
                fillColor: Colors.white,
              ),
              style: TextStyle(color: Colors.black, fontSize: 18),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter the amount";
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                try {
                  if (_amountController.text.isNotEmpty) {
                    int amount = int.parse(_amountController.text);
                    openRazorpayPayment(amount);
                    log('Entered Amount: $amount');
                  }
                } catch (e) {
                  log("Error: $e");
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                child: Text('Proceed to Payment',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                foregroundColor: Colors.white,
                backgroundColor: colors().blue,
                elevation: 5,
                shadowColor: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
