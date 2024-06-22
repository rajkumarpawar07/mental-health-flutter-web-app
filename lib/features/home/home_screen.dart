import 'package:ai_chatbot/features/Profile/Controller/profile_screen_controller.dart';
import 'package:ai_chatbot/features/Profile/profile_screen.dart';
import 'package:ai_chatbot/features/chatbot/chatbot_screen.dart';
import 'package:ai_chatbot/features/home/widgets/music_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../testScreens/test_screen_1.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> items = [
    {
      'title': 'Noam Shpancer',
      'subtitle':
          '\"Mental health is not a destination, but a process. It’s about how you drive, not where you’re going.\"',
      'image':
          'https://66.media.tumblr.com/6fb397d822f4f9f4596dff2085b18f2e/tumblr_nzsvb4p6xS1qho82wo1_1280.jpg',
      'icon': Icons.directions_walk,
      'color': const Color(0xFFED5565),
    },
    {
      'title': 'Glenn Close',
      'subtitle':
          '\"What mental health needs is more sunlight, more candor, and more unashamed conversation.\"',
      'image':
          'https://66.media.tumblr.com/8b69cdde47aa952e4176b4200052abf4/tumblr_o51p7mFFF21qho82wo1_1280.jpg',
      'icon': Icons.ac_unit,
      'color': const Color(0xFFFC6E51)
    },
    {
      'title': 'Mariska Hargitay',
      'subtitle':
          '\"Healing takes time, and asking for help is a courageous step.\"',
      'image':
          'https://66.media.tumblr.com/5af3f8303456e376ceda1517553ba786/tumblr_o4986gakjh1qho82wo1_1280.jpg',
      'icon': Icons.park,
      'color': const Color(0xFFFFCE54)
    },
    {
      'title': 'Rainer Maria Rilke',
      'subtitle': '"The only journey is the journey within."',
      'image':
          'https://66.media.tumblr.com/5516a22e0cdacaa85311ec3f8fd1e9ef/tumblr_o45jwvdsL11qho82wo1_1280.jpg',
      'icon': Icons.water_drop,
      'color': const Color(0xFF2ECC71)
    },
    {
      'title': 'Dan Millman',
      'subtitle':
          "\"You don’t have to control your thoughts. You just have to stop letting them control you.\"",
      'image':
          'https://66.media.tumblr.com/f19901f50b79604839ca761cd6d74748/tumblr_o65rohhkQL1qho82wo1_1280.jpg',
      'icon': Icons.sunny,
      'color': const Color(0xFF5D9CEC)
    },
    {
      'title': 'Noam Shpancer',
      'subtitle':
          '\"Mental health is not a destination, but a process. It’s about how you drive, not where you’re going.\"',
      'image':
          'https://66.media.tumblr.com/6fb397d822f4f9f4596dff2085b18f2e/tumblr_nzsvb4p6xS1qho82wo1_1280.jpg',
      'icon': Icons.directions_walk,
      'color': const Color(0xFFED5565),
    },
    {
      'title': 'Glenn Close',
      'subtitle':
          '\"What mental health needs is more sunlight, more candor, and more unashamed conversation.\"',
      'image':
          'https://66.media.tumblr.com/8b69cdde47aa952e4176b4200052abf4/tumblr_o51p7mFFF21qho82wo1_1280.jpg',
      'icon': Icons.ac_unit,
      'color': const Color(0xFFFC6E51)
    },
    {
      'title': 'Mariska Hargitay',
      'subtitle':
          '\"Healing takes time, and asking for help is a courageous step.\"',
      'image':
          'https://66.media.tumblr.com/5af3f8303456e376ceda1517553ba786/tumblr_o4986gakjh1qho82wo1_1280.jpg',
      'icon': Icons.park,
      'color': const Color(0xFFFFCE54)
    },
    {
      'title': 'Rainer Maria Rilke',
      'subtitle': '"The only journey is the journey within."',
      'image':
          'https://66.media.tumblr.com/5516a22e0cdacaa85311ec3f8fd1e9ef/tumblr_o45jwvdsL11qho82wo1_1280.jpg',
      'icon': Icons.water_drop,
      'color': const Color(0xFF2ECC71)
    },
    {
      'title': 'Dan Millman',
      'subtitle':
          "\"You don’t have to control your thoughts. You just have to stop letting them control you.\"",
      'image':
          'https://66.media.tumblr.com/f19901f50b79604839ca761cd6d74748/tumblr_o65rohhkQL1qho82wo1_1280.jpg',
      'icon': Icons.sunny,
      'color': const Color(0xFF5D9CEC)
    },
  ];
  int colorEffectIndex = 0;

  late TabController _tabController;
  bool showStreak = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    setTimer();
  }

  setTimer() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      showStreak = false;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileScreenController());
    double width = MediaQuery.of(context).size.width;
    return showStreak
        ? Scaffold(
            backgroundColor: Colors.white24,
            body: Center(child: Lottie.asset('assets/lottie/fire_streak.json')))
        : Scaffold(
            backgroundColor: Colors.white24,
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    toolbarHeight: 30,
                    elevation: 10,
                    shadowColor: Colors.black,
                    surfaceTintColor: Colors.white,
                    floating: true,
                    pinned: false,
                    expandedHeight: 50.0, // Reduced height
                    flexibleSpace: FlexibleSpaceBar(
                      title: MediaQuery.of(context).size.width > 500
                          ? Text("EzeeMind",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24))
                          : null,
                      background: Container(
                        color: Colors.black,
                      ),
                    ),
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(50.0),
                      child: Container(
                        color: Colors.black,
                        child: TabBar(
                          // dividerColor: Colors.black,
                          dividerHeight: 0,
                          tabAlignment: TabAlignment.center,
                          indicatorColor: Color.fromARGB(255, 71, 233, 133),
                          controller: _tabController,
                          isScrollable: true,
                          labelColor: Colors.white,
                          labelStyle: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                          unselectedLabelColor: Colors.grey,
                          unselectedLabelStyle: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          ),
                          tabs: [
                            Tab(text: "Home"),
                            Tab(text: "AI ChatBot"),
                            Tab(text: "Profile"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Greetings ',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 71, 233, 133),
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  500
                                              ? 40
                                              : 32,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${controller.name.text},',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 71, 233, 133),
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  500
                                              ? 40
                                              : 32,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24.0),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Welcome to ',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        500
                                                    ? 50
                                                    : 32,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'EzeeMind',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        500
                                                    ? 50
                                                    : 32,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            MediaQuery.of(context).size.width > 1010
                                ? Column(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  '${controller.streak.toString()} ',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        500
                                                    ? 40
                                                    : 32,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Consecutive days',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        500
                                                    ? 40
                                                    : 32,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            Lottie.asset('assets/lottie/fire_streak.json',
                                height: 100),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 25,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 71, 233, 133),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Featured Quotes',
                                style: TextStyle(
                                  color: Colors
                                      .black, // Change this to your desired color
                                  fontSize:
                                      MediaQuery.of(context).size.width > 500
                                          ? 30
                                          : 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Stack(
                          children: [
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: ExpandingCards(
                                height: 400,
                                items: items,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 24.0),
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 71, 233, 133),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Listen this',
                                style: TextStyle(
                                  color: Colors
                                      .black, // Change this to your desired color
                                  fontSize:
                                      MediaQuery.of(context).size.width > 500
                                          ? 30
                                          : 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ResponsiveLayout(
                          mobileBody: const MobileScaffold(),
                          tabletBody: const TabletScaffold(),
                          desktopBody: const DesktopScaffold(),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 24.0),
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         width: 10,
                        //         height: 25,
                        //         decoration: const BoxDecoration(
                        //           color: Color.fromARGB(255, 71, 233, 133),
                        //           borderRadius: BorderRadius.only(
                        //             topRight: Radius.circular(5),
                        //             bottomRight: Radius.circular(5),
                        //           ),
                        //         ),
                        //       ),
                        //       const SizedBox(
                        //         width: 10,
                        //       ),
                        //       Text(
                        //         'Featured Quotes',
                        //         style: TextStyle(
                        //           color: Colors
                        //               .black, // Change this to your desired color
                        //           fontSize:
                        //               MediaQuery.of(context).size.width > 500
                        //                   ? 30
                        //                   : 24,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  AiChatbotScreen(),
                  const ProfileScreen(),
                ],
              ),
            ),
          );
  }
}

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({Key? key}) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: SizedBox(
          width: double.infinity,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return MyBox(
                url: audios[index],
                poster: posters[index],
              );
            },
          ),
        ),
      ),
    );
  }
}

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 4,
        child: SizedBox(
          width: double.infinity,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4),
            itemBuilder: (context, index) {
              return MyBox(
                url: audios[index],
                poster: posters[index],
              );
            },
          ),
        ),
      ),
      // second half of page
    );
  }
}

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({Key? key}) : super(key: key);

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
          // first 4 boxes in grid
          AspectRatio(
        aspectRatio: 4,
        child: SizedBox(
          width: double.infinity,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4),
            itemBuilder: (context, index) {
              return MyBox(
                url: audios[index],
                poster: posters[index],
              );
            },
          ),
        ),
      ),
    );
  }
}

