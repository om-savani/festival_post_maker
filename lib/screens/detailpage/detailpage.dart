import 'package:carousel_slider/carousel_slider.dart';
import 'package:festival_post_maker/utils/my_extention.dart';
import 'package:flutter/material.dart';
import 'package:festival_post_maker/models/festival_models.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  double textSize = 16.0;
  Color textcolor = Colors.white;
  String selectedQuote = "";
  String selectedImage = "";
  Alignment textAlignment = Alignment.center;
  Offset textPosition = const Offset(100, 100);
  TextEditingController textController = TextEditingController();
  List<String> uniqueQuotes = [];
  List<String> bgImages = [];
  bool isedit = false;
  int index = 0;
  void setIndex(int i) {
    index = i;
    setState(() {});
  }

  void _onMenuSelected(String value) {
    switch (value) {
      case 'Edit':
        isedit = true;
        setState(() {});
        break;
      case 'Reset':
        setState(() {
          textSize = 16;
          selectedImage = "";
          selectedQuote = "";
          textAlignment = Alignment.center;
          textPosition = const Offset(100, 100);
          textController.clear();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    FestivalModels data =
        ModalRoute.of(context)!.settings.arguments as FestivalModels;

    uniqueQuotes = data.quotes.toSet().toList();
    bgImages = data.images.toList();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text(data.name),
        actions: [
          PopupMenuButton<String>(
            onSelected: _onMenuSelected,
            itemBuilder: (BuildContext context) {
              return {'Edit', 'Reset'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "lib/assets/images/bg1.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: isedit == false,
                child: Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: size.height * 0.4,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 1,
                      ),
                      items: bgImages.map((imageUrl) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26),
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: NetworkImage(imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    16.h,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Aboout Festival:",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                        10.h,
                        Text(
                          "Festival: ${data.name}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Text(
                          "Description: ${data.description}",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Text(
                          "Date: ${data.date}",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Visibility(
                visible: isedit,
                child: Container(
                  height: 300,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Image.network(
                        selectedImage.isEmpty ? data.images[0] : selectedImage,
                        fit: BoxFit.cover,
                        height: 300,
                        width: double.infinity,
                      ),
                      if (selectedQuote.isNotEmpty)
                        Positioned(
                          left: textPosition.dx,
                          top: textPosition.dy,
                          child: GestureDetector(
                            onTap: () => textEditor(),
                            onPanUpdate: (details) {
                              setState(() {
                                textPosition += details.delta;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              color: Colors.transparent,
                              child: Text(
                                selectedQuote,
                                style: TextStyle(
                                  fontSize: textSize,
                                  color: textcolor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              8.h,
              Visibility(
                visible: isedit,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setIndex(0);
                        },
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                width: index == 0 ? 2.5 : 0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          child: const Text(
                            "Text",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setIndex(1);
                        },
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                width: index == 1 ? 5 : 0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          child: const Text(
                            "Theme",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isedit,
                child: IndexedStack(
                  index: index,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(children: [
                        16.h,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PopupMenuButton<String>(
                                tooltip: "Select a Quote",
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Text(
                                    selectedQuote.isEmpty
                                        ? "Select a Quote"
                                        : selectedQuote,
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                ),
                                onSelected: (newValue) {
                                  setState(() {
                                    selectedQuote = newValue;
                                  });
                                },
                                itemBuilder: (BuildContext context) {
                                  return uniqueQuotes
                                      .map(
                                        (quote) => PopupMenuItem<String>(
                                          value: quote,
                                          child: ListTile(
                                            title: Text(quote),
                                          ),
                                        ),
                                      )
                                      .toList();
                                },
                              ),
                            ],
                          ),
                        ),
                        8.h,
                        TextField(
                          controller: textController,
                          decoration: const InputDecoration(
                            hintText: "Add your own quote",
                          ),
                          onSubmitted: (value) {
                            setState(() {
                              if (!uniqueQuotes.contains(value)) {
                                uniqueQuotes.add(value);
                              }
                              selectedQuote = value; // Debug print
                            });
                          },
                        ),
                        16.h,
                        Row(
                          children: [
                            const Text("Text Size: "),
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (textSize > 12) {
                                    textSize--;
                                  }
                                });
                              },
                            ),
                            Text(textSize.toString()),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  textSize++;
                                });
                              },
                            ),
                          ],
                        ),
                        8.h,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Text Alignment: "),
                            IconButton(
                              icon: const Icon(Icons.format_align_left),
                              onPressed: () {
                                setState(() {
                                  textAlignment = Alignment.centerLeft;
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.format_align_center),
                              onPressed: () {
                                setState(() {
                                  textAlignment = Alignment.center;
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.format_align_right),
                              onPressed: () {
                                setState(() {
                                  textAlignment = Alignment.centerRight;
                                });
                              },
                            ),
                          ],
                        ),
                        16.h,
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                textPosition = const Offset(100, 100);
                              });
                            },
                            child: const Text("Reset Text Position"),
                          ),
                        ),
                      ]),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: bgImages
                                  .map(
                                    (images) => GestureDetector(
                                      onTap: () {
                                        selectedImage = images;
                                        setState(() {});
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 8.0),
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          image: NetworkImage(images),
                                          fit: BoxFit.cover,
                                        )),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          16.h,
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title:
                                        const Text("Pick a Background Color"),
                                    content: BlockPicker(
                                      pickerColor: textcolor,
                                      onColorChanged: (Color value) {
                                        setState(() {
                                          textcolor = value;
                                        });
                                      },
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text("Pick Text Color"),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: isedit
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton.extended(
                  heroTag: "btn1",
                  icon: const Icon(Icons.download),
                  label: const Text('Download'),
                  onPressed: () {
                    // Add your save logic here
                  },
                ),
                const SizedBox(width: 10),
                FloatingActionButton.extended(
                  heroTag: "btn2",
                  icon: const Icon(Icons.share),
                  label: const Text('Share'),
                  onPressed: () {
                    // Add your share logic here
                  },
                ),
              ],
            )
          : null,
    );
  }

  void textEditor() {
    textController.text = selectedQuote;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit or Remove Text"),
          content: TextField(
            controller: textController,
            maxLines: 3,
            decoration: const InputDecoration(hintText: "Edit your quote"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  // Update the quote only if it's unique
                  if (!uniqueQuotes.contains(textController.text)) {
                    uniqueQuotes.add(textController.text);
                  }
                  selectedQuote = textController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  selectedQuote = "";
                });
                Navigator.of(context).pop();
              },
              child: const Text("Remove"),
            ),
          ],
        );
      },
    );
  }
}
