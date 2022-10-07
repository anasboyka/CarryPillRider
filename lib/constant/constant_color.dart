import 'package:flutter/material.dart';

const kcWhite = Colors.white;
const kcBlack = Colors.black;
const kcPrimary = Color(0xFF174D64);
const kcPrimary2 = Color(0xff3C7D9A);
const kcOrange = Color(0xFFFF7E00);
const kcLightYellow = Color(0xFFDECD88);
const kcBgHome = Color(0xFFEFEFEF);
const kcBgHome1 = Color(0xFFF4F5F8);
const kcBgHome2 = Color(0xFFEAEDF4);
const kcGreyLabel = Color(0xFF8F9BB3);
const kcGreyLabel2 = Color(0xFF7B7B7B);
const kcGreyLabel3 = Color(0xFFC8C9CE);
const kcOutlineTextField = Color(0xFFF0F0F0);
const kcSignIn = Color(0xFF454F63);
const kcFb = Color(0xFF3B5998);
const kcHintTextSearch = Color(0xFFC5CEE0);
const kcRequestPickupDescrp = Color(0xFF626262);
const kcUnderlineBorder = Color(0xFFE4E9F2);
const kcLabelColor = Color(0xFF8F9BB3);
const kcServiceBg = Color(0xFFEBF0FC);
const kcSubtitleService = Color(0xFF2E3A59);
const kcDivider = Color(0xFFF4F4F4);
const kctextTitle = Color(0xFF2E3A59);
const kctextDark = Color(0xFF222B45);
const kctextgrey = Color(0xFF757C8B);
const kcgreyaddress = Color(0xFF757678);
const kctextpurplepink = Color(0xFFC430A2);
const kccontainerPink = Color(0xFFFFE5FF);
const kcsubtitleListTile1 = Color(0xFF77838F);
const kcsubtitleListTile2 = Color(0xFF999999);
const kcborderGrey = Color(0xFFBABABA);
const kchintTextfield = Color(0xFF9E9E9E);
const kcgrey = Color(0xFF707070);
const kcdisabledBtn = Color(0xFFE0E0E0);
const kcstatusGreen = Color(0xFF50957A);
const kcProfit = Color(0xFF3EA34F);
const kcsubtitle3 = Color(0xFF555555);
const kcBlack2 = Color(0xFF212121);
const ktest = Color(0xFF2E3A59);

final kcboxshadow = const Color(0xFF333333).withOpacity(0.03);

MaterialColor kcprimarySwatch = createMaterialColor(kcPrimary);
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
