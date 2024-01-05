import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class CreateFeedsPage extends StatefulWidget {
  @override
  _CreateFeedPageState createState() => _CreateFeedPageState();
}

class _CreateFeedPageState extends State<CreateFeedsPage> {
  final TextEditingController _textController = TextEditingController();
  final CarouselController _carouselController = CarouselController();
  final FocusNode _focusNode = FocusNode();
  List<File> _images = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.dependOnInheritedWidgetOfExactType();
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _images = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  Future<void> _takePicture() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      // Process the captured image
      // _image = File(pickedFile.path);
      setState(() {
        _images = [File(image.path)];
      });
    }
  }

  void _showPermissionAlert(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permission Denied'),
          content: Text('Settings > Today Workout > 카메라 / 사진 접근 권한을 설정 해 주세요.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }

  void _showPhotoOptions(BuildContext context) async {
    var cameraStatus = await Permission.camera.status;
    var photosStatus = await Permission.photos.status;

    // Request permissions if not already granted
    if (!cameraStatus.isGranted) {
      cameraStatus = await Permission.camera.request();
    }
    if (!photosStatus.isGranted) {
      photosStatus = await Permission.photos.request();
    }
    if (cameraStatus.isGranted && photosStatus.isGranted) {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: const Text('Choose Options'),
          message: const Text('사진 첨부에 사용 할 옵션을 선택 해 주세요.'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text('📷 Take Photo'),
              onPressed: () {
                Navigator.pop(context);
                _takePicture(); // Your function to take a photo
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('🖼️ Choose Photo'),
              onPressed: () {
                Navigator.pop(context);
                _pickImages(); // Your function to choose from album
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } else {
      _showPermissionAlert(context);
    }
  }

  void postFeed() {
    // Here, you would normally handle the logic for posting the feed.
    // This could involve sending data to a backend server, for instance.
    print('Feed Posted: ${_textController.text}');
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Stack(
      children: <Widget>[
        // Top bar
        _TopBar(
          choosePhoto: () => _showPhotoOptions(context),
        ),
        _ContentsArea(
          carouselController: _carouselController,
          keyboardHeight: keyboardHeight,
          textController: _textController,
          focusNode: _focusNode,
          images: _images,
        ),
        // Bottom bar
        // _BottomBar(
        //   keyboardHeight: keyboardHeight,
        //   pickImages: _pickImages,
        // ),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  // final VoidCallback pickImages;
  // final VoidCallback takePhotoImages;
  final VoidCallback choosePhoto;

  const _TopBar({super.key, required this.choosePhoto});

  // const _TopBar(
  //     {super.key, required this.pickImages, required this.takePhotoImages});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                // Icons.cancel,
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => {
                Navigator.pop(context),
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // TextButton(
                //   onPressed: takePhotoImages,
                //   child: Row(
                //     children: [
                //       Icon(
                //         Icons.camera_alt,
                //         color: Colors.black,
                //       ),
                //       SizedBox(width: 5),
                //       Text(
                //         'Take Photo',
                //         style: TextStyle(
                //             color: Colors.black,
                //             fontWeight: FontWeight.w700,
                //             fontSize: 16),
                //       ),
                //     ],
                //   ),
                // ),
                // TextButton(
                //   onPressed: pickImages,
                //   child: Row(
                //     children: [
                //       Icon(
                //         Icons.photo,
                //         color: Colors.black,
                //       ),
                //       SizedBox(width: 5),
                //       Text(
                //         'Album',
                //         style: TextStyle(
                //             color: Colors.black,
                //             fontWeight: FontWeight.w700,
                //             fontSize: 16),
                //       ),
                //     ],
                //   ),
                // ),
                TextButton(
                  onPressed: choosePhoto,
                  child: Row(
                    children: [
                      Icon(
                        Icons.photo,
                        color: Colors.black,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Photo',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Submit logic
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                ), // Add more buttons as needed
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ContentsArea extends StatefulWidget {
  final double keyboardHeight;
  final TextEditingController textController;
  final FocusNode focusNode;
  final List<File> images;
  final CarouselController carouselController;

  const _ContentsArea({
    super.key,
    required this.keyboardHeight,
    required this.textController,
    required this.focusNode,
    required this.images,
    required this.carouselController,
  });

  @override
  State<_ContentsArea> createState() => _ContentsAreaState();
}

class _ContentsAreaState extends State<_ContentsArea> {
  void _deleteImage(int index) {
    setState(() {
      widget.images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    var autoPlayBoolean = widget.images.length == 1 ? false : true;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 60, 20, 60 + widget.keyboardHeight),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          widget.images.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      CarouselSlider(
                        carouselController: widget.carouselController,
                        options: CarouselOptions(
                          height: 200.0,
                          enlargeCenterPage: true,
                          autoPlay: autoPlayBoolean,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: autoPlayBoolean,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                        ),
                        items: widget.images.asMap().entries.map((entry) {
                          int index = entry.key;
                          File file = entry.value;
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Image.file(
                                file,
                                fit: BoxFit.cover,
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteImage(index),
                              ),
                            ],
                          );
                        }).toList(),
                        // items: [],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "첨부된 ${widget.images.length} 장의 사진",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : Container(),
          SizedBox(height: 20),
          Container(
            height: 100.0,
            child: SingleChildScrollView(
              child: TextField(
                controller: widget.textController,
                focusNode: widget.focusNode,
                decoration: const InputDecoration(
                  hintText: "What's on your mind?",
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final double keyboardHeight;
  final VoidCallback pickImages;

  const _BottomBar(
      {super.key, required this.keyboardHeight, required this.pickImages});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: keyboardHeight,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo),
              onPressed: pickImages,
            ),
            // Add more buttons as needed
          ],
        ),
      ),
    );
  }
}
