import 'package:flutter/material.dart';

const _PAGE_TITLE = "Manage Orders";

class ManageOrdersPage extends StatefulWidget {
  @override
  _ManageOrdersPageState createState() => _ManageOrdersPageState();
}

class _ManageOrdersPageState extends State<ManageOrdersPage> {
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
