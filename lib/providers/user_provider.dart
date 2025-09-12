import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/user_repository.dart';
import '../models/user.dart';

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepository(),
);

final userProvider = FutureProvider.family<User?, String>((ref, userId) async {
  final repo = ref.watch(userRepositoryProvider);
  return repo.getUserById(userId);
});