List<String> audios = [
  'https://www.buddhanet.net/filelib/mp3/balance.mp3',
  'https://www.buddhanet.net/filelib/mp3/mental.mp3',
  'https://www.buddhanet.net/filelib/mp3/sixsense.mp3',
  'https://www.buddhanet.net/filelib/mp3/artattn.mp3',
];

List<String> posters = [
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGpZ1LKMxwCrVOuGpPSzFpQXlH8vzSFQ2W6w&s',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRl2dBsU28J2JEBofLUQzqtFifeRw2dHvB1kA&s',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfp4yCEGYx255kKzKW-KlCcUFa80X8hf5dRg&s',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQysSBukfDQ2dyKrCAWRVLWOPy7ybqVz2tzUw&s',
];

class MyBox extends StatelessWidget {
  final String url;
  final String poster;
  const MyBox({super.key, required this.url, required this.poster});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 2,
              spreadRadius: 2,
              offset: const Offset(0, 0),
            ),
          ],
          image: DecorationImage(
            image: NetworkImage(poster),
            fit: BoxFit.cover,
          ),
          backgroundBlendMode: BlendMode.darken,
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[400],
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: MusicPlayer(
            url: url,
          ),
        ),
      ),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget tabletBody;
  final Widget desktopBody;

  ResponsiveLayout({
    required this.mobileBody,
    required this.tabletBody,
    required this.desktopBody,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          return mobileBody;
        } else if (constraints.maxWidth < 1100) {
          return tabletBody;
        } else {
          return desktopBody;
        }
      },
    );
  }
}

