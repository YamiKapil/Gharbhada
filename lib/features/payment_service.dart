// ignore_for_file: use_build_context_synchronously

import 'package:esewa/esewa.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gharbhada/constants/utils.dart';

//note: login credential for esewa:
// eSewa ID: 9806800001/2/3/4/5
// Password: Nepal@123
// Token: 123456
class EsewaScreen extends StatelessWidget {
  final String productId;
  final String amount;
  // final DateTimeRange date;
  // final String vechileId;
  const EsewaScreen({
    super.key,
    required this.productId,
    required this.amount,
    // required this.date,
    // required this.vechileId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          "Esewa",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: PayWithEsewaScreen(
        config: EsewaConfigModel.sandbox(
          // amount: 10,
          amount: double.parse(amount),
          taxAmount: 0,
          successUrl: 'https://example.com/success',
          failureUrl: 'https://example.com/failure',
          // productId: 'product_id',
          productId: productId.toString(),
        ),
        onSuccess: (config, refId) async {
          if (kDebugMode) {
            print('Payment successful');
          }
          if (kDebugMode) {
            print('RefId: $refId');
          }
          showSnackBar(context, 'Payment Successful');
          Navigator.pop(context);
          // final data = {
          //   "start_date": date.start.toString(),
          //   "end_date": date.end.toString(),
          //   "vehicle": vechileId,
          //   // "renter": userId
          //   "renter": 3
          // };
          // final isSuccess =
          //     await Provider.of<RentProvider>(context, listen: false)
          //         .postRent(map: data);
          // if (isSuccess) {
          // Navigator.pop(context);
          // // ShowToast.showToast(message: 'Rented Successfully RefId: $refId');
          // ShowToast.showToast(
          //   message:
          //       'Rented Successfully for date ${DateFormat('yyyy-MM-dd').format(date.start)} to ${DateFormat('yyyy-MM-dd').format(date.end)} RefId: $refId',
          // );
          // }
        },
        onFailure: (errorMessage) async {
          // Navigator.pop(context);
          // ShowToast.showToast(message: errorMessage);
          if (kDebugMode) {
            print('Error: $errorMessage');
          }
          showSnackBar(context, 'Payment Error');
          Navigator.pop(context);
          // final data = {
          //   "start_date": date.start.toString(),
          //   "end_date": date.end.toString(),
          //   "vehicle": vechileId,
          //   // "renter": userId
          //   "renter": 3
          // };
          // final isSuccess =
          //     await Provider.of<RentProvider>(context, listen: false)
          //         .postRent(map: data);
          // if (isSuccess) {
          //   Navigator.pop(context);
          //   // ShowToast.showToast(message: 'Rented Successfully RefId: $refId');
          //   ShowToast.showToast(
          //     message:
          //         'Rented Successfully for date ${DateFormat('yyyy-MM-dd').format(date.start)} to ${DateFormat('yyyy-MM-dd').format(date.end)}',
          //   );
          // }
        },
      ),
    );
  }
}
