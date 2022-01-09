import 'package:bloc/bloc.dart';
import 'package:budgets/core/accounts/application.dart';
import 'package:budgets/core/accounts/domain.dart';
import 'package:budgets/core/user/application.dart';
import 'package:budgets/core/user/domain.dart';
import 'package:injectable/injectable.dart';

part 'edit_account_screen_state.dart';

@injectable
class EditAccountScreenCubit extends Cubit<EditAccountScreenState> {
  UpdateAccount updateAccount;
  DeleteAccount deleteAccount;
  GetProfileInfo getProfileInfo;

  CreateAccount createAccount;

  EditAccountScreenCubit(
    this.updateAccount,
    this.deleteAccount,
    this.getProfileInfo,
    this.createAccount,
  ) : super(EditAccountScreenState.initial());

  Future<void> init(Account? account) async {
    if (account != null) {
      emit(state.copyWith(account: account));
      final userOption = await getProfileInfo();
      userOption.fold(
        () => emit(
          state.copyWith(
            user: UserEntity.empty(),
          ),
        ),
        (user) => emit(
          state.copyWith(
            user: user,
          ),
        ),
      );
    } else {
      emit(state.copyWith(isEditMode: false, account: Account.empty()));
      final userOption = await getProfileInfo();
      userOption.fold(
        () => emit(
          state.copyWith(
            user: UserEntity.empty(),
          ),
        ),
        (user) => emit(
          state.copyWith(
            user: user,
          ),
        ),
      );
    }
  }

  void onNameChanged(String? name) {
    if (state.account == null) return;
    emit(
      state.copyWith(
        account: state.account!..updateName(name!),
      ),
    );
  }

  Future<void> onAccountDeleted() async {
    await deleteAccount(state.account!.id);
  }

  Future<void> onAccountSaved({bool isNewAccount = false}) async {
    if (isNewAccount) {
      await createAccount(
        accountUserId: AccountUserId(state.user!.id.value),
        name: state.account!.name,
        color: state.account!.color,
        type: state.account!.type,
        imageUrl: state.account!.imageUrl,
      );
    } else {
      await updateAccount(
        userId: AccountUserId(state.user!.id.value),
        accountId: state.account!.id,
        name: state.account!.name,
        color: state.account!.color,
        type: state.account!.type,
        imageUrl: state.account!.imageUrl,
      );
    }
  }

  Future<void> onColorUpdated(int newColor) async {
    emit(
      state.copyWith(
        account: state.account!..updateColor(newColor),
      ),
    );
  }

  Future<void> onTypeUpdated(AccountType newType) async {
    emit(
      state.copyWith(
        account: state.account!..updateType(newType),
      ),
    );
  }

  Future<void> onTypeChanged(String? newType) async {
    final AccountType type;
    if (newType == 'Cuenta bancaria') {
      type = AccountType.bank;
    } else if (newType == 'Efectivo') {
      type = AccountType.cash;
    } else if (newType == 'Billetera') {
      type = AccountType.wallet;
    } else {
      type = AccountType.bank;
    }
    emit(
      state.copyWith(
        account: state.account!..updateType(type),
      ),
    );
  }

  Future<void> onLogoSelected(String imageUrl) async {
    emit(
      state.copyWith(
        account: state.account!..updateImageUrl(imageUrl),
      ),
    );
  }

  Future<void> onLogoDeleted() async {
    emit(
      state.copyWith(
        account: state.account!..updateImageUrl(null),
      ),
    );
  }

  void onBalanceChanged(String? newBalance) {
    if (state.account == null) return;
    emit(
      state.copyWith(
        account: state.account!..updateBalance(double.parse(newBalance!)),
      ),
    );
  }
}
