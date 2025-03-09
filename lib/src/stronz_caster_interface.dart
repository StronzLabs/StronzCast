import 'dart:async';
import 'package:stronz_cast/src/stronz_caster_device.dart';

abstract class StronzCasterInterface {
    const StronzCasterInterface();

    Future<List<StronzCasterDevice>> discovery();
    Future<void> connect(StronzCasterDevice device);
    Future<void> disconnect();

    Future<bool> loadMedia(Uri uri);
    Future<void> play();
    Future<void> pause();
    Future<void> stop();
    Future<void> seekTo(Duration position);
    Future<void> setVolume(double volume);
}
