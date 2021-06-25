import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_app/activityview.dart';
import 'package:tutorial_app/screen/home.dart';
import 'package:tutorial_app/screen/login.dart';
import 'package:tutorial_app/network_utils/api.dart';
import 'package:tutorial_app/network_utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tutorial_app/screen/tambahaktifitas.dart';
import 'package:adv_fab/adv_fab.dart';


class Activitylist extends StatefulWidget {
  @override
  _ActivitylistState createState() => _ActivitylistState();
}

class _ActivitylistState extends State<Activitylist>{
  String farsip;
  String lname;
  int counter = 0;
  AdvFabController mabialaFABController;

  bool useNavigationBar = true;
  bool loading = true;
  List pdfList;

  Future fetchAllPdf() async{
    final response = await http.get(url+'api/indexactivitylist');
    if (response.statusCode==200){
      setState(() {
        pdfList = jsonDecode(response.body);
        loading = false;
      });
      print(pdfList);
    }
  }

  @override
  void initState(){
    // _loadUserData();
    super.initState();
    mabialaFABController = AdvFabController();
    fetchAllPdf();
    // _launchURL("http://192.168.50.238:8000/api/arsips/"+pdfList[index]["file"]);
  }

  _loadUserData() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));

    if(user != null) {
      setState(() {
        farsip = user['judulkegiatan'];
        lname = user['lastname'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Sistem Informasi Pegawai'),
          backgroundColor: Colors.lightBlue,
        ),
        body: loading
            ? Center(
          child:CircularProgressIndicator(),
        )
            : ListView.builder(
          itemCount: pdfList.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: IconButton(icon: Icon(Icons.list_sharp),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ActivityViewPage(url: url+"api/indexactivitylist/"+pdfList[index]["isikegiatan"],judulkegiatan: pdfList[index]["judulkegiatan"],),),);
                },),
              title: Text(pdfList[index]["judulkegiatan"]),
            );
          },
        ),
        //     floatingActionButton: FloatingActionButton(
        //     onPressed: () {
        //   logout();
        // },
        // child: Icon(Icons.logout),
        // backgroundColor: Colors.lightBlue,
        // ),


        floatingActionButton: AdvFab(
          useAsNavigationBar: useNavigationBar,
          controller: mabialaFABController,
          animationDuration: Duration(milliseconds: 350),
          navigationBarIcons: [
            AdvFabNavigationBarIcon(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Home()));
                // print('home button pressed');
              },
              // onTap: () {
              //   Navigator.pushReplacement(
              //     context,
              //     new MaterialPageRoute(
              //         builder: (context) => Activitylist()
              //     ),
              //   );
              //   print('home button pressed');
              // },
              title: 'Home',
              icon: Icons.home,
            ),
            AdvFabNavigationBarIcon(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Tambahaktifitas()),
                );
              },
              title: 'Add Activity',
              icon: Icons.local_activity,
            ),
            AdvFabNavigationBarIcon(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Activitylist()),
                );
              },
              title: 'List',
              icon: Icons.list,
            ),
            AdvFabNavigationBarIcon(
              onTap: () {
                logout();
                // print('profile button pressed');
                setState(() {});
              },
              title: 'Logout',
              icon: Icons.logout,
            ),
          ],
        )
    );
  }

  // void _launchURL(_url) async {
  //   await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  // }

  void logout() async{
    var res = await Network().getData('/logout');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>Login()));
    }
  }
}