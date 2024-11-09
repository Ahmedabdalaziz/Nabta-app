import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/functions.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/Dark_Custom_text_field.dart';
import 'package:graduation_project/core/widgets/bottom_sheet.dart';

class CustomSelectionTextField extends StatefulWidget {
  final Color textColor;
  final String? labelText;
  final List<String> items;
  final List<String> svgIconRight;
  final List<String> svgIconLeft;
  final TextEditingController? controller;
  final double borderCircular;
  final double height;
  final bool showError;
  final bool showSearch;

  const CustomSelectionTextField({
    Key? key,
    required this.textColor,
    this.labelText,
    required this.items,
    required this.svgIconRight,
    this.controller,
    this.borderCircular = 10,
    required this.height,
    required this.svgIconLeft,
    this.showError = false,
    this.showSearch = false,
  }) : super(key: key);

  @override
  _CustomSelectionTextFieldState createState() =>
      _CustomSelectionTextFieldState();
}

class _CustomSelectionTextFieldState extends State<CustomSelectionTextField> {
  String _selectedItem = '';

  void _showSelectionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return CustomModalBottomSheet(
          height: widget.height,
          child: SelectionList(
            items: widget.items,
            svgIconRight: widget.svgIconRight,
            svgIconLeft: widget.svgIconLeft,
            onItemSelected: _setSelectedItem,
            showSearch: widget.showSearch,
          ),
        );
      },
    );
  }

  void _setSelectedItem(String item) {
    setState(() {
      _selectedItem = item;
      widget.controller?.text = item;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSelectionSheet(context),
      child: AbsorbPointer(
        child: TextFormField(
          controller: widget.controller,
          style: CairoTextStyles.bold.copyWith(
            color: ColorsManager.grey,
            fontSize: 18.0.sp,
          ),
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: widget.labelText,
            hintStyle: CairoTextStyles.regular.copyWith(
              color: ColorsManager.grey,
              fontSize: 18.0.sp,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderCircular),
              borderSide: BorderSide(width: 2.0.w),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderCircular),
              borderSide: BorderSide(
                color: widget.showError
                    ? ColorsManager.red
                    : ColorsManager.secondGreen,
                width: 2.0.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderCircular),
              borderSide: BorderSide(
                color: widget.showError
                    ? ColorsManager.red
                    : ColorsManager.mainGreen,
                width: 2.0.w,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectionList extends StatefulWidget {
  final List<String> items;
  final List<String> svgIconRight;
  final List<String> svgIconLeft;
  final ValueChanged<String> onItemSelected;
  final bool showSearch;

  const SelectionList({
    Key? key,
    required this.items,
    required this.svgIconRight,
    required this.svgIconLeft,
    required this.onItemSelected,
    this.showSearch = false,
  }) : super(key: key);

  @override
  _SelectionListState createState() => _SelectionListState();
}

class _SelectionListState extends State<SelectionList> {
  List<String> _filteredItems = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    setState(() {
      _filteredItems = filterItems(_searchController.text, widget.items);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          if (widget.showSearch)
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: SizedBox(
                height: 50.h,
                child: DarkCustomTextField(
                  fillColor: ColorsManager.white,
                  textColor: ColorsManager.secondGreen,
                  controller: _searchController,
                  icon: Icon(Icons.search),
                  borderCircular: 50.sp,
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    widget.onItemSelected(_filteredItems[index]);
                  },
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.h),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 16.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorsManager.secondGreen, width: 1.5),
                            borderRadius: BorderRadius.circular(70),
                          ),
                          child: Row(
                            children: [
                              if (widget.svgIconRight.isNotEmpty)
                                SvgPicture.asset(
                                  widget.svgIconRight[index],
                                  color: ColorsManager.secondGreen,
                                  width: 24.w,
                                  height: 24.h,
                                ),
                              Expanded(
                                child: Text(
                                  _filteredItems[index],
                                  textAlign: TextAlign.right,
                                  style: CairoTextStyles.bold.copyWith(
                                    color: ColorsManager.secondGreen,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                              if (widget.svgIconLeft.isNotEmpty)
                                SvgPicture.asset(
                                  widget.svgIconLeft[index],
                                  color: ColorsManager.secondGreen,
                                  width: 24.w,
                                  height: 24.h,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
