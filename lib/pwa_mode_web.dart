import 'package:web/web.dart' as web;

bool get isPwaLaunchMode {
  final standalone =
      web.window.matchMedia('(display-mode: standalone)').matches ||
      web.window.matchMedia('(display-mode: fullscreen)').matches ||
      web.window.matchMedia('(display-mode: minimal-ui)').matches;

  final storageFlag =
      web.window.sessionStorage.getItem('cfPwaLaunchMode') == '1';

  return standalone || storageFlag;
}

double get pwaBottomSafeInsetPx {
  final raw = web.window.sessionStorage.getItem('cfSafeAreaBottomPx');
  return double.tryParse(raw ?? '') ?? 0;
}
