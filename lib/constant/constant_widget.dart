import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kwstyleb12 = TextStyle(
  fontSize: 12,
  color: Colors.black,
);

const kwstyleb14 = TextStyle(
  fontSize: 14,
  color: Colors.black,
);

const kwstyleb15 = TextStyle(
  fontSize: 15,
  color: Colors.black,
);

const kwstyleb16 = TextStyle(
  fontSize: 16,
  color: Colors.black,
);

const kwstyleb18 = TextStyle(
  fontSize: 18,
  color: Colors.black,
);

const kwstyleb20 = TextStyle(
  fontSize: 20,
  color: Colors.black,
);

const kwstyleHeaderb30 = TextStyle(
  fontSize: 30,
  color: Colors.black,
);

const kwstyleHeaderb30Bold = TextStyle(
  fontSize: 30,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

const kwstyleHeader35 = TextStyle(
  fontSize: 35,
  color: Colors.black,
);

const kwstylew12 = TextStyle(
  fontSize: 12,
  color: Colors.white,
);

const kwstylew14 = TextStyle(
  fontSize: 14,
  color: Colors.white,
);

const kwstylew15 = TextStyle(
  fontSize: 15,
  color: Colors.white,
);

const kwstylew16 = TextStyle(
  fontSize: 16,
  color: Colors.white,
);

const kwstylew18 = TextStyle(
  fontSize: 18,
  color: Colors.white,
);

const kwstylew20 = TextStyle(
  fontSize: 20,
  color: Colors.white,
);

const kwstyleHeaderw35 = TextStyle(
  fontSize: 35,
  color: Colors.white,
);

const kwstyleHint16 = TextStyle(
  fontSize: 16,
  color: Color(0xFF9097A4),
);
const kwstyleHint15 = TextStyle(
  fontSize: 15,
  color: kcHintTextSearch,
);

const kwstyleBtn15 = TextStyle(
  fontSize: 15,
  color: kcWhite,
  fontWeight: FontWeight.w500,
);
const kwstyleBtn15b = TextStyle(
  fontSize: 15,
  color: kcWhite,
  fontWeight: FontWeight.bold,
);
const kwstyleBtn20 = TextStyle(
  fontSize: 20,
  color: kcWhite,
  fontWeight: FontWeight.bold,
);
const kwstyleBtn20b = TextStyle(
  fontSize: 20,
  color: kcWhite,
  fontWeight: FontWeight.bold,
);

const kwDivider = Divider(
  color: kcDivider,
  endIndent: 0,
  height: 0,
  indent: 0,
  thickness: 1,
);

const kfregular = FontWeight.w400;
const kfmedium = FontWeight.w500;
const kfsemibold = FontWeight.w600;
const kfbold = FontWeight.bold;
const kfextrabold = FontWeight.w800;
const kfblack = FontWeight.w900;

const kwInset0 = EdgeInsets.zero;

TextStyle kwtextStyleRD(
    {double fs = 12,
    Color c = Colors.black,
    double? h,
    FontWeight? fw,
    String ff = 'SF Pro Text'}) {
  return TextStyle(
    fontFamily: ff,
    fontSize: fs.sp,
    color: c,
    height: h,
    fontWeight: fw,
  );
}

TextStyle kwtextStyleD(
    {double fs = 12, Color c = Colors.black, double? h, FontWeight? fw}) {
  return TextStyle(
    fontSize: fs,
    color: c,
    height: h,
    fontWeight: fw,
  );
}

SizedBox gapwr({double w = 20}) {
  return SizedBox(width: w.w);
}

SizedBox gaphr({double h = 20}) {
  return SizedBox(height: h.h);
}

SizedBox gapw({double w = 20}) {
  return SizedBox(width: w);
}

Future kwShowSnackbar(BuildContext context, String message,
    {int seconds = 4}) async {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: Duration(seconds: seconds),
  ));
}

SizedBox gaph({double h = 20}) {
  return SizedBox(height: h);
}

//Text

Text textBtn15(
  String title, {
  TextStyle style = kwstyleBtn15,
}) {
  return Text(
    title,
    style: style,
  );
}

Divider divider({Color c = kcDivider, double t = 1}) {
  return Divider(
    color: c,
    thickness: t,
    endIndent: 0,
    height: 0,
    indent: 0,
  );
}

EdgeInsetsGeometry padSymR({double h = 20, double v = 0}) {
  return EdgeInsets.symmetric(horizontal: h.w, vertical: v.h);
}

EdgeInsetsGeometry padSym({h = 20, v = 0}) {
  return EdgeInsets.symmetric(horizontal: h, vertical: v);
}

EdgeInsetsGeometry padOnlyR({
  double l = 0,
  double t = 0,
  double r = 0,
  double b = 0,
}) {
  return EdgeInsets.only(left: l.w, top: t.h, right: r.w, bottom: b.h);
}

EdgeInsetsGeometry padOnly({
  double l = 0,
  double t = 0,
  double r = 0,
  double b = 0,
}) {
  return EdgeInsets.only(left: l, top: t, right: r, bottom: b);
}

BorderRadius borderRadiuscR({double r = 10}) {
  return BorderRadius.circular(r.r);
}

RoundedRectangleBorder cornerR({double r = 10}) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(r.r),
  );
}

RoundedRectangleBorder corner({double r = 10}) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(r),
  );
}

InputDecoration inputDeco({
  String? hint,
  bool enabled = true,
  bool isPassword = false,
  bool isHidden = true,
  void Function()? onPressedTrailing,
}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.all(20),
    hintText: hint,
    hintStyle: kwtextStyleRD(
      c: enabled ? kchintTextfield : kcUnderlineBorder,
      fs: 18,
      fw: FontWeight.w600,
    ),
    suffixIcon: isPassword
        ? Material(
            color: Colors.transparent,
            child: IconButton(
              splashRadius: 20,
              onPressed: onPressedTrailing,
              icon: isHidden
                  ? const Icon(
                      Icons.visibility,
                      color: kcPrimary,
                    )
                  : const Icon(
                      Icons.visibility_off,
                      color: kcPrimary,
                    ),
            ),
          )
        : null,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: const BorderSide(
        color: kcborderGrey,
        width: 3,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: const BorderSide(
        color: kcPrimary,
        width: 3,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: const BorderSide(
        color: kcUnderlineBorder,
        width: 3,
      ),
    ),
  );
}
