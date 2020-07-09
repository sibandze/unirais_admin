import 'package:flutter/material.dart';

const _PAGE_TITLE = "Manage Institutions";

class ManageInstitutionsPage extends StatefulWidget {
  @override
  _ManageInstitutionsPageState createState() => _ManageInstitutionsPageState();
}

class _ManageInstitutionsPageState extends State<ManageInstitutionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_PAGE_TITLE),
      ),
      body: Column(children: <Widget>[],),
    );
  }
}
