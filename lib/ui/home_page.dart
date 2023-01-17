import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform = MethodChannel("samples.flutter.dev/battery");
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  double height = 0.0;
  int add = 0;
  bool backWard = false;
  bool forward = false;
  int forwardValue = 0;
  int backWardValue = 0;

  bool _isPlaying = false;
  late Duration _duration;
  late Duration _position;
  bool _isEnd = false;

  @override
  void initState() {
    super.initState();

    _controller =
        VideoPlayerController.asset("assets/video/sample-mp4-file.mp4")
          ..addListener(() {
            _position = _controller.value.position;
            final bool isPlaying = _controller.value.isPlaying;
            if (isPlaying != _isPlaying) {
              setState(() {
                _isPlaying = isPlaying;
              });
            }
            Timer.run(() {
              setState(() {
                _position = _controller.value.position;
              });
            });
            setState(() {
              _duration = _controller.value.duration;
            });
            _duration.compareTo(_position) == 0 ||
                    _duration.compareTo(_position) == -1
                ? setState(() {
                    _isEnd = true;
                  })
                : setState(() {
                    _isEnd = false;
                  });
          })
          ..initialize();

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setPlaybackSpeed(1);
    height = _controller.value.aspectRatio;

    _controller.setLooping(false);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.

    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 3;
    double aspect = _controller.value.aspectRatio;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player Demo'),
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: Column(
        children: [
          Stack(
            children: [
              // Video Player
              GestureDetector(
                onTap: () {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                },
                child: FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If the VideoPlayerController has finished initialization, use
                      // the data it provides to limit the aspect ratio of the video.
                      return AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        // Use the VideoPlayer widget to display the video.
                        child: VideoPlayer(_controller),
                      );
                    } else {
                      // If the VideoPlayerController is still initializing, show a
                      // loading spinner.
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        backWard = true;
                        backWardValue += 10;
                      });

                      _controller.seekTo(Duration(
                          seconds: _controller.value.position.inSeconds - 10));
                      Future.delayed(const Duration(seconds: 1), () {
                        setState(() {
                          backWard = false;
                          backWardValue = 0;
                        });
                      });
                    },
                    child: Container(
                      height: width / aspect,
                      width: MediaQuery.of(context).size.width / 3,
                      color: Colors.transparent,
                      child: Center(
                          child: backWard
                              ? Text(
                                  "$backWardValue\uf047",
                                  style: const TextStyle(color: Colors.white),
                                )
                              : Container()),
                    ),
                  ),
                ),
              ),

              // buttons
              Positioned(
                  bottom: 5,
                  left: 10,
                  top: 5,
                  right: 10,
                  child: _isEnd
                      ? IconButton(
                          onPressed: () {
                            print(_isEnd);
                            _controller.initialize();
                          },
                          icon: const Icon(
                            Icons.replay,
                            color: Colors.white,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  _controller.seekTo(Duration(
                                      seconds:
                                          _controller.value.position.inSeconds -
                                              10));
                                },
                                icon: Icon(
                                  Icons.fast_rewind,
                                  color: _controller.value.isPlaying
                                      ? Colors.transparent
                                      : Colors.white,
                                )),

                            const Padding(padding: EdgeInsets.all(2)),

                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (_controller.value.isPlaying) {
                                    _controller.pause();
                                  } else {
                                    // If the video is paused, play it.
                                    _controller.play();
                                  }
                                });
                              },
                              // Display the correct icon depending on the state of the player.
                              icon: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: _controller.value.isPlaying
                                    ? Colors.transparent
                                    : Colors.white,
                              ),
                            ),

                            const Padding(padding: EdgeInsets.all(2)),

                            IconButton(
                                onPressed: () {
                                  _controller.seekTo(Duration(
                                      seconds:
                                          _controller.value.position.inSeconds +
                                              10));
                                },
                                icon: Icon(
                                  Icons.fast_forward,
                                  color: _controller.value.isPlaying
                                      ? Colors.transparent
                                      : Colors.white,
                                )),

                            // dsfghjkl
                          ],
                        )),

              Positioned(
                left: 2 * (MediaQuery.of(context).size.width / 3),
                bottom: 0,
                top: 0,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    overlayColor: MaterialStateProperty.all(
                        Colors.grey.withOpacity(0.06)),
                    onTap: () {
                      setState(() {
                        forward = true;
                        forwardValue += 10;
                      });
                      _controller.seekTo(Duration(
                          seconds: _controller.value.position.inSeconds + 10));
                      Future.delayed(const Duration(seconds: 1), () {
                        setState(() {
                          forward = false;
                          forwardValue = 0;
                        });
                      });
                    },
                    child: Container(
                      height: width / aspect,
                      width: MediaQuery.of(context).size.width / 3,
                      color: Colors.transparent,
                      child: Center(
                          child: forward
                              ? Text(
                                  "$forwardValue\uf047",
                                  style: const TextStyle(color: Colors.white),
                                )
                              : Container()),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: _controller.value.isPlaying ? 0 : 5,
                width: MediaQuery.of(context).size.width,
                child: VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: const VideoProgressColors(
                      // backgroundColor: Colors.red,
                      bufferedColor: Colors.black,
                      playedColor: Colors.blueAccent),
                ),
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                printSomething();
              },
              child: Text("dfsg"))
        ],
      ),
    );
  }

  Future<void> printSomething() async {
    try {
      final String result = await platform.invokeMethod("get_print");
      return;
    } on PlatformException {
      rethrow;
    }
  }
}
