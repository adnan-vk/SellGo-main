// ignore_for_file: must_be_immutable

import 'package:authentication/controller/authentication/auth_controller.dart';
import 'package:authentication/theme/colors.dart';
import 'package:authentication/widgets/snack_bar_widgets.dart';
import 'package:authentication/widgets/text_widget.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtpPage extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<AuthenticationProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: TextWidget().text(data: "OTP")),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Consumer<AuthenticationProvider>(
                builder: (context, value, child) => TextField(
                  controller: pro.phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: Container(
                      child: InkWell(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            countryListTheme: CountryListThemeData(
                              bottomSheetHeight: 500,
                            ),
                            onSelect: (value) {
                              pro.selectCountry = value;
                            },
                          );
                        },
                        child: TextWidget().text(
                            data:
                                "${value.selectCountry.flagEmoji}+${value.selectCountry.phoneCode}",
                            size: 15.0,
                            color: Colors.black,
                            weight: FontWeight.bold),
                      ),
                    ),
                    labelText: '  Enter Phone Number',
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    try {
                      if (pro.phoneController.text.length == 10) {
                        pro.getOtp(
                          "+${pro.selectCountry.phoneCode}${pro.phoneController.text}",
                        );
                        snackBarWidget().iconSnackSuccess(context,
                            label: "OTP sended Successfully");
                      } else {
                        snackBarWidget().iconSnackFail(context,
                            label: "Please Check your Mobile number");
                      }
                    } catch (e) {}
                  }
                  pro.showOtp();
                },
                child: TextWidget().text(data: "Send OTP"),
              ),
              SizedBox(height: 20.0),
              Consumer<AuthenticationProvider>(
                builder: (context, value, child) {
                  if (value.showOtpField == true) {
                    return Column(
                      children: [
                        TextField(
                          controller: pro.otpController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Enter OTP',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              try {
                                pro.verifyOtp(pro.otpController.text, context);
                              } catch (e) {
                                snackBarWidget().iconSnackAlert(context,
                                    label: "Invalid OTP $e");
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors().blue,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                          ),
                          child: TextWidget().text(
                              data: 'Verify OTP',
                              size: 18.0,
                              weight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    );
                  }
                  return SizedBox.shrink();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
