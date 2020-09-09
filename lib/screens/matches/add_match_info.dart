import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/utilities/constants.dart';
import 'package:flutter/material.dart';

class AddMatchInfo extends StatefulWidget {
  final UserModel currentUser;
  AddMatchInfo({this.currentUser});

  @override
  _AddMatchInfoState createState() => _AddMatchInfoState();
}

class _AddMatchInfoState extends State<AddMatchInfo> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String groupName = '';
  TextEditingController _inputFieldDateController = new TextEditingController();
  String _fecha = '';
  String _optSeleccionada = 'Volar';

  List<String> _poderes = ['Volar', 'Rayos X', 'Super aliento', 'Super fuerza'];

  Widget _buildMatchTypeTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'De que tipo es?',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.only(left: 30.0),
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.grey[700],
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              hintText: 'De que tipo es?',
              hintStyle: kHintTextStyle,
            ),
            validator: (val) => val.isEmpty ? ENTER_A_NAME : null,
            onChanged: (val) {
              setState(() => groupName = val);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHourAndDateTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Cuando es?',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.only(left: 30.0),
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.grey[700],
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              hintText: 'Cuando es?',
              hintStyle: kHintTextStyle,
            ),
            validator: (val) => val.isEmpty ? ENTER_A_NAME : null,
            onChanged: (val) {
              setState(() => groupName = val);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMatchPlaceTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Donde es?',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.only(left: 30.0),
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.grey[700],
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              hintText: 'Donde es?',
              hintStyle: kHintTextStyle,
            ),
            validator: (val) => val.isEmpty ? ENTER_A_NAME : null,
            onChanged: (val) {
              setState(() => groupName = val);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDate(BuildContext context) {
    return TextField(
      controller: _inputFieldDateController,
      enableInteractiveSelection: true,
      decoration: InputDecoration(
          hintText: 'Fecha de nacimiento',
          labelText: 'Fecha de nacimiento',
          suffixIcon: Icon(Icons.calendar_today),
          icon: Icon(Icons.calendar_today_outlined),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());

        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2018),
      lastDate: new DateTime(2025),
      locale: Locale('en', 'US'),
    );

    if (picked != null) {
      setState(() {
        _fecha = picked.toString();
        _inputFieldDateController.text = _fecha;
      });
    }
  }

  List<DropdownMenuItem<String>> getDropdownOptions() {
    List<DropdownMenuItem<String>> lista = new List();

    _poderes.forEach((poder) {
      lista.add(DropdownMenuItem(
        child: Text(poder),
        value: poder,
      ));
    });

    return lista;
  }

  Widget _buildDropDown() {
    return Row(
      children: [
        Icon(Icons.select_all),
        SizedBox(
          width: 30.0,
        ),
        Expanded(
          child: DropdownButton(
              value: _optSeleccionada,
              items: getDropdownOptions(),
              onChanged: (opt) {
                setState(() {
                  _optSeleccionada = opt;
                });
              }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Info',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: horizontalGradient,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              color: Colors.white,
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => CreateChatRoom(
                //         currentUser: widget.currentUser,
                //         usersToAddToGroup: usersToAdd,
                //         userBloc: userBloc),
                //   ),
                // ).then((val) async {
                //   setState(() {});
                // });
              },
            ),
          ],
        ),
        body: Container(
          decoration: horizontalGradient,
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20.0,
                  ),
                  child: Container(),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildMatchTypeTF(),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  _buildHourAndDateTF(),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  _buildMatchPlaceTF(),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Divider(),
                                  _buildDate(context),
                                  Divider(),
                                  _buildDropDown(),
                                  Divider(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
