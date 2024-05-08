import 'package:flutter/material.dart';

enum AppStates { Sleep, Locked, UnLocked }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const ConnectMe(),
    );
  }
}

class ConnectMe extends StatefulWidget {
  const ConnectMe({super.key});

  @override
  State<ConnectMe> createState() => _ConnectMeState();
}

class _ConnectMeState extends State<ConnectMe> {
  AppStates states = AppStates.Sleep;

  List<Widget> notchWidget = [];
  Color notchbg = Colors.black;
  Color screenColor = Colors.black;
  Size iphoneSize = const Size(335, 700);

  Size notchSize = const Size(100, 27);
  Size lenswidth = const Size(45, 15);
  double lockPosition = 0;
  final gradient = const [
    Color(0xFF696969),
    Color(0xFF484848),
    Color(0xFF3D3D3D)
  ];
  List<String> asset = [
    'assets/flutter.png',
    'assets/ios.png',
    'assets/android.png',
    'assets/python.png'
  ];

  bool expand = false;
  bool showNotification = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initializeLists();
  }

  _updateStates() {
    switch (states) {
      case AppStates.Sleep:
        lockPosition = 0;
        screenColor = Colors.black;
        notchbg = const Color.fromARGB(255, 20, 19, 19);
        break;

      case AppStates.Locked:
        notchbg = const Color.fromARGB(255, 34, 32, 32);
        screenColor = Colors.white;
        break;
      default:
    }
    setState(() {});
  }

  initializeLists() {
    notchWidget = [
      Container(
        width: lenswidth.width,
        height: lenswidth.height,
        decoration: const BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            width: notchSize.height * .4,
            height: notchSize.height * .4,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(82, 64, 112, 0.376).withOpacity(.5),
                shape: BoxShape.circle),
          ),
          Container(
            width: notchSize.height * .4,
            height: notchSize.height * .4,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(82, 64, 112, 0.376).withOpacity(.5),
                shape: BoxShape.circle),
          ),
        ]),
      ),
      lens(
        Align(
          child: Container(
            width: notchSize.height * .4,
            height: notchSize.height * .4,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(82, 64, 112, 0.376).withOpacity(.4),
                shape: BoxShape.circle),
          ),
        ),
      ),
    ];
  }

  stater() {
    print('Before ' + '${states}');
    if (states == AppStates.Sleep) {
      states = AppStates.Locked;
    } else if (states == AppStates.Locked) {
      states = AppStates.UnLocked;
    } else {
      states = AppStates.Sleep;
    }
    print('After ' + '${states}');
    _updateStates();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        stater();
      },
      child: Scaffold(
          backgroundColor: const Color(0XFF383838),
          body: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: iphoneSize.width,
                  height: iphoneSize.height,
                  decoration: BoxDecoration(
                      color: screenColor,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.black,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white.withOpacity(.5),
                            blurRadius: 1,
                            spreadRadius: 0.1)
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Stack(alignment: Alignment.topCenter, children: [
                      lockView(),
                      notchView(),
                    ]),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  unlockView() {
    return Container(
      margin: const EdgeInsets.all(16),
      width: double.maxFinite,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            width: iphoneSize.width * .4,
            margin: const EdgeInsets.only(bottom: 16),
            child: Image.asset('assets/arman.jpeg')),
        const Text(
          'in/armankhalid',
          // ignore: unnecessary_const
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 23, 85, 129),
              fontSize: 22,
              height: .8,
              wordSpacing: 0),
        ),
        const SizedBox(height: 18),
        const Text(
          '''Follow for more''',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              height: 1,
              color: Colors.black),
        ),
        const SizedBox(height: 40),
        Row(
            children: List.generate(
          asset.length,
          (index) => Container(
              width: iphoneSize.width * .2,
              margin: const EdgeInsets.only(bottom: 16),
              child: Image.asset(
                asset[index],
                fit: BoxFit.cover,
              )),
        ))
      ]),
    );
  }

  lockView() {
    if (states != AppStates.Sleep) {
      return Stack(
        children: [
          unlockView(),
          AnimatedPositioned(
            duration: Duration(milliseconds: lockPosition < -400 ? 400 : 100),
            top: lockPosition,
            child: Stack(
              children: [
                phoneBg(),
                AnimatedOpacity(
                  opacity: states == AppStates.Sleep ? 0 : 1,
                  duration: Duration(
                      milliseconds: states == AppStates.Sleep ? 0 : 400),
                  child: Container(
                    height: iphoneSize.height,
                    width: iphoneSize.width,
                    padding: const EdgeInsets.all(16).copyWith(top: 64),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        timeView(),
                        bottomView(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
    return Container(
      color: Colors.black,
    );
  }

  timeView() {
    return const Column(
      children: [
        Text(
          'Tuesday 7 May',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              height: .8,
              wordSpacing: 0),
        ),
        Text(
          '18:05',
          style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 72, height: 1.3),
        )
      ],
    );
  }

  bottomView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        bottombutton(Icons.phone),
        bottomBar(),
        bottombutton(Icons.camera_alt_rounded)
      ],
    );
  }

  phoneBg() {
    return Container(
        width: iphoneSize.width,
        height: iphoneSize.height,
        child: Image.asset(
          'assets/iphonebg.jpg',
          fit: BoxFit.cover,
          color: screenColor.withOpacity(.9),
          colorBlendMode: BlendMode.darken,
        ));
  }

  bottomBar() {
    return GestureDetector(
      onVerticalDragUpdate: (v) {
        double val = v.globalPosition.dy.clamp(0, 700);
        lockPosition = 0 - (iphoneSize.height - val);
        if (lockPosition < -400 && states == AppStates.Locked) {
          stater();
        }

        setState(() {});
      },
      onVerticalDragEnd: (v) {
        print('Cancelled State - ${states}');
        if (states == AppStates.UnLocked) {
          lockPosition = -700;
          print('updatedPositoin');
          setState(() {});
        } else {
          lockPosition = 0;
          setState(() {});
        }
      },
      child: Container(
        height: 50,
        width: 200,
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedContainer(
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 200),
            width: 120,
            height: 3,
            margin: EdgeInsets.only(bottom: states == AppStates.Sleep ? 0 : 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget bottombutton(IconData icon) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Colors.black.withOpacity(.3)),
        child: Icon(
          icon,
        ));
  }

  Widget notchView() {
    return GestureDetector(
      onLongPressStart: (v) {
        updateCamera(
          showIcon: true,
        );
      },
      onLongPressEnd: (v) {
        updateCamera(showIcon: false);
      },
      onTap: () {
        updateCamera(bigBox: expand);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        onEnd: () {
          setState(() {
            showNotification = true;
          });
        },
        margin: const EdgeInsets.only(top: 8),
        height: notchSize.height,
        width: notchSize.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: notchbg),
        child: Stack(
          children: [
            Positioned(
              top: 6,
              left: 0,
              right: 0,
              child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 6,
                  children: List.generate(
                      notchWidget.length, (index) => notchWidget[index])),
            ),
            if (showNotification && expand)
              Positioned(
                  bottom: 32,
                  right: 32,
                  left: 32,
                  child: Row(
                    children: [
                      Container(
                          height: 32,
                          width: 32,
                          child: Image.asset('assets/in.png')),
                      const SizedBox(width: 8),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Arman Khalid',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                height: .8,
                                wordSpacing: 0),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'You have a new connection request.',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                height: .8,
                                wordSpacing: 0),
                          ),
                        ],
                      ),
                    ],
                  ))
          ],
        ),
      ),
    );
  }

  updateCamera({bool? showIcon, bool? bigBox}) {
    showNotification = false;
    if (showIcon != null) {
      expand = false;
      if (!showIcon) {
        notchSize = const Size(100, 27);
        notchWidget.removeAt(0);
      } else {
        notchSize = const Size(120, 27);
        notchWidget.insert(
            0,
            lens(const Icon(
              Icons.headphones,
              size: 14,
              color: Color.fromARGB(255, 99, 232, 104),
            )));
      }
    }

    if (bigBox != null) {
      expand = !bigBox;
      if (expand) {
        notchSize = Size(iphoneSize.width * .93, iphoneSize.width * .3);
      } else {
        notchSize = const Size(100, 27);
      }
    }
    setState(() {});
  }

  lens(Widget? child) {
    return Container(
        width: notchSize.height * .6,
        height: notchSize.height * .6,
        decoration: BoxDecoration(
            color: const Color.fromARGB(96, 214, 198, 240).withOpacity(.1),
            shape: BoxShape.circle),
        alignment: Alignment.center,
        child: child);
  }
}
