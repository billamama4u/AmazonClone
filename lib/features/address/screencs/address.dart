import 'package:amazone_clone/common/widgets/custombutton.dart';
import 'package:amazone_clone/common/widgets/customtextfielder.dart';
import 'package:amazone_clone/common/widgets/loader.dart';
import 'package:amazone_clone/constants/global_variabl.dart';
import 'package:amazone_clone/constants/utils.dart';
import 'package:amazone_clone/features/address/services/address_services.dart';
import 'package:amazone_clone/features/homescreen/Screens/homescreen.dart';
import 'package:amazone_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart'
    show rootBundle; // For loading the JSON config file

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address-screen';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  String addressToBeUsed = '';
  final _addressFormKey = GlobalKey<FormState>();
  final AddressServices addressServices = AddressServices();
  final TextEditingController _flatcontroller = TextEditingController();
  final TextEditingController _areacontroller = TextEditingController();
  final TextEditingController _pincodecontroller = TextEditingController();
  final TextEditingController _towncontroller = TextEditingController();

  List<PaymentItem> paymentItems = [];
  onGpayResult(res) {}

  void payPressed(String addressFromProvider) {
    addressToBeUsed = '';

    bool ifForm = _flatcontroller.text.isNotEmpty ||
        _areacontroller.text.isNotEmpty ||
        _pincodecontroller.text.isNotEmpty ||
        _towncontroller.text.isNotEmpty;
    if (ifForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${_flatcontroller.text},${_areacontroller.text},${_towncontroller.text} - ${_pincodecontroller.text}';
      } else {
        throw Exception('please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackbar(context, 'Error');
    }
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveAddress(
        context: context,
        address: addressToBeUsed,
      );
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalAmount: double.parse(widget.totalAmount),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _areacontroller.dispose();
    _flatcontroller.dispose();
    _pincodecontroller.dispose();
    _towncontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariable.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'OR',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                        controller: _flatcontroller,
                        hintText: 'Flat, House No, Building'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        controller: _areacontroller, hintText: "Area, Street"),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        controller: _pincodecontroller, hintText: "Pincode"),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        controller: _towncontroller, hintText: "Town/City"),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              CustomButton(
                  text: 'Pay',
                  onTap: () {
                    payPressed(address);
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
