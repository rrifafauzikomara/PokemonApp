import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'app_test_key.dart';

void main() {
  group("Pokemon App", () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test("show list pokemon with scrolling up and down", () async {
      await driver.waitFor(tapListViewKey);
      await Future.delayed(Duration(seconds: 3));
      await driver.waitFor(tapListViewKey);
      await Future.delayed(Duration(seconds: 1));
      await driver.scroll(tapListViewKey, 0, 200, Duration(milliseconds: 500));
      await driver.scroll(tapListViewKey, 0, -600, Duration(milliseconds: 500));
      await driver.scroll(tapListViewKey, 0, 800, Duration(milliseconds: 500));
      await Future.delayed(Duration(seconds: 1));
    });
  });
}
