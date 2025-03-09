class StronzCasterMediaState {
    final bool? playing;
    final bool? buffering;
    final bool? completed;
    final Duration? position;
    final Duration? duration;

    const StronzCasterMediaState({
        required this.playing,
        required this.buffering,
        required this.completed,
        required this.position,
        required this.duration,
    });
}
