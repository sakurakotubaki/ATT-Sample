import 'package:app_tracker/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String _authStatus = 'Unknown';

    /// [initStateの代わりにuseEffectメソッドを使用]
    useEffect(() {
      initPlugin(context);
      return null;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('アプリのトラッキングの透明性の例'),
      ),
      body: Center(
        child: Text('トラッキングの状況: $_authStatus\n'),
      ),
    );
  }
}
