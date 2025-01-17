part of 'edit_account_screen_cubit.dart';

class EditAccountScreenState {
  final Account? account;
  final UserEntity? user;
  final bool isLoading;
  final bool isEditMode;

  EditAccountScreenState({
    this.account,
    this.user,
    required this.isLoading,
    required this.isEditMode,
  });

  factory EditAccountScreenState.initial() => EditAccountScreenState(
        isLoading: false,
        isEditMode: true,
      );

  EditAccountScreenState copyWith({
    Account? account,
    UserEntity? user,
    bool? isLoading,
    bool? isEditMode,
  }) {
    return EditAccountScreenState(
      account: account ?? this.account,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }
}
