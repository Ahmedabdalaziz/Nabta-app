import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/helper/strings.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/features/report/logic/report_cubit.dart';
import 'package:graduation_project/features/report/ui/screens/report_screen.dart';
import 'package:graduation_project/features/report/ui/widgets/animal_selection_widget.dart';
import 'package:graduation_project/features/report/ui/widgets/details.dart';
import 'package:graduation_project/features/report/ui/widgets/disease_selection_widget.dart';
import 'package:graduation_project/features/report/ui/widgets/notes_widget.dart';
import 'package:graduation_project/features/report/ui/widgets/upload_image.dart';

import '../../../../core/widgets/app_text_button.dart';

class FirstReportScreen extends StatefulWidget {
  const FirstReportScreen({super.key});

  @override
  State<FirstReportScreen> createState() => _FirstReportScreenState();
}

class _FirstReportScreenState extends State<FirstReportScreen> {
  String? selectedAnimal;
  Map<String, bool> selectedMain = {};
  Map<String, Map<String, bool>> selectedSub = {};
  Map<String, String?> answers = {};
  List<String> uploadedImages = [];
  String notes = "";
  bool hasImages = false;

  @override
  void initState() {
    super.initState();
    for (var category in diseaseCategories.keys) {
      selectedMain[category] = false;
      selectedSub[category] = {};
      for (var subCategory in diseaseCategories[category]!) {
        selectedSub[category]![subCategory] = false;
      }
    }
  }

  void updateUploadedImages(List<String> images) {
    setState(() {
      uploadedImages = images;
      hasImages = images.isNotEmpty;
      print("Uploaded Images: $uploadedImages");
    });
  }

  void updateSelectedAnimal(String? animal) {
    setState(() {
      selectedAnimal = animal;
      print("Selected Animal: $selectedAnimal");
    });
    context.read<ReportCubit>().updateAnimalType(animal);
  }

  void updateMainCategory(String category) {
    setState(() {
      selectedMain[category] = !(selectedMain[category] ?? false);
      print("Selected Main Categories: $selectedMain");
    });
    context.read<ReportCubit>().updateDiseases(selectedMain, selectedSub);
  }

  void updateSubCategory(String category, String subCategory) {
    setState(() {
      selectedSub[category]![subCategory] =
          !(selectedSub[category]![subCategory] ?? false);
      print("Selected Sub Categories: $selectedSub");
    });
    context.read<ReportCubit>().updateDiseases(selectedMain, selectedSub);
  }

  void updateAnswer(String question, String? answer) {
    setState(() {
      answers[question] = answer;
      print("Answers: $answers");
    });
    context.read<ReportCubit>().updateDiagnosticQuestions(answers);
  }

  void updateNotes(String newNotes) {
    setState(() {
      notes = newNotes;
      print("Notes: $notes");
    });
    context.read<ReportCubit>().updateNotes(notes);
  }

  void removeImage(int index) {
    setState(() {
      uploadedImages.removeAt(index);
      hasImages = uploadedImages.isNotEmpty;
    });
    context.read<ReportCubit>().updateImages(uploadedImages);
  }

  @override
  Widget build(BuildContext context) {
    return ReportScreen(
      details: true,
      customWidget: Expanded(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              AnimalSelectionWidget(
                selectedAnimal: selectedAnimal,
                onAnimalSelected: updateSelectedAnimal,
              ),
              DiseaseSelectionWidget(
                selectedMain: selectedMain,
                selectedSub: selectedSub,
                onMainCategoryToggle: updateMainCategory,
                onSubCategoryToggle: updateSubCategory,
              ),
              DiagnosticQuestions(
                answers: answers,
                onAnswerSelected: updateAnswer,
              ),
              UploadImageSection(
                uploadedImages: uploadedImages,
                onImagesUpdated: updateUploadedImages,
              ),
              NotesWidget(
                notes: notes,
                onNotesChanged: updateNotes,
              ),
              verticalSpace(32.h),
              SizedBox(
                width: 400.w,
                height: 65.h,
                child: DarkCustomTextButton(
                  bottomColor: hasImages
                      ? ColorsManager.mainGreen
                      : ColorsManager.greenWhite,
                  textColor: ColorsManager.white,
                  text: "التالي",
                  onPressed: hasImages
                      ? () {
                          context.pushNamed(Routing.secondReportScreen);
                        }
                      : null,
                  textStyle:
                      CairoTextStyles.extraBold.copyWith(fontSize: 20.sp),
                ),
              ),
              verticalSpace(80.h),
            ],
          ),
        ),
      ),
    );
  }
}
