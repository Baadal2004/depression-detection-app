import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PregnancyVideoScreen extends StatefulWidget {
  const PregnancyVideoScreen({super.key});

  @override
  State<PregnancyVideoScreen> createState() => _PregnancyVideoScreenState();
}

class _PregnancyVideoScreenState extends State<PregnancyVideoScreen> {
  @override
  Widget build(BuildContext context) {
    final List<VideoItem> videos = [
      VideoItem(
        title: "Pregnancy Yoga for Beginners",
        videoUrl: "https://www.youtube.com/watch?v=B87FpWtkIKA",
        category: "Pregnancy",
      ),
      VideoItem(
        title: "Period Pain Relief Tips",
        videoUrl: "https://www.youtube.com/watch?v=P9ddmRiKM_g",
        category: "Periods",
      ),
      VideoItem(
        title: "Healthy Eating During Pregnancy",
        videoUrl: "https://www.youtube.com/watch?v=0BrxCY89_uQ",
        category: "Pregnancy",
      ),
      VideoItem(
        title: "Understanding Your Cycle",
        videoUrl: "https://www.youtube.com/watch?v=vXrQ_FhZmos",
        category: "Periods",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Pregnancy & Periods Videos"),
        backgroundColor: Color(0xFFE91E63),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final video = videos[index];
            return VideoCard(video: video);
          },
        ),
      ),
    );
  }
}

class VideoItem {
  final String title;
  final String videoUrl;
  final String category;

  VideoItem({
    required this.title,
    required this.videoUrl,
    required this.category,
  });
}

class VideoCard extends StatelessWidget {
  final VideoItem video;

  const VideoCard({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenVideoPlayer(
              videoUrl: video.videoUrl,
              title: video.title,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: Colors.grey,
                  child: Center(
                    child: Icon(
                      Icons.play_circle_fill,
                      size: 48,
                      color: Color(0xFFE91E63),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: video.category == "Pregnancy"
                            // ignore: deprecated_member_use
                            ? const Color(0xFFE91E63).withOpacity(0.15)
                            // ignore: deprecated_member_use
                            : const Color(0xFF2196F3).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        video.category,
                        style: TextStyle(
                          color: video.category == "Pregnancy"
                              ? const Color(0xFFE91E63)
                              : const Color(0xFF2196F3),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FullScreenVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String title;

  const FullScreenVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.title,
  });

  @override
  State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl)!;

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFFE91E63),
        foregroundColor: Colors.white,
      ),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.pink,
      ),
    );
  }
}
