import 'dart:async';

import 'package:stronz_cast/src/implementations/castv2.dart';
import 'package:stronz_cast/src/implementations/dlna.dart';
import 'package:stronz_cast/src/stronz_caster_device.dart';
import 'package:stronz_cast/src/stronz_caster_interface.dart';
import 'package:stronz_cast/src/stronz_caster_state.dart';

class StronzCastManager {
    static final StronzCasterState state = StronzCasterState();
    static get discovering => StronzCastManager.state.discovering;
    static get connecting => StronzCastManager.state.connecting;
    static get connected => StronzCastManager.state.connected;
    static get devices => StronzCastManager.state.devices;

    static final List<StronzCasterInterface> _interfaces = [
        CastV2(),
        DLNA(),
    ];

    static StronzCasterInterface? _activeInterface;

    static Future<List<StronzCasterDevice>> discovery() async {
        StronzCastManager.state.discovering = true;

        StronzCastManager.state.devices = [
            for (StronzCasterInterface interface in StronzCastManager._interfaces)
                ...await interface.discovery()
        ];

        StronzCastManager.state.discovering = false;
        return StronzCastManager.state.devices;
    }

    static Future<void> connect(StronzCasterDevice device) async {
        await StronzCastManager.disconnect();
        StronzCastManager.state.connecting = true;

        switch (device.runtimeType) {
            case CastV2Device:
                StronzCastManager._activeInterface = StronzCastManager._interfaces.firstWhere((interface) => interface is CastV2);
                break;
            case DlnaDevice:
                StronzCastManager._activeInterface = StronzCastManager._interfaces.firstWhere((interface) => interface is DLNA);
                break;
            default:
                throw UnimplementedError();
        }
        await StronzCastManager._activeInterface!.connect(device);

        StronzCastManager.state.connecting = false;
    }

    static Future<void> disconnect() async {
        await StronzCastManager._activeInterface?.disconnect();
        StronzCastManager.state.connected = false;
    }

    static Future<bool> loadMedia(Uri uri) async => await StronzCastManager._activeInterface?.loadMedia(uri) ?? false;
    static Future<void> play() async => await StronzCastManager._activeInterface?.play();
    static Future<void> pause() async => await StronzCastManager._activeInterface?.pause();
    static Future<void> stop() async => await StronzCastManager._activeInterface?.stop();
    static Future<void> seekTo(Duration position) async => await StronzCastManager._activeInterface?.seekTo(position);
    static Future<void> setVolume(double volume) async => await StronzCastManager._activeInterface?.setVolume(volume);
}
