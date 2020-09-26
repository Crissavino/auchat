import 'package:au_chat/models/chat_room_model.dart';
import 'package:au_chat/utilities/constants.dart';
import 'package:au_chat/utilities/slide_bottom_route.dart';
import 'package:au_chat/widgets/edit_text.dart';
import 'package:flutter/material.dart';

class InfoChat extends StatefulWidget {
  ChatRoomModel chatRoom;

  InfoChat({this.chatRoom});

  @override
  _InfoChatState createState() => _InfoChatState();
}

class _InfoChatState extends State<InfoChat> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final availableWidth = mediaQuery.size.width - 160;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _buildGroupName(),
                divider(),
                _buildGroupDesc(),
                divider(),
              ],
            ),
          ),
          _buildGroupParticipants(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                divider(),
                _buildLeaveGroup(),
                divider(),
              ],
            ),
          ),
        ],
      ),
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

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context, widget.chatRoom);
          }),
      elevation: 2.0,
      backgroundColor: Colors.green[400],
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        // print('constraints=' + constraints.toString());
        var top = constraints.biggest.height;
        return FlexibleSpaceBar(
          title: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: top < 110.0 ? 1.0 : 0.0,
            child: Text(
              widget.chatRoom.name,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          centerTitle: true,
          background: Stack(
            children: [
              Container(
                width: double.infinity,
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/loading.gif'),
                  image: NetworkImage(widget.chatRoom.image),
                  fadeInDuration: Duration(milliseconds: 150),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10.0, right: 10.0),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      onPressed: null,
                      backgroundColor: Colors.white60,
                      mini: true,
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => print('Editar imagen'),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildGroupName() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          SlideBottomRoute(
            page: EditText(
              chatRoom: widget.chatRoom,
              groupName: widget.chatRoom.name,
            ),
          ),
        ).then(
          (val) async {
            setState(() {
              widget.chatRoom = val;
            });
          },
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Text(
          widget.chatRoom.name,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildGroupDesc() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          SlideBottomRoute(
            page: EditText(
              chatRoom: widget.chatRoom,
              groupDesc: widget.chatRoom.description,
            ),
          ),
        ).then((val) async {
          setState(() {
            widget.chatRoom = val;
          });
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Text(
          widget.chatRoom.description,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildGroupParticipants() {
    final List players = widget.chatRoom.players;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return InkWell(
            onTap: () => print(
                'Accions con el usuario ${players[index]['user']['fullName']}'),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 20.0,
                  ),
                  CircleAvatar(
                    child: Text(players[index]['user']['fullName'][0]),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    players[index]['user']['fullName'],
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        childCount: players.length,
      ),
    );
  }

  Widget _buildLeaveGroup() {
    return FlatButton(
      onPressed: () => print('Abandonar grupo'),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Text(
          LEAVE_GROUP,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
