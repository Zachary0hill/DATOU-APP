import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReelVideoPlayer extends StatefulWidget {
  final String url;
  final bool isActive;
  final bool loop;

  const ReelVideoPlayer({
    super.key,
    required this.url,
    required this.isActive,
    this.loop = true,
  });

  @override
  State<ReelVideoPlayer> createState() => _ReelVideoPlayerState();
}

class _ReelVideoPlayerState extends State<ReelVideoPlayer> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    await controller.initialize();
    controller.setLooping(widget.loop);
    setState(() {
      _controller = controller;
      _isInitialized = true;
    });
    _syncPlayState();
  }

  @override
  void didUpdateWidget(covariant ReelVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isActive != widget.isActive) {
      _syncPlayState();
    }
    if (oldWidget.url != widget.url) {
      _controller?.dispose();
      _isInitialized = false;
      _init();
    }
  }

  void _syncPlayState() {
    if (!_isInitialized || _controller == null) return;
    if (widget.isActive) {
      _controller!.play();
    } else {
      _controller!.pause();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized || _controller == null) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        if (_controller!.value.isPlaying) {
          _controller!.pause();
        } else {
          _controller!.play();
        }
        setState(() {});
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller!.value.size.width,
              height: _controller!.value.size.height,
              child: VideoPlayer(_controller!),
            ),
          ),
          if (!_controller!.value.isPlaying)
            const Center(
              child: Icon(Icons.play_circle_outline, size: 64, color: Colors.white70),
            ),
        ],
      ),
    );
  }
}


