import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MusicPlayer extends StatefulWidget {
  final String url;
  const MusicPlayer({Key? key, required this.url}) : super(key: key);
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  Duration? _duration;
  Duration? _position;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
    );

    _initializeVideoPlayerFuture = _controller!.initialize().then((_) {
      setState(() {
        _duration = _controller!.value.duration;
      });

      _controller!.addListener(() {
        setState(() {
          _position = _controller!.value.position;
        });
      });
    });

    _controller!.setLooping(true);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SizedBox(height: 10, child: VideoPlayer(_controller!));
            } else {
              return SizedBox.shrink();
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        IgnorePointer(
          child: Slider(
            activeColor: Colors.black,
            inactiveColor: Colors.grey,
            value: _position?.inSeconds.toDouble() ?? 0.0,
            max: _duration?.inSeconds.toDouble() ?? 1.0,
            onChanged: (value) {
              setState(() {
                _controller!.seekTo(Duration(seconds: value.toInt()));
              });
            },
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              if (_controller!.value.isPlaying) {
                _controller?.pause();
              } else {
                _controller!.play();
              }
            });
          },
          icon: Container(
            height: MediaQuery.of(context).size.width < 500 ? 30 : 50,
            width: MediaQuery.of(context).size.width < 500 ? 30 : 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: Icon(
              _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
