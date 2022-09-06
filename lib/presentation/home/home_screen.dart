import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/domain/game_controller.dart';
import 'package:flutter_twitch_clone/domain/stream_controller.dart';
import 'package:flutter_twitch_clone/domain/tag_controller.dart';
import 'package:flutter_twitch_clone/domain/user_controller.dart';
import 'package:flutter_twitch_clone/presentation/animation/animation.dart';
import 'package:flutter_twitch_clone/presentation/components/custom_nav_bar.dart';
import 'package:flutter_twitch_clone/presentation/home/browse/browse_screen.dart';
import 'package:flutter_twitch_clone/presentation/home/following/following_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/constant.dart';
import '../components/info_card.dart';
import 'discover/discover_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  static const route = '/home';

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

final indexProvider = StateProvider<int>((ref) => 0);

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  //static final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  late TabController _tabController;
  final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  List<Widget> pageList = [
    const FollowingScreen(),
    const DiscoverScreen(),
    const BrowseScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final currIndex = ref.watch(indexProvider.state).state;
    return Scaffold(
      //key: scaffoldKey,
      appBar: CustomNavBar(),
      drawer: Drawer(
        backgroundColor: kBgColor,
        child: ListView(
          children: [
            ListTile(
              leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back,
                  )),
              title: Text('Settings'),
            ),
            InfoCard(),
          ],
        ),
      ),
      body: Navigator(
        key: navKey,
        onGenerateRoute: (_) => MaterialPageRoute(builder: (_) {
          return pageList[currIndex];


          //   PageTransitionSwitcher(transitionBuilder: (child, animation, secondaryAnimation) {
          //   return SharedAxisTransition(animation: animation, secondaryAnimation: secondaryAnimation, transitionType: SharedAxisTransitionType.horizontal);
          // },
          //   child: pageList[currIndex],
          // );

           // pageList[currIndex];
          // Widget screen = FollowingScreen();
          // switch (currIndex) {
          //   case 0:
          //     screen = FollowingScreen();
          //     break;
          //   case 1:
          //     screen = DiscoverScreen();
          //     break;
          //   case 2:
          //     screen = BrowseScreen();
          //     break;
          // }
          // return screen;

          // return TabBarView(
          //   controller: _tabController,
          //   children: [FollowingScreen(), DiscoverScreen(), BrowseScreen()],
          // );
        }),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey)]),
        child: BottomNavigationBar(
            currentIndex: currIndex,
            onTap: (index) {
              //_tabController.animateTo(index);
              if(index == currIndex){
                // do nothing
              }
              else if (index == 0) {
                navKey.currentState!.pushReplacement(
                    FadedNavigation(child: FollowingScreen()));
              } else if (index == 1) {
                  // navKey.currentState!.pushReplacement(
                  //     FadedNavigation(child: DiscoverScreen()));
                if (currIndex == 0) {
                  navKey.currentState!.pushReplacement(
                      FadedNavigation(child: DiscoverScreen(), reverse: true));
                } else {
                  navKey.currentState!.pushReplacement(
                      FadedNavigation(child: DiscoverScreen()));
                }
              } else if (index == 2) {
                navKey.currentState!.pushReplacement(
                    FadedNavigation(child: BrowseScreen(), reverse: true));
                // navKey.currentState!
                //     .pushReplacement(NavigateRightToLeftAnimation(child: BrowseScreen()));
              }
              ref.read(indexProvider.notifier).state = index;
            },
            selectedItemColor: kPrimaryColor,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w700,
            ),
            items: [
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.favorite, color: kPrimaryColor),
                icon: Icon(Icons.favorite_outline, color: kPrimaryColor),
                label: 'Following',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.compass, color: kPrimaryColor),
                label: 'Discover',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.clone, color: kPrimaryColor),
                label: 'Browse',
              ),
            ]),
      ),
    );

    // const TabBar(
    //   labelColor: kPrimaryColor,
    //   indicatorColor: kPrimaryColor,
    //
    //   tabs: [
    //     Tab(
    //       icon: Icon(Icons.favorite, color: kPrimaryColor),
    //       text: 'Following',
    //     ),
    //     Tab(
    //       icon: FaIcon(FontAwesomeIcons.compass),
    //       text: 'Discover',
    //     ),
    //     Tab(
    //       icon: FaIcon(FontAwesomeIcons.clone),
    //       text: 'Browse',
    //     )
    //   ],
    // ),
  }
}
