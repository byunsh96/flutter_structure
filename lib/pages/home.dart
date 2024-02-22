import 'package:flutter/material.dart';
import 'package:login/widgets/customelvbtn.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'qna 등록',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xFF6500C6),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            color: Colors.white,
            tooltip: "notifications",
            onPressed: () {
              print('Search button is clicked');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('assets/image20.png'),
                backgroundColor: Colors.white,
              ),
              otherAccountsPictures: const [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/pikachu.png'),
                  backgroundColor: Colors.white,
                ),
              ],
              accountName: const Text('saegyung'),
              accountEmail: const Text('sy87@naver.com'),
              onDetailsPressed: () {
                print('arrow is clicked');
              },
              decoration: BoxDecoration(
                color: Colors.red[200],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.grey[850],
              ),
              title: const Text('Home'),
              onTap: () {
                print('Home is clicked');
              },
              trailing: const Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.grey[850],
              ),
              title: const Text('Setting'),
              onTap: () {
                print('Setting is clicked');
              },
              trailing: const Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(
                Icons.question_answer,
                color: Colors.grey[850],
              ),
              title: const Text('Q&A'),
              onTap: () {
                print('Q&A is clicked');
              },
              trailing: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 1000,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 450,
                      height: 150,
                      color: Colors.redAccent,
                    ),
                    Container(
                      width: 450,
                      height: 150,
                      color: Colors.blueAccent,
                    ),
                    Container(
                      height: 400,
                      width: 400,
                      color: Colors.blueAccent,
                    ),
                    Positioned(
                      top:300,
                      child: Container(
                        height: 900,
                        width: 450,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
              CustomELVbtn(text: "board_reg",url: "/board_reg"),
              CustomELVbtn(text: "board_list",url: "/board_list"),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
