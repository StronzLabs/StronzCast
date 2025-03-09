import 'package:flutter/foundation.dart';
import 'package:stronz_cast/src/stronz_caster_device.dart';
import 'package:stronz_cast/src/stronz_caster_media_state.dart';

class StronzCasterState extends ChangeNotifier {
    bool _discovering = false;
    bool get discovering => this._discovering;
    set discovering(bool value) {
        this._discovering = value;
        super.notifyListeners();
    }

    bool _connecting = false;
    bool get connecting => this._connecting;
    set connecting(bool value) {
        this._connecting = value;
        super.notifyListeners();
    }

    bool _connected = false;
    bool get connected => this._connected;
    set connected(bool value) {
        this._connected = value;
        super.notifyListeners();
    }

    List<StronzCasterDevice> _devices = [];
    List<StronzCasterDevice> get devices => this._devices;
    set devices(List<StronzCasterDevice> value) {
        this._devices = value;
        super.notifyListeners();
    }

    StronzCasterMediaState _mediaState = const StronzCasterMediaState(
        playing: false,
        buffering: false,
        completed: false,
        position: Duration.zero,
        duration: Duration.zero,
    );
    StronzCasterMediaState get mediaState => this._mediaState;
    set mediaState(StronzCasterMediaState value) {
        this._mediaState = value;
        super.notifyListeners();
    }
}
