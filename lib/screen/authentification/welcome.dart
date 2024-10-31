import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isImageLoaded = false;
  late final AssetImage _image;
  double _opacity = 1.0;
  bool _isNavigating = false;
  late final ImageStreamListener _listener;

  @override
  void initState() {
    super.initState();
    _image = AssetImage('assets/Images/w1.png');
    _listener = ImageStreamListener((ImageInfo info, bool synchronousCall) {
      if (mounted) {
        setState(() {
          _isImageLoaded = true;
        });
      }
    });
    _loadImage();
  }

  Future<void> _loadImage() async {
    final imageStream = _image.resolve(const ImageConfiguration());
    imageStream.addListener(_listener);
  }

  @override
  void dispose() {
    final imageStream = _image.resolve(const ImageConfiguration());
    imageStream.removeListener(_listener); // Supprimer le listener
    super.dispose();
  }

  void _navigateWithFadeOut() async {
    if (_isNavigating) return;
    setState(() {
      _isNavigating = true;
      _opacity = 0.0;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0CDE92),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: GestureDetector(
          onVerticalDragEnd: (DragEndDetails details) {
            if (details.primaryVelocity! < 0 && !_isNavigating) {
              _navigateWithFadeOut();
            }
          },
          child: AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(milliseconds: 500),
            child: Stack(
              children: [
                if (_isImageLoaded)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50),
                          const Center(
                            child: Text(
                              "Manage\nYour Power",
                              style: TextStyle(
                                fontSize: 55,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Center(
                            child: Text(
                              "Come join and \nuse SPARE",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                height: 1.3,
                                letterSpacing: 1.8,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    constraints: const BoxConstraints(
                      maxHeight: 750,
                      maxWidth: 750,
                    ),
                    child: Image(image: _image, fit: BoxFit.contain),
                  ),
                ),
                if (_isImageLoaded)
                  Column(
                    children: [
                      const Spacer(),
                      Center(
                        child: Column(
                          children: [
                            const Text(
                              "Swipe to start",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                _navigateWithFadeOut();
                              },
                              child: Container(
                                height: 20,
                                width: 80,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.5),
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      maxHeight: 1,
                                      maxWidth: 1,
                                    ),
                                    child: Image.asset(
                                      'assets/Icons/swipe.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
