import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreateProject extends ConsumerStatefulWidget {
  const CreateProject({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateProjectState();
}

class _CreateProjectState extends ConsumerState<CreateProject> {
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    // Pick an image.

    Future<void> pickImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _image = bytes;
          print(_image);
        });
      }
    }

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      "Create Project",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 30),

                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Project Name",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 40,
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                border: OutlineInputBorder(),
                                hintText: "Name you project",
                                hintStyle: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),

                          Text(
                            "Project Description",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            maxLines: null,
                            minLines: 7,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              border: OutlineInputBorder(),
                              hintText: "Describe your project",
                              hintStyle: TextStyle(fontSize: 15),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Text(
                            "Timeline",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Divider(),
                          const SizedBox(height: 15),

                          Text(
                            "Start Date",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),

                          TextFormField(
                            controller: _startDateController,
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: _startDate ?? DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(
                                  Duration(days: 365 * 100),
                                ),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  _startDate = pickedDate;
                                  _startDateController.text = DateFormat(
                                    'dd-MM-yyyy',
                                  ).format(pickedDate);
                                });
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              border: OutlineInputBorder(),
                              hintText: "Select Date",
                              hintStyle: TextStyle(fontSize: 15),
                              suffixIcon: Icon(Icons.calendar_month),
                            ),
                          ),

                          const SizedBox(height: 15),

                          Text(
                            "End Date",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _endDateController,
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: _endDate ?? DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(
                                  Duration(days: 365 * 100),
                                ),
                              );

                              if (pickedDate != null) {
                                setState(() {
                                  _endDate = pickedDate;
                                  _endDateController.text = DateFormat(
                                    'dd-MM-yyyy',
                                  ).format(pickedDate);
                                });
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              border: OutlineInputBorder(),
                              hintText: "Select Date",
                              hintStyle: TextStyle(fontSize: 15),
                              suffixIcon: Icon(Icons.calendar_month),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Image",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),

                          InkWell(
                            onTap: () {
                              pickImage();
                            },
                            child: Container(
                              height: 120,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child:
                                  _image != null
                                      ? Image.memory(
                                        _image!,
                                        fit: BoxFit.contain,
                                      )
                                      : Icon(
                                        Icons.cloud_upload_outlined,
                                        size: 70,
                                      ),
                            ),
                          ),
                          const SizedBox(height: 25),

                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.indigoAccent,
                            ),
                            child: Text(
                              "Save Project",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 25),
                        ],
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
