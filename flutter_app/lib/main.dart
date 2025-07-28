import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants/app_constants.dart';
import 'package:flutter_app/core/theme/app_theme_mode_adapter.dart';
import 'package:flutter_app/core/theme/theme_provider.dart';
import 'package:flutter_app/features/chat/data/data_sources/local_data_source.dart';
import 'package:flutter_app/features/chat/data/repository_impl/message_repository_impl.dart';
import 'package:flutter_app/features/chat/domain/entities/message.dart';
import 'package:flutter_app/features/chat/presentation/providers/chat_provider.dart';
import 'package:flutter_app/features/chat/presentation/screens/message_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(MessageAdapter());
  Hive.registerAdapter(MessageSenderAdapter());
  Hive.registerAdapter(AppThemeModeAdapter());

  await Hive.openBox<Message>(AppConstants.hiveBoxName);
  await Hive.openBox(AppConstants.hiveThemeBox);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:
              (_) =>
                  ChatProvider(MessageRepositoryImpl(LocalMessageDataSource())),
        ),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.materialTheme== ThemeMode.light?  ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        brightness: Brightness.light,
      ) : ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),

      home: const MessagesScreen(),
    );
  }
}
