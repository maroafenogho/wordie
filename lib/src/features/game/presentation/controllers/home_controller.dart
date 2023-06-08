import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/game/presentation/screens/account.dart';
import 'package:wordie/src/features/game/presentation/screens/dashboard.dart';
import 'package:wordie/src/features/game/presentation/screens/favourites.dart';

final currentWord = StateProvider((ref) => '');
final currentIndexProvider = StateProvider((ref) => 0);
final currentScreenProvider = Provider(
    (ref) => [const Dashboard(), const Favourites(), const AccountScreen()]);
