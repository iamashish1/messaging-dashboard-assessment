import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants/app_urls.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InternalToolsScreen extends StatefulWidget {
  const InternalToolsScreen({super.key});

  @override
  State<InternalToolsScreen> createState() => _InternalToolsScreenState();
}

class _InternalToolsScreenState extends State<InternalToolsScreen> {
  late final WebViewController controller;
  double _progress = 0;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    initializeWebviewController();
  }

  String get _deviceLocalHostUrl => AppUrls.localhostUrl;

  void initializeWebviewController() {
    controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                setState(() {
                  _progress = progress / 100;
                });
              },
              onPageStarted: (String url) {
                setState(() {
                  _isLoading = true;
                  _hasError = false;
                });
              },
              onPageFinished: (String url) {
                setState(() {
                  _isLoading = false;
                });
              },
              onWebResourceError: (WebResourceError error) {
                setState(() {
                  _hasError = true;
                  _isLoading = false;
                });
              },
              onNavigationRequest: (NavigationRequest request) {
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(_deviceLocalHostUrl));
  }

  @override
  void dispose() {
    controller.clearCache();
    controller.clearLocalStorage();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Internal Tools')),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (_isLoading || _hasError)
            Container(
              color: Colors.white.withAlpha(100),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isLoading) ...[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          value: _progress,
                          strokeWidth: 6,
                          backgroundColor: Colors.blueAccent,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${(_progress * 100).toStringAsFixed(0)}%',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Loading internal tools...',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                    if (_hasError) ...[
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Failed to load content',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _hasError = false;
                            _isLoading = true;
                          });
                          controller.reload();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
