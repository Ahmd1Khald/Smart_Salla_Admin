import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../Core/consts/app_strings.dart';
import '../../../../../Core/consts/app_variables.dart';
import '../../../../../Core/consts/my_validators.dart';
import '../../../../../Core/services/my_app_method.dart';
import '../../../../../Core/widgets/subtitle_text.dart';
import '../../../../../Core/widgets/title_text.dart';
import '../../../data/models/product_model.dart';

class EditOrUploadProductScreen extends StatefulWidget {
  const EditOrUploadProductScreen({
    super.key,
    this.productModel,
  });

  final ProductModel? productModel;

  @override
  State<EditOrUploadProductScreen> createState() =>
      _EditOrUploadProductScreenState();
}

class _EditOrUploadProductScreenState extends State<EditOrUploadProductScreen> {
  final _formKey = GlobalKey<FormState>();
  XFile? _pickedImage;

  late TextEditingController _titleController,
      _priceController,
      _descriptionController,
      _quantityController;
  String? _categoryValue;
  bool isEdite = false;
  @override
  void initState() {
    if (widget.productModel != null) {
      isEdite = true;
    }
    _titleController =
        TextEditingController(text: widget.productModel?.productTitle ?? '');
    _priceController =
        TextEditingController(text: widget.productModel?.productPrice ?? '');
    _descriptionController = TextEditingController(
        text: widget.productModel?.productDescription ?? '');
    _quantityController =
        TextEditingController(text: widget.productModel?.productQuantity ?? '');

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void clearForm() {
    _titleController.clear();
    _priceController.clear();
    _descriptionController.clear();
    _quantityController.clear();
    removePickedImage();
  }

  void removePickedImage() {
    setState(() {
      _pickedImage = null;
    });
  }

  Future<void> _uploadProduct() async {
    if (_categoryValue == null) {
      MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle: "Category is empty",
        fct: () {},
      );
      return;
    }
    if (_pickedImage == null) {
      MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle: "Please pick up an image",
        fct: () {},
      );
      return;
    }
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {}
  }

  Future<void> _editProduct() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_pickedImage == null && widget.productModel?.productImage != null) {
      MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle: "Please pick up an image",
        fct: () {},
      );
      return;
    }

    if (isValid) {}
  }

  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await MyAppMethods.imagePickerDialog(
      context: context,
      cameraFCT: () async {
        _pickedImage = await picker.pickImage(source: ImageSource.camera);
        setState(() {});
      },
      galleryFCT: () async {
        _pickedImage = await picker.pickImage(source: ImageSource.gallery);
        setState(() {});
      },
      removeFCT: () {
        setState(() {
          _pickedImage = null;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        bottomSheet: buildUploadProductBtmSht(context),
        appBar: AppBar(
          centerTitle: true,
          title: const TitlesTextWidget(
            label: AppStrings.uploadProductScreenTitleString,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                if (isEdite && widget.productModel?.productImage != null) ...[
                  SizedBox(
                    width: size.width * 0.4,
                    height: size.width * 0.43,
                    child: DottedBorder(
                      color: Colors.grey,
                      child: Image.network(
                        widget.productModel!.productImage,
                        height: size.width * 0.43,
                        width: size.width * 0.4,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ] else ...[
                  SizedBox(
                    width: size.width * 0.4,
                    height: size.width * 0.43,
                    child: DottedBorder(
                      color: Colors.grey,
                      child: _pickedImage == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Center(
                                  child: Icon(
                                    Icons.image_outlined,
                                    color: Colors.blue,
                                    size: 80,
                                  ),
                                ),
                                Center(
                                  child: TextButton(
                                    onPressed: () {
                                      localImagePicker();
                                    },
                                    child: const SubtitleTextWidget(
                                      label: 'Put product image',
                                      color: Colors.blue,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Image.file(
                              File(
                                _pickedImage!.path,
                              ),
                              height: size.width * 0.43,
                              width: size.width * 0.4,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ],
                if (_pickedImage != null) ...[
                  TextButton(
                    onPressed: () {
                      removePickedImage();
                    },
                    child: const SubtitleTextWidget(
                      label: 'Remove image',
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ],
                const SizedBox(
                  height: 25,
                ),
                categoryDropdownButton(),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //product title
                        TextFormField(
                          controller: _titleController,
                          key: const ValueKey('Title'),
                          maxLength: 90,
                          minLines: 1,
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          decoration: const InputDecoration(
                            hintText: 'Product Title',
                          ),
                          validator: (value) {
                            return MyValidators.uploadProdTexts(
                              value: value,
                              toBeReturnedString: "Please enter a valid title",
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            //product price
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                controller: _priceController,
                                key: const ValueKey('Price \$'),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^(\d+)?\.?\d{0,2}'),
                                  ),
                                ],
                                decoration: const InputDecoration(
                                    hintText: 'Price',
                                    prefix: SubtitleTextWidget(
                                      label: "\$ ",
                                      color: Colors.blue,
                                      fontSize: 16,
                                    )),
                                validator: (value) {
                                  return MyValidators.uploadProdTexts(
                                    value: value,
                                    toBeReturnedString: "Price is missing",
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            //product quantity
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                controller: _quantityController,
                                keyboardType: TextInputType.number,
                                key: const ValueKey('Quantity'),
                                decoration: const InputDecoration(
                                  hintText: 'Qty',
                                ),
                                validator: (value) {
                                  return MyValidators.uploadProdTexts(
                                    value: value,
                                    toBeReturnedString: "Quantity is missed",
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        //product description
                        TextFormField(
                          key: const ValueKey('Description'),
                          controller: _descriptionController,
                          minLines: 5,
                          maxLines: 8,
                          maxLength: 1000,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                            hintText: 'Product description',
                          ),
                          validator: (value) {
                            return MyValidators.uploadProdTexts(
                              value: value,
                              toBeReturnedString: "Description is missed",
                            );
                          },
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: kBottomNavigationBarHeight + 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownButton<String> categoryDropdownButton() {
    return DropdownButton<String>(
      hint: Text(widget.productModel?.productCategory ?? "Select Category"),
      value: _categoryValue,
      items: AppVariables.categoriesDropDownList,
      onChanged: (String? value) {
        setState(() {
          _categoryValue = value;
        });
      },
    );
  }

  SizedBox buildUploadProductBtmSht(BuildContext context) {
    return SizedBox(
      height: kBottomNavigationBarHeight + 10,
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(12),
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
              ),
              icon: const Icon(Icons.clear),
              label: const Text(
                "Clear",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                removePickedImage();
              },
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(12),
                // backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
              ),
              icon: const Icon(Icons.upload),
              label: Text(
                isEdite ? "Edit Product" : "Upload Product",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                isEdite ? _editProduct() : _uploadProduct();
              },
            ),
          ],
        ),
      ),
    );
  }
}
