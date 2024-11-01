import 'package:amazone_clone/common/widgets/custombutton.dart';
import 'package:amazone_clone/common/widgets/customtextfielder.dart';
import 'package:amazone_clone/constants/global_variabl.dart';
import 'package:amazone_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/addtess-screen';
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressFormKey = GlobalKey<FormState>();
  final TextEditingController _flatcontroller = TextEditingController();
  final TextEditingController _areacontroller = TextEditingController();
  final TextEditingController _pincodecontroller = TextEditingController();
  final TextEditingController _towncontroller = TextEditingController();

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
              if(address.isNotEmpty)
                Column(children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12,),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(address , style: const TextStyle(fontSize: 18,),),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('OR' ,style: TextStyle(fontSize: 18),),
                  const SizedBox(
                    height: 20,
                  ),
                ],)

              Form(
                  key: _addressFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                          controller: _flatcontroller
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
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
