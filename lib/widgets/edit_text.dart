import 'package:au_chat/models/chat_room_model.dart';
import 'package:au_chat/providers/chat_room_provider.dart';
import 'package:au_chat/utilities/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditText extends StatefulWidget {
  ChatRoomModel chatRoom;
  String groupName;
  String groupDesc;

  EditText({this.chatRoom, this.groupName, this.groupDesc});

  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  final TextEditingController _textController = TextEditingController();
  ChatRoomPrivider _chatRoomProvider = ChatRoomPrivider();

  // text field state
  String textEdited;
  bool groupNameEditing = true;

  _getLatestValue() {
    setState(() {
      textEdited = _textController.text;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.groupName != null) {
      textEdited = widget.groupName;
    } else {
      groupNameEditing = false;
      textEdited = widget.groupDesc;
    }
    _textController.addListener(_getLatestValue);
    _textController.text = textEdited;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool canSave = (textEdited.isEmpty ||
        widget.chatRoom.name == textEdited ||
        widget.chatRoom.name == textEdited.trim());

    Widget _buildTextEditTF(textEdited) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            alignment: Alignment.centerLeft,
            height: 60.0,
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              controller: _textController,
              keyboardType: TextInputType.text,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey[700],
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    _textController.clear();
                  },
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0, left: 20.0),
                hintText:
                    groupNameEditing ? GROUP_NAME : 'Descripcion del grupo',
                hintStyle: kHintTextStyle,
              ),
              validator: groupNameEditing
                  ? (val) => val.isEmpty ? 'Ingrese un nombre del grupo' : null
                  : (val) =>
                      val.isEmpty ? 'Ingrese una descripcion del grupo' : null,
              onChanged: (val) {
                setState(() => textEdited = val);
              },
            ),
          ),
        ],
      );
    }

    Widget divider() {
      return Container(
        padding: EdgeInsets.only(
          left: 10.0,
          right: 10.0,
        ),
        child: Divider(
          thickness: 1.0,
        ),
      );
    }

    return Container(
      decoration: horizontalGradient,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          // backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            title: groupNameEditing ? Text('Nombre') : Text('Descripcion'),
            elevation: 0.0,
            flexibleSpace: Container(
              decoration: horizontalGradient,
            ),
            actions: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 20.0),
                child: Center(
                  child: GestureDetector(
                    onTap: canSave
                        ? null
                        : () async {
                            dynamic resp;
                            if (groupNameEditing) {
                              resp = await _chatRoomProvider.editGroupName(
                                  widget.chatRoom, textEdited);
                            } else {
                              print('entra');
                              resp =
                                  await _chatRoomProvider.editGroupDescription(
                                      widget.chatRoom, textEdited);
                            }
                            if (resp['success']) {
                              Navigator.pop(context, resp['chatRoom']);
                            } else {
                              print('Algo fallo');
                            }
                          },
                    child: canSave
                        ? Opacity(
                            opacity: 0.5,
                            child: Text('Guardar'),
                          )
                        : Text('Guardar'),
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            bottom: false,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: screenBorders,
              ),
              child: ClipRRect(
                borderRadius: screenBorders,
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: _buildTextEditTF(textEdited),
                    ),
                    divider(),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
