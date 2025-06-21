import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tasksphere_riverpod/common/exceptions/exceptions.dart';
import 'package:tasksphere_riverpod/common/repositories/storage_repository_provider.dart';
import 'package:tasksphere_riverpod/features/auth/presentation/login_screen.dart';
import 'package:tasksphere_riverpod/features/project/domain/project_model.dart';
import 'package:tasksphere_riverpod/features/project/presentation/providers/project_provider.dart';

class CreateProjectScreen extends ConsumerStatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateProjectState();
}

class _CreateProjectState extends ConsumerState<CreateProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _projectNameController = TextEditingController();
  TextEditingController _projectDescriptionController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  Uint8List? _image;
  File? _pickedImage;
  String? adminId;

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _projectNameController.dispose();
    _projectDescriptionController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void clearForm() {
    _projectNameController.clear();
    _projectDescriptionController.clear();
    _startDateController.clear();
    _endDateController.clear();

    setState(() {
      _startDate = null;
      _endDate = null;
      _pickedImage = null;
      _image = null;
    });
  }

  Future<void> submit({
    required String adminId,
    required String name,
    required File image,
    required String description,
    required String startDate,
    required String endDate,
    required ProjectStatus status,
  }) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    if (_formKey.currentState!.validate()) {
      try {
        // Call the create project method from the provider
        await ref
            .read(projectNotifierProvider.notifier)
            .createProject(
              adminId: adminId,
              name: name,
              image: image,
              description: description,
              startDate: startDate,
              endDate: endDate,
              status: status,
            );
        // Show success message or navigate to another screen
        if (!mounted) return;
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Project created successfully')),
        );
        clearForm();
      } on ProjectException catch (e) {
        if (!mounted) return;
        scaffoldMessenger.showSnackBar(SnackBar(content: Text(e.message)));
      } catch (e) {
        if (!mounted) return;
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Failed to create project: $e')),
        );
      }
    } else {
      if (mounted) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text('Please fill in all fields'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
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
          _pickedImage = File(pickedFile.path);
        });
      }
    }

    ref.watch(flutterSecureStorageProvider).getValue(StorageKeys.userId).then((
      value,
    ) {
      if (value != null) {
        adminId = value;
      } else {
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => route.isFirst,
          );
        }
      }
    });

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
                      key: _formKey,
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
                            height: 50,
                            child: TextFormField(
                              controller: _projectNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Project name cannot be empty";
                                } else if (value.trim().isEmpty) {
                                  return "Project name cannot be empty";
                                }
                                return null;
                              },
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
                            controller: _projectDescriptionController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Description cannot be empty";
                              } else if (value.trim().isEmpty) {
                                return "Description cannot be empty";
                              }
                              return null;
                            },
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Start date cannot be empty";
                              } else if (value.trim().isEmpty) {
                                return "Start date cannot be empty";
                              }

                              return null;
                            },
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "End date cannot be empty";
                              } else if (value.trim().isEmpty) {
                                return "End date cannot be empty";
                              }

                              return null;
                            },
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

                          InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              submit(
                                adminId: adminId!,
                                name: _projectNameController.text,
                                image: _pickedImage!,
                                description: _projectDescriptionController.text,
                                startDate: _startDateController.text,
                                endDate: _endDateController.text,
                                status: ProjectStatus.upcoming,
                              );
                            },
                            child: Container(
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
