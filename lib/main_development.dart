// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/widgets.dart';
import 'package:healing_travelling/app/app.dart';
import 'package:healing_travelling/bootstrap.dart';
import 'package:healing_travelling/utils/shared_preference_singleton.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await SharedPreferenceSingleton.init();
  timeago.setLocaleMessages('id', timeago.IdMessages());
  await di.init();
  bootstrap(() => const App());
}
