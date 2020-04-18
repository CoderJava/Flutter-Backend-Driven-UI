import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/material.dart';

final colorPrimary = Color(0xFF2DC17C);

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _buildWidget(context),
        builder: (context, snapshot) {
          var connectionState = snapshot.connectionState;
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (connectionState == ConnectionState.waiting || connectionState == ConnectionState.active) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SafeArea(child: snapshot.data);
          }
        },
      ),
    );
  }

  Future<Widget> _buildWidget(BuildContext context) async {
    var dio = Dio();
    var response = await dio.get('https://bengkelrobot.net:8003/api/dynamic-widget/home-page');
    var jsonResponse = json.encode(response.data);
    return DynamicWidgetBuilder.build(jsonResponse, context, DefaultClickListener());
  }

}

class MusicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 12.0),
          color: Colors.grey[200],
          child: Column(
            children: <Widget>[
              _buildWidgetMenuAppBar(),
              SizedBox(height: 12.0),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    _buildWidgetCarousel(),
                    SizedBox(height: 12.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Recently Played',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: SizedBox(
                        height: 133,
                        child: Row(
                          children: <Widget>[
                            _buildWidgetRecentlyPlayedPodcasts(),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  _buildWidgetRecentlyPlayedArtists(),
                                  _buildWidgetRecentlyPlayedOthers(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    _buildWidgetHeadlineItemCover('Made For You'),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: <Widget>[
                          _buildWidgetItemCover(
                            'https://i.scdn.co/image/ab67616d0000b2738e26bf4293c9da7a6439607b',
                            'Sick Boy',
                            'The Chainsmokers',
                          ),
                          SizedBox(width: 8.0),
                          _buildWidgetItemCover(
                            'https://i.scdn.co/image/ab67616d0000b273db76e31c90e4ccb1fb6bc495',
                            'Back to Life',
                            'Hailee Steinfeld',
                          ),
                          SizedBox(width: 8.0),
                          _buildWidgetItemCover(
                            'https://i.scdn.co/image/ab67616d0000b27359e699338051e7fec4f2139a',
                            'Rare',
                            'Selena Gomez',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.0),
                    _buildWidgetHeadlineItemCover('Your Top Podcasts'),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: <Widget>[
                          _buildWidgetItemCover(
                            'https://i.scdn.co/image/89b2d718b3b6e79f53b54308ac81d48161b16675',
                            'CIAYO Podcast',
                            'CIAYO Comic',
                          ),
                          SizedBox(width: 8.0),
                          _buildWidgetItemCover(
                            'https://i.scdn.co/image/cd1a9313eb09e627c99506b1f1fe571fdb3326bd',
                            'BukaTalks',
                            'Bukalapak',
                          ),
                          SizedBox(width: 8.0),
                          _buildWidgetItemCover(
                            'https://i.scdn.co/image/9ea830480d138e25db156c648ae7369ab530e0f1',
                            'Belajar UX Design',
                            'Borrys Hasian',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.0),
                    _buildWidgetHeadlineItemCover('Best Of Artists'),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: <Widget>[
                          _buildWidgetItemCover(
                            'https://i.scdn.co/image/ab67706f000000026dc792b9d6f99571dc916d13',
                            'This Is Selena Gomez',
                            'Spotify',
                          ),
                          SizedBox(width: 8.0),
                          _buildWidgetItemCover(
                            'https://i.scdn.co/image/ab67706f00000002212c821d293e82eb4bd1ba04',
                            'This Is Avril Lavigne',
                            'Spotify',
                          ),
                          SizedBox(width: 8.0),
                          _buildWidgetItemCover(
                            'https://i.scdn.co/image/ab67706f00000002efdcaeb6d5a53f0628022192',
                            'This Is Rihanna',
                            'Spotify',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetHeadlineItemCover(String headline) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            headline,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
          Text(
            'View All',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetItemCover(String urlImage, String title, String subtitle) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              urlImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 100,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetRecentlyPlayedOthers() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.library_music,
                      color: colorPrimary,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Songs',
                      style: TextStyle(
                        color: colorPrimary,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.video_library,
                      color: colorPrimary,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Videos',
                      style: TextStyle(
                        color: colorPrimary,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.album,
                      color: colorPrimary,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Albums',
                      style: TextStyle(
                        color: colorPrimary,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetRecentlyPlayedArtists() {
    return Expanded(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Wrap(
                direction: Axis.vertical,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(
                    Icons.mic,
                    color: colorPrimary,
                  ),
                  Text(
                    'Artists',
                    style: TextStyle(
                      color: colorPrimary,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Wrap(
                direction: Axis.vertical,
                children: <Widget>[
                  Text(
                    'Everything Has Changed',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Red',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Taylor Swift',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetRecentlyPlayedPodcasts() {
    return Expanded(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'http://api.bengkelrobot.net:8001/assets/images/img_current_podcast.jpeg',
                      fit: BoxFit.cover,
                      height: 80,
                      width: double.infinity,
                    ),
                  ),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Center(
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                'Podcasts for you',
                style: TextStyle(
                  color: colorPrimary,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0,
                ),
              ),
              Text(
                'Hello Goodbye',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetCarousel() {
    return Container(
      height: 150.0,
      child: PageView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'http://api.bengkelrobot.net:8001/assets/images/ariana_grande_landscape.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'http://api.bengkelrobot.net:8001/assets/images/taylor_swift_landscape.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'http://api.bengkelrobot.net:8001/assets/images/avril_lavigne_landscape.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetMenuAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Home',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 4.0),
              Container(
                width: 20.0,
                height: 2,
                decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ],
          ),
          SizedBox(width: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Discovery',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Container(
                width: 20.0,
                height: 2,
              ),
            ],
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Rooms',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Container(
                  width: 20.0,
                  height: 2,
                ),
              ],
            ),
          ),
          ClipOval(
            child: Image.network(
              'http://api.bengkelrobot.net:8001/assets/images/img_sample_avatar_2.jpg',
              width: 28.0,
              height: 28.0,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class DefaultClickListener extends ClickListener {
  @override
  void onClicked(String event) {
    // TODO: do something in here
  }
}
