import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/notes/presentation/screens/account.dart';
import 'package:wordie/src/features/home/presentation/screens/dashboard.dart';
import 'package:wordie/src/features/home/presentation/screens/favourites.dart';
import 'package:wordie/src/features/notes/presentation/screens/fav.dart';
import 'package:wordie/src/features/notes/presentation/screens/notes_dash.dart';

final currentWord = StateProvider((ref) => '');
final currentIndexProvider = StateProvider((ref) => 0);
final currentScreenProvider = Provider((ref) =>
    [const NotesHome(), const FavoritesScreen(), const AccountScreen()]);
