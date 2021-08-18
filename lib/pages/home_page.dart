import 'dart:io';

import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:flutter/material.dart';
import 'package:snapclone/core/app_constants.dart';
import 'package:snapclone/pages/bloc/home_page_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  CameraDeepArController cameraDeepArController;
  // final vp = PageController(viewportFraction: .24);
  // Effects currentEffects = Effects.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            if (state is PermissionFailed) {
              return Center(
                child: Text("Permission failed"),
              );
            }
            if (state is PermissionSuccess || state is HomePageLoaded) {
              return Stack(
                children: [
                  //Deep AR Camera
                  CameraDeepAr(
                    androidLicenceKey: Config.androidKey,
                    iosLicenceKey: Config.iosKey,
                    onImageCaptured: (path) {
                      ///save image to the gallery
                    },
                    onVideoRecorded: (video) {},
                    onCameraReady: (isReady) {
                      ///camera ready
                    },
                    cameraDeepArCallback: (camera) async {
                      cameraDeepArController = camera;
                    },
                  ),

                  ///face mask filters - image buttons
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Expanded(
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                padding: EdgeInsets.all(15),
                                child: Icon(Icons.camera_enhance),
                                color: Colors.white54.withOpacity(0.5),
                                onPressed: () {
                                  if (cameraDeepArController == null) {
                                    return;
                                  }
                                  cameraDeepArController.snapPhoto();
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(8, (page) {
                                bool active = context
                                        .watch<HomePageBloc>()
                                        .state
                                        .currentPage ==
                                    page;
                                return Platform.isIOS

                                    ///ios view
                                    ? GestureDetector(
                                        onTap: () {
                                          context.read<HomePageBloc>().add(
                                              FaceEvent(currentPage: page));
                                          cameraDeepArController
                                              .changeMask(page);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: CircleAvatar(
                                            radius: active ? 45 : 25,
                                            backgroundColor: Colors.red,
                                            backgroundImage: AssetImage(
                                                "assets/assets/ios/${page.toString()}.jpg"),
                                          ),
                                        ),
                                      )

                                    ///android view
                                    : GestureDetector(
                                        onTap: () {
                                          context.read<HomePageBloc>().add(
                                              FaceEvent(currentPage: page));
                                          cameraDeepArController
                                              .changeMask(page);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: CircleAvatar(
                                            radius: active ? 45 : 30,
                                            backgroundColor: Colors.red,
                                            backgroundImage: AssetImage(
                                                "assets/assets/android/${page.toString()}.jpg"),
                                          ),
                                        ),
                                      );
                              }),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: Text("Something went wrong!"),
              );
            }
          },
        ));
  }
}
