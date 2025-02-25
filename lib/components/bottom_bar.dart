import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sound_on_fire/components/small_button.dart';
import 'package:sound_on_fire/models/Track.dart';
import 'package:sound_on_fire/util/constants.dart';

class BottomBar extends StatelessWidget {
  final Function playPause;
  final Function backward;
  final Function forward;
  final Function stop;
  final Track track;
  final AudioPlayer audioPlayer;
  final Duration currentAudioPosition;

  BottomBar({
    this.playPause,
    this.backward,
    this.forward,
    this.stop,
    this.track,
    this.audioPlayer,
    this.currentAudioPosition,
  });

  String printDuration() {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes =
        twoDigits(this.currentAudioPosition.inMinutes.remainder(60));
    String twoDigitSeconds =
        twoDigits(this.currentAudioPosition.inSeconds.remainder(60));
    return "${twoDigits(this.currentAudioPosition.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: 65,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: SmallButton(
                      autoFocus: false,
                      icon: Icon(Icons.fast_rewind),
                      onClick: track != null ? backward : null,
                    ),
                  ),
                  Expanded(
                    child: SmallButton(
                      autoFocus: false,
                      icon: Icon(audioPlayer.state != AudioPlayerState.PLAYING
                          ? Icons.play_arrow
                          : Icons.pause),
                      onClick: track != null ? playPause : null,
                    ),
                  ),
                  Expanded(
                    child: SmallButton(
                      autoFocus: false,
                      icon: Icon(Icons.fast_forward),
                      onClick: track != null ? forward : null,
                    ),
                  ),
                  Expanded(
                    child: SmallButton(
                      autoFocus: false,
                      icon: Icon(Icons.stop),
                      onClick: stop,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      // padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(track != null && currentAudioPosition != null
                          ? printDuration()
                          : ""),
                    ),
                  ),
                  Expanded(
                    flex: 12,
                    child: Container(
                      child: track != null && currentAudioPosition != null
                          ? Slider(
                              value: currentAudioPosition.inSeconds.toDouble(),
                              min: 0.0,
                              max: track.duration.inSeconds.toDouble(),
                              divisions: null,
                              onChanged: (double value) {},
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(" 🔊☁️ 🔥📺"),
                                Text(
                                  "SoundOnFire",
                                  style: const TextStyle(
                                    color: primaryOrange,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      // padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(track != null ? track.printDuration() : ""),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: track != null
                        ? Container(
                            child: track.artwork != null
                                ? Image.network(track.artwork)
                                : FlutterLogo(),
                          )
                        : Text(""),
                  ),
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          track != null ? track.title : "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
