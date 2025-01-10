import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  // الانتقال إلى شاشة جديدة مع إمكانية الرجوع
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  // الانتقال إلى شاشة جديدة مع استبدال الشاشة الحالية
  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  // الانتقال إلى شاشة جديدة وإزالة جميع الشاشات السابقة من الـ stack
  Future<dynamic> pushNamedAndRemoveUntil(
      String routeName, {
        Object? arguments,
        bool Function(Route<dynamic>)? predicate,
      }) {
    return Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      predicate ?? (route) => false, // إزالة جميع الشاشات ما لم يتم تحديد شرط
      arguments: arguments,
    );
  }

  // الانتقال إلى شاشة جديدة باستخدام Route مباشرة
  Future<dynamic> push(Route<dynamic> route) {
    return Navigator.of(this).push(route);
  }

  // الانتقال إلى شاشة جديدة باستخدام Route مباشرة مع استبدال الشاشة الحالية
  Future<dynamic> pushReplacement(Route<dynamic> route) {
    return Navigator.of(this).pushReplacement(route);
  }

  // الانتقال إلى شاشة جديدة باستخدام Route مباشرة وإزالة جميع الشاشات السابقة
  Future<dynamic> pushAndRemoveUntil(
      Route<dynamic> route, {
        bool Function(Route<dynamic>)? predicate,
      }) {
    return Navigator.of(this).pushAndRemoveUntil(
      route,
      predicate ?? (route) => false, // إزالة جميع الشاشات ما لم يتم تحديد شرط
    );
  }

  // الرجوع إلى الشاشة السابقة
  void pop([dynamic result]) {
    Navigator.of(this).pop(result);
  }

  // الرجوع إلى الشاشة السابقة حتى يتم استيفاء شرط معين
  void popUntil(bool Function(Route<dynamic>) predicate) {
    Navigator.of(this).popUntil(predicate);
  }

  // الانتقال إلى شاشة جديدة مع إمكانية الحصول على نتيجة عند الرجوع
  Future<dynamic> pushNamedForResult(String routeName, {Object? arguments}) async {
    return await Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  // الانتقال إلى شاشة جديدة باستخدام Route مباشرة مع إمكانية الحصول على نتيجة عند الرجوع
  Future<dynamic> pushForResult(Route<dynamic> route) async {
    return await Navigator.of(this).push(route);
  }
}