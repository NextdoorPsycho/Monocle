import 'package:fast_log/fast_log.dart';
import 'package:monocle/sugar.dart';

class AuthService implements MonocleService {
  @override
  void onServiceBind() {
    info("Im info");
    error("Im error");
    warn("Im warning");
    verbose("Im verbose");
    actioned("Im actioned");
    success("Im success");
    navigation("Im navigation");
  }
}