class ExpandingCards extends StatefulWidget {
  final double height;
  final List<Map<String, dynamic>> items;

  const ExpandingCards({
    super.key,
    required this.height,
    required this.items,
  });

  @override
  State<ExpandingCards> createState() => _ExpandingCardsState();
}

class _ExpandingCardsState extends State<ExpandingCards>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: ListView.builder(
        itemCount: widget.items.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 56),
        addRepaintBoundaries: true,
        itemBuilder: (context, index) {
          final item = widget.items[index % widget.items.length];
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: AnimatedCardItem(
              key: ValueKey(index),
              title: item['title'],
              subtitle: item['subtitle'],
              image: item['image'],
              icon: item['icon'] as IconData,
              iconColor: item['color'] as Color,
              isExpanded: _selectedIndex == index,
              animation: _controller,
              onTap: () => onExpand(_selectedIndex == index ? -1 : index),
            ),
          );
        },
      ),
    );
  }

  void onExpand(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class AnimatedCardItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final String image;
  final IconData icon;
  final Animation<double> animation;
  final bool isExpanded;
  final VoidCallback onTap;
  final Color iconColor;

  const AnimatedCardItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.icon,
    required this.animation,
    required this.isExpanded,
    required this.onTap,
    required this.iconColor,
  });

  @override
  State<AnimatedCardItem> createState() => _AnimatedCardItemState();
}

class _AnimatedCardItemState extends State<AnimatedCardItem> {
  bool shouldRect = false;

  @override
  void didUpdateWidget(covariant AnimatedCardItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isExpanded != widget.isExpanded) {
      shouldRect = true;
    } else {
      shouldRect = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    const double collapsedWidth = 70;
    return Align(
      alignment: Alignment.centerLeft,
      child: MouseRegion(
        onEnter: (_) {
          widget.onTap();
        },
        onExit: (_) {
          // widget.onTap();
        },
        child: GestureDetector(
          // onTap: widget.onTap,
          child: AnimatedBuilder(
            animation: widget.animation,
            builder: (context, child) {
              double value = shouldRect
                  ? widget.isExpanded
                      ? widget.animation.value
                      : 1 - widget.animation.value
                  : widget.isExpanded
                      ? 1
                      : 0;

              final double animValue = widget.isExpanded
                  ? const Interval(0, 0.5, curve: Curves.fastOutSlowIn)
                      .transform(value)
                  : Interval(0.5, 1, curve: Curves.fastOutSlowIn.flipped)
                      .transform(value);

              final imageScaleValue = widget.isExpanded
                  ? const Interval(0.2, 1, curve: Curves.easeOut)
                      .transform(value)
                  : const Interval(0.8, 1, curve: Curves.easeOut)
                      .transform(value);

              final titleValue = widget.isExpanded
                  ? const Interval(0.2, 0.8, curve: Curves.easeOut)
                      .transform(value)
                  : const Interval(0.2, 0.8, curve: Curves.easeOut)
                      .transform(value);

              final subtitleValue = widget.isExpanded
                  ? const Interval(0.4, 0.8, curve: Curves.easeOut)
                      .transform(value)
                  : const Interval(0.4, 0.8, curve: Curves.easeOut)
                      .transform(value);

              return Transform.scale(
                scale: 1 + animValue * 0.02,
                child: Container(
                  width: collapsedWidth + animValue * (600 - collapsedWidth),
                  height: 400 + (animValue * 20),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(collapsedWidth / 2),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Transform.scale(
                          scale: 1.2 - imageScaleValue * 0.03,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(widget.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                            foregroundDecoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0),
                                  Colors.black.withOpacity(1),
                                ],
                                stops: const [0.7, 1],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10 + animValue * 10,
                            vertical: 10 + animValue * 12,
                          ),
                          child: Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: SizedBox.square(
                                  dimension: 50,
                                  child: Center(
                                    child: Icon(
                                      widget.icon,
                                      color: widget.iconColor,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                              if (widget.isExpanded)
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Opacity(
                                          opacity: titleValue,
                                          child: Transform.translate(
                                            offset: Offset(
                                              20 * (1 - titleValue),
                                              0,
                                            ),
                                            child: Text(
                                              widget.title,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                fontSize: 32,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // const SizedBox(height: 2),
                                        Opacity(
                                          opacity: subtitleValue,
                                          child: Transform.translate(
                                            offset: Offset(
                                              20 * (1 - subtitleValue),
                                              0,
                                            ),
                                            child: Text(
                                              widget.subtitle,
                                              maxLines: 3,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 28,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
