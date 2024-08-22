library crypto_icon;

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CryptoIcon {
  CryptoIcon._();

  static Future<void> initialize() async {
    await dotenv.load(fileName: ".env");
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );
  }

  static Future<Widget> fromSymbol(String cryptoSymbol) async {
    final filename = '${cryptoSymbol.toLowerCase()}.svg';
    final cryptoUrl = await Supabase.instance.client.storage
      .from(dotenv.env['BUCKET_NAME']!)
      .createSignedUrl(filename, 60*60*24);
    return SvgPicture.network(
      cryptoUrl,
      placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),
    );
  }

}
