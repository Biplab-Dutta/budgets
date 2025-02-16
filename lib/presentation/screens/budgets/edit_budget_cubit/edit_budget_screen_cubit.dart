import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/budgets/application.dart';
import '../../../../core/budgets/domain.dart';
import '../../../../core/user/application.dart';
import '../../../../core/user/domain.dart';

part 'edit_budget_screen_state.dart';

@injectable
class EditBudgetScreenCubit extends Cubit<EditBudgetScreenState> {
  UpdateBudget updateBudget;
  DeleteBudget deleteBudget;
  GetProfileInfo getProfileInfo;
  CreateBudget createBudget;

  EditBudgetScreenCubit(
    this.updateBudget,
    this.deleteBudget,
    this.getProfileInfo,
    this.createBudget,
  ) : super(EditBudgetScreenState.initial());

  Future<void> init(Budget? budget) async {
    if (budget != null) {
      emit(state.copyWith(budget: budget));
      final userOption = await getProfileInfo();
      userOption.fold(
        () => emit(state.copyWith(user: UserEntity.empty())),
        (user) => emit(state.copyWith(user: user)),
      );
    } else {
      emit(state.copyWith(isEditMode: false, budget: Budget.empty()));
      final userOption = await getProfileInfo();
      userOption.fold(
        () => emit(state.copyWith(user: UserEntity.empty())),
        (user) => emit(state.copyWith(user: user)),
      );
    }
  }

  Future<void> onBudgetDeleted() async {
    await deleteBudget(state.budget!.id);
  }

  Future<void> onBudgetSaved({bool isNewBudget = false}) async {
    if (isNewBudget) {
      await createBudget(
        budgetUserId: BudgetUserId(state.user!.id.value),
        name: state.budget!.name,
        color: state.budget!.color,
        abbreviation: state.budget!.abbreviation,
        balance: state.budget!.balance,
      );
    } else {
      await updateBudget(
        userId: BudgetUserId(state.user!.id.value),
        budgetId: state.budget!.id,
        name: state.budget!.name,
        color: state.budget!.color,
        abbreviation: state.budget!.abbreviation,
        balance: state.budget!.balance,
      );
    }
  }

  Future<void> onColorUpdated(int newColor) async {
    emit(
      state.copyWith(
        budget: state.budget!..updateColor(newColor),
      ),
    );
  }

  void onNameChanged(String? name) {
    emit(
      state.copyWith(
        budget: state.budget!..updateName(name!),
      ),
    );
  }

  void onAbbreviationChanged(String? abbreviation) {
    emit(
      state.copyWith(
        budget: state.budget!..updateAbbreviation(abbreviation),
      ),
    );
  }

  void onBalanceChanged(double newBalance) {
    emit(
      state.copyWith(
        budget: state.budget!..updateBalance(newBalance),
      ),
    );
  }
}
