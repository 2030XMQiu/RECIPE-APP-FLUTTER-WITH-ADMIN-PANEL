import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipe_app/services/constant.dart';
import 'package:recipe_app/widget/support_widget.dart';
import 'package:http/http.dart' as http;

class ResepDetail extends StatefulWidget {
  String image, name, resep, langkah;
  ResepDetail({
    required this.resep,
    required this.image,
    required this.name,
    required this.langkah,
  });

  @override
  State<ResepDetail> createState() => _ResepDetailState();
}

class _ResepDetailState extends State<ResepDetail> {
  Map<String, dynamic>? paymentIntent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: Text(
          widget.name,
          style: AppWidget.semiBoldTextFieldStyle(),
        ),
        backgroundColor: Color(0xffecefe8),
      ),
      backgroundColor: Color(0xffecefe8),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        widget.image,
                        height: 400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       widget.name,
                      //       style: AppWidget.semiBoldTextFieldStyle(),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Recipe",
                        style: AppWidget.semiBoldTextFieldStyle(),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        widget.resep,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "How to make",
                        style: AppWidget.semiBoldTextFieldStyle(),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        widget.langkah,
                      ),
                      SizedBox(
                        height: 90.0,
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     makePayment(widget.langkah);
                      //   },
                      //   child: Container(
                      //     padding: EdgeInsets.symmetric(vertical: 10.0),
                      //     decoration: BoxDecoration(
                      //       color: Colors.orange,
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     width: MediaQuery.of(context).size.width,
                      //     child: Center(
                      //       child: Text(
                      //         "Buy Now",
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 20.0,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Future<void> makePayment(String amount) async {
  //   try {
  //     paymentIntent = await createPaymentIntent(amount, 'USD');
  //     await Stripe.instance
  //         .initPaymentSheet(
  //             paymentSheetParameters: SetupPaymentSheetParameters(
  //                 paymentIntentClientSecret: paymentIntent?['client_secret'],
  //                 merchantDisplayName: 'Adnan'))
  //         .then((value) {});
  //     displayPaymentSheet();
  //   } catch (e, s) {
  //     print('exception:$e$s');
  //   }
  // }

  // displayPaymentSheet() async {
  //   try {
  //     await Stripe.instance.presentPaymentSheet().then((value) async {
  //       showDialog(
  //           context: context,
  //           builder: (_) => AlertDialog(
  //                 content: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Row(
  //                       children: [
  //                         Icon(
  //                           Icons.check_circle,
  //                           color: Colors.green,
  //                         ),
  //                         Text("Payment Successfully")
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ));
  //       paymentIntent = null;
  //     }).onError((error, stackTrace) {
  //       print("Error is :----> $error $stackTrace");
  //     });
  //   } on StripeException catch (e) {
  //     print("Error is :-----> $e");
  //     showDialog(
  //         context: context,
  //         builder: (_) => AlertDialog(
  //               content: Text("Cancelled"),
  //             ));
  //   } catch (e) {
  //     print('$e');
  //   }
  // }

  // createPaymentIntent(String amount, String currency) async {
  //   try {
  //     Map<String, dynamic> body = {
  //       'amount': calculateAmount(amount),
  //       'currency': currency,
  //       'payment_method_types[]': 'cart'
  //     };

  //     var response = await http.post(
  //       Uri.parse('https://api.stripe.com/v1/payment_intents'),
  //       headers: {
  //         'Authorization': 'Bearer $secretkey',
  //         'Content-Type': 'application/x-www-form-urlencoded'
  //       },
  //       body: body,
  //     );
  //     return jsonDecode(response.body);
  //   } catch (err) {
  //     print('err charging user: ${err.toString()}');
  //   }
  // }

  // calculateAmount(String amount) {
  //   final calculatedAmount = (int.parse(amount) * 100);
  //   return calculatedAmount.toString();
  // }
}
