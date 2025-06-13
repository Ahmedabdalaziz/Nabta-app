////////////////////////////الصور////////////////////////
const String firstLogoSVG = "assets/SVGs/splash_screen/1splash.svg";
const String secondLogoSVG = "assets/SVGs/splash_screen/2splash.svg";
const String loginSVG = "assets/SVGs/login_screen/login.svg";
const String warningBoxSvg = "assets/SVGs/icons/warningLogo.svg";
const String alertSvg = "assets/SVGs/icons/alert.svg";
const String placeHolderImage = "assets/SVGs/icons/user_picture.svg";
const String OTP = "assets/SVGs/sign_in/OTP.svg";
const String arrowBack = "assets/SVGs/icons/arrow-back-outline.svg";
const String cowIcon = "assets/SVGs/animals/cow.svg";
const String chickenIcon = "assets/SVGs/animals/chicken.svg";
const String donkeyIcon = "assets/SVGs/animals/donkey.svg";
const String gamosIcon = "assets/SVGs/animals/gamos.svg";
const String goatIcon = "assets/SVGs/animals/goat.svg";
const String horseIcon = "assets/SVGs/animals/horse.svg";
const String rabbitIcon = "assets/SVGs/animals/rabbit.svg";
const String sheepIcon = "assets/SVGs/animals/sheep.svg";

////////////////////////////المحافظات////////////////////////

List<String> citiesIcons =
    cities.map((gov) => 'assets/SVGs/icons/build.svg').toList();

List<String> cities = [
  "القاهرة",
  "الجيزة",
  "الاسكندرية",
  "أسوان",
  "الأقصر",
  "بورسعيد",
  "السويس",
  "دمياط",
  "كفر الشيخ",
  "الغربية",
  "المنوفية",
  "الدقهلية",
  "الشرقية",
  "البحيرة",
  "الفيوم",
  "بني سويف",
  "المنيا",
  "اسيوط",
  "سوهاج",
  "قنا",
  "البحر الأحمر",
  "شمال سيناء",
  "جنوب سيناء",
  "مرسى مطروح",
  "الوادي الجديد",
];

////////////////////////////ابلاغ بيطري////////////////////////

final Map<String, String> animals = {
  "الماعز": goatIcon,
  "الاغنام": sheepIcon,
  "الجاموس": gamosIcon,
  "الابقار": cowIcon,
  "الحمير": donkeyIcon,
  "الاحصنة": horseIcon,
  "الدواجن": chickenIcon,
  "الارانب": rabbitIcon,
};

final Map<String, List<String>> diseaseCategories = {
  "الأمراض الناتجة عن لدغات الحشرات": [
    "الحمى النزفية",
    "الدودة القلبية",
    "الجرب",
    "غير متأكد"
  ],
  "الأمراض البكتيرية": [
    "التسمم الغذائي",
    "الإصابات والجروح",
    "الأمراض الجلدية",
    "غير متأكد"
  ],
  "الأمراض الفيروسية": [
    "الحمى القلاعية",
    "الجدري",
    "التهاب الفم الحويصلي",
    "غير متأكد"
  ],
  "الإصابات والجروح": [
    "الجروح المفتوحة",
    "الخراجات",
    "تورم الأنسجة",
    "غير متأكد"
  ],
  "الأمراض الجلدية": [
    "الطفح الجلدي",
    "القوباء الحلقية",
    "التهابات الجلد",
    "غير متأكد"
  ],
  "الأمراض الطفيلية": [
    "الدودة الكبدية",
    "الديدان المعوية",
    "القراد",
    "غير متأكد"
  ],
  "الأمراض التنفسية": ["التهاب الرئة", "نقص المناعة التنفسية"],
  "التورمات والأورام": ["التورم الناتج عن العدوى", "تورم المفاصل", "غير متأكد"],
};

final List<String> questions = [
  "الحيوان بياكل طبيعي؟",
  "الحيوان بيشرب مياه كفاية؟",
  "الحيوان بيتحرك زي ما تعودت عليه؟",
  "بيتنفس طبيعي؟",
  "الإخراج منتظم؟",
  "فيه تساقط شعر أو بقع على الجلد؟",
  "الحيوان كان تعرض لنفس الأعراض دي قبل كده؟",
  "الحيوان خد تطعيماته كاملة؟",
  "فيه أي تغيير في مكان الحيوان، أو أكله مؤخرًا؟",
];

////////////////////////////الطقس////////////////////////

Map<String, String> weatherCondition = {
  'Clear': 'صافي',
  'Partially cloudy': 'غائم جزئيا',
  'Overcast': 'غائم كليا',
  'Fog': 'ضباب',
  'Mist': 'شبورة مائية',
  'Dust': 'غبار',
  'Sand': 'رمال متحركه',
  'Sandstorm': 'عاصفة رملية',
  'Duststorm': 'عاصفة ترابية',
  'Rain': 'امطار',
  'Heavy Rain': 'امطار غزيرة',
  'Light Rain': 'امطار خفيفة',
  'Drizzle': 'رذاذ',
  'Thunderstorm': 'عاصفة رعدية',
  'Windy': 'رياح قوية',
  'Cold': 'بارد',
  'Hot': 'ساخن',
  'Freezing': 'تجمد',
};


// دالة لتحديد الصورة بناءً على حالة الطقس
String getImagePath(String condition) {
  switch (condition) {
    case 'clear':
      return 'assets/SVGs/home/Group 129.png';
    case 'Cold':
      return 'assets/SVGs/home/weather2.png';
    case 'cloudy':
    case 'Partially cloudy':
    case 'Fog':
    case 'Mist':
    case 'overcast':
      return 'assets/SVGs/home/1.5Group 127.png';
    case 'rain':
    case 'Heavy Rain':
    case 'Light Rain':
    case 'drizzle':
      return 'assets/SVGs/home/weather3.png';
    case 'Sandstorm':
    case 'Duststorm':
    case 'Thunderstorm':
    case 'Windy':
      return 'assets/SVGs/home/Group 130.png';
    default:
      return 'assets/SVGs/home/Group 129.png';
  }
}



Map<String, double> rateReq = {
  'عالي': 80,
  'متوسط': 50,
  'منخفض': 30,
};
