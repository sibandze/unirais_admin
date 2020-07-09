import './presentation/_presentation.dart' as PRESENTATION;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './bloc/_bloc.dart';
import './const/_const.dart' as CONSTANTS;
import './pages/_pages.dart';
import './util/_util.dart';

void main() {
  runApp(UniRaisAdminApp());
}

class UniRaisAdminApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlocCategories>(
          create: (BuildContext context) => BlocCategories(),
        ),
        BlocProvider<BlocCart>(
          create: (BuildContext context) => BlocCart(),
        ),
        BlocProvider<BlocAuthentication>(
          create: (BuildContext context) => BlocAuthentication(),
        ),
        BlocProvider<BlocProducts>(
          create: (BuildContext context) => BlocProducts(),
        ),
        BlocProvider<BlocOrder>(
          create: (BuildContext context) => BlocOrder(),
        ),
        BlocProvider<BlocAddress>(
          create: (BuildContext context) => BlocAddress(),
        ),
        BlocProvider<BlocUniversity>(
          create: (BuildContext context) => BlocUniversity(),
        ),
      ],
      child: MaterialApp(
        //debugShowCheckedModeBanner: false,
        title: CONSTANTS.ADMIN_APP_NAME,
        home: UniRaisAdminAppHome(),
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: PRESENTATION.BACKGROUND_COLOR,
          ),
          primaryColor: Colors.white,
          fontFamily: 'Poppins',
          textTheme: TextTheme(
            bodyText2: TextStyle(
              color: PRESENTATION.BODY_TEXT_COLOR,
            ),
          ),
        ),
      ),
    );
  }
}

class UniRaisAdminAppHome extends StatelessWidget {
  UniRaisAdminAppHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CONSTANTS.ADMIN_APP_NAME),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                push(context, ManageProductsPage());
              },
              child: Text(
                'MANAGE PRODUCTS',
                style: PRESENTATION.GETTING_STARTED_BUTTON_TEXT_STYLE,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(15),
              color: PRESENTATION.PRIMARY_COLOR,
              textColor: Colors.white,
            ),
            RaisedButton(
              onPressed: () {
                push(context, ManageOrdersPage());
              },
              child: Text(
                'MANAGE ORDERS',
                style: PRESENTATION.GETTING_STARTED_BUTTON_TEXT_STYLE,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(15),
              color: PRESENTATION.PRIMARY_COLOR,
              textColor: Colors.white,
            ),
            RaisedButton(
              onPressed: () {
                push(context, ManageInstitutionsPage());
              },
              child: Text(
                'MANAGE INSTITUTIONS',
                style: PRESENTATION.GETTING_STARTED_BUTTON_TEXT_STYLE,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(15),
              color: PRESENTATION.PRIMARY_COLOR,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
