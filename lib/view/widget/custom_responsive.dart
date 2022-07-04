import 'package:flutter/cupertino.dart';

  /*
   * Study case for responsive layout reference to this link:
   * https://gs.statcounter.com/screen-resolution-stats/tablet/worldwide
   * I am setting for width is >= 600 is tablet or desktop, < 600 is phone.
   */

bool tablet (BuildContext context) => MediaQuery.of(context).size.width >= 600;
bool mobile (BuildContext context) => MediaQuery.of(context).size.width < 600;
bool orientation (BuildContext context) => MediaQuery.of(context).orientation == Orientation.portrait;