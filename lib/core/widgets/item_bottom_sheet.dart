import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/dark_Custom_text_field.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CustomSelectionTextField extends StatefulWidget {
  final Color textColor;
  final String? labelText;
  final List<String> items;
  final List<String> svgIcons;
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
    required this.svgIcons,
    this.controller,
    this.borderCircular = 10,
    required this.height,
    this.showError = false,
    this.showSearch = false,
  }) : super(key: key);

  @override
  _CustomSelectionTextFieldState createState() =>
      _CustomSelectionTextFieldState();
}

class _CustomSelectionTextFieldState extends State<CustomSelectionTextField> {
  void _showSelectionSheet(BuildContext context) {
    showMaterialModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50.sp),
        ),
      ),
      backgroundColor: ColorsManager.white,
      animationCurve: Curves.easeInOut,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: widget.height,
          child: SelectionList(
            items: widget.items,
            svgIcons: widget.svgIcons,
            onItemSelected: (selectedItem) {
              _setSelectedItem(selectedItem);
              Navigator.pop(context);
            },
            showSearch: widget.showSearch,
          ),
        );
      },
    );
  }

  void _setSelectedItem(String item) {
    setState(() {
      widget.controller?.text = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSelectionSheet(context),
      child: AbsorbPointer(
        child: TextFormField(
          controller: widget.controller,
          style: CairoTextStyles.bold.copyWith(
            color: widget.textColor,
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
  final List<String> svgIcons;
  final ValueChanged<String> onItemSelected;
  final bool showSearch;

  const SelectionList({
    Key? key,
    required this.items,
    required this.svgIcons,
    required this.onItemSelected,
    this.showSearch = false,
  }) : super(key: key);

  @override
  _SelectionListState createState() => _SelectionListState();
}

class _SelectionListState extends State<SelectionList> {
  late List<String> _filteredItems;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    setState(() {
      _filteredItems = widget.items
          .where((item) =>
              item.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
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
      padding: EdgeInsets.all(
        16.w,
      ),
      child: Column(
        children: [
          verticalSpace(4.h),
          Container(
            width: 50.w,
            height: 8.sp,
            decoration: BoxDecoration(
              color: ColorsManager.secondGreen,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          verticalSpace(18.h),
          if (widget.showSearch)
            SizedBox(
              height: 50.h,
              child: DarkCustomTextField(
                fillColor: ColorsManager.white,
                textColor: ColorsManager.secondGreen,
                controller: _searchController,
                icon: const Icon(
                  Icons.search_outlined,
                  color: ColorsManager.secondGreen,
                  size: 33,
                ),
                borderCircular: 50.sp,
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
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 12.h),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorsManager.secondGreen,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(70),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.svgIcons.isNotEmpty)
                          SvgPicture.asset(
                            widget.svgIcons[index],
                            color: ColorsManager.secondGreen,
                            width: 24.w,
                            height: 24.h,
                          ),
                        Text(
                          _filteredItems[index],
                          style: CairoTextStyles.bold.copyWith(
                            color: ColorsManager.secondGreen,
                            fontSize: 18.sp,
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
