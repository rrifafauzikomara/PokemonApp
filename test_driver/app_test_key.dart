import 'package:flutter_driver/flutter_driver.dart';

/**
 * Please don't use "package:shared/shared.dart" imported
 * You can check the reason and the issue from this:
 * https://github.com/flutter/flutter/issues/56192#issuecomment-624101352
 */

import '../shared/lib/src/common/utils/pokemon_key.dart';

// list and detail pokemon key
final tapListViewKey = find.byValueKey(KEY_LIST_VIEW_POKEMON);