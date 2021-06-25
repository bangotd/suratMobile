import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:tutorial_app/screen/login.dart';
import 'package:tutorial_app/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adv_fab/adv_fab.dart';
import 'package:tutorial_app/screen/home.dart';


class Tambahaktifitas extends StatefulWidget {
  @override
  _TambahaktifitasState createState() {
    return _TambahaktifitasState();
  }
}

class _TambahaktifitasState extends State<Tambahaktifitas> {
  int counter = 0;
  AdvFabController mabialaFABController;

  bool useNavigationBar = true;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var judulkegiatan;
  var isikegiatan;
  var judul = TextEditingController();
  var isi = TextEditingController();
  var userId ;

  @override
  void initState() {
    getUserInfo();
    super.initState();
    mabialaFABController = AdvFabController();
  }

  Future<void> getUserInfo()async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    userId = jsonDecode(localStorage.getString('user'));
  }

  void _tambahaktifitas() async{
    setState(() {
      _isLoading = true;
    });

    var data = {
      'judulkegiatan' : judulkegiatan,
      'isikegiatan' : isikegiatan,
      'user_id': userId["id"]
    };


    var res = await Network().authData(data, '/add-activity');
    var body = json.decode(res.body);
    if(body['success']){
      judul.clear();
      isi.clear();
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>Home()));
    }

    setState(() {
      _isLoading = false;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Sistem Informasi Pegawai'),
          backgroundColor: Colors.lightBlue,
        ),
        body: Tambahaktifitas(),
        floatingActionButton: AdvFab(
          useAsNavigationBar: useNavigationBar,
          controller: mabialaFABController,
          animationDuration: Duration(milliseconds: 350),
          navigationBarIcons: [
            AdvFabNavigationBarIcon(
              // onTap: () {
              //   Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute(
              //           builder: (BuildContext context) => super.widget));
              //   // print('home button pressed');
              // },
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => Home()
                  ),
                );
                // print('home button pressed');
              },
              title: 'Home',
              icon: Icons.home,
            ),
            AdvFabNavigationBarIcon(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => super.widget),

                );
              },
              title: 'Add Activity',
              icon: Icons.local_activity,
            ),
            AdvFabNavigationBarIcon(
              onTap: () {
                print('search button pressed');
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

  @override
  Widget Tambahaktifitas() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Form(
           key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Judul Kegiatan',
                  ),
                  validator: (judulkegiatanValue) {
                    if (judulkegiatanValue.isEmpty) {
                      return 'Please input Activity title';
                    }
                    judulkegiatan = judulkegiatanValue;
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  minLines: 6, // any number you need (It works as the rows for the textarea)
                  // keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Isi Kegiatan',
                  ),
                  validator: (isikegiatanValue) {
                    if (isikegiatanValue.isEmpty) {
                      return 'Activity more then 20 and less then 50';
                    }
                    isikegiatan = isikegiatanValue;
                    return null;
                  },
                ),
                ElevatedButton(
                  child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        _isLoading? 'Proccessing...' : 'Create Activity',
                      )
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _tambahaktifitas();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}