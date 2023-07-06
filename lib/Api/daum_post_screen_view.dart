import 'package:classcar/widgets/appbar.dart';
import 'package:classcar/widgets/apptheme.dart';
import 'package:daum_postcode_search/daum_postcode_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

//flutter pub add flutter_daum_postcode
//flutter pub add flutter_inappwebview
//flutter pub add flutter_daum_postcode_search
//flutter pub add daum_postcode_search

class LibraryDaumPostcodeScreen extends StatelessWidget {
  const LibraryDaumPostcodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkTheme.colorScheme.background,
      appBar: appBar(title: "다음 주소 검색"),
      body: DaumPostcodeSearch(
        webPageTitle: "다음 주소 검색",
        initialOption: InAppWebViewGroupOptions(),
        onConsoleMessage: ((controller, consoleMessage) {}),
        onLoadError: ((controller, url, code, message) {}),
        onLoadHttpError: (controller, url, statusCode, description) {},
        onProgressChanged: (controller, progress) {},
        androidOnPermissionRequest: (controller, origin, resources) async {
          return PermissionRequestResponse(
              resources: resources,
              action: PermissionRequestResponseAction.GRANT);
        },
      ),
    );
  }
}
