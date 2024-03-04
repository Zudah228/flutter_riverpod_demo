import 'package:flutter/material.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class UserDataInputPage extends StatelessWidget {
  const UserDataInputPage._();

  static const routeName = '/reactive_user_data_input';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const UserDataInputPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ReactiveFormBuilder(
      form: UserDataFormSettings.form,
      builder: (context, formGroup, child) {
        return Scaffold(
          appBar: AppBar(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (!formGroup.valid) {
                formGroup.markAllAsTouched();
              } else {
                formGroup.reset();
              }
            },
            child: const Icon(Icons.send),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              children: [
                const SizedBox(height: 16),
                ReactiveTextField<String>(
                  formControlName: UserDataFormSettings.formNames.name,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ReactiveCheckbox(
                      formControlName: UserDataFormSettings.formNames.premium,
                    ),
                    const SizedBox(width: 8),
                    ReactiveValueListenableBuilder<bool>(
                      formControlName: UserDataFormSettings.formNames.premium,
                      builder: (context, control, _) {
                        return Text(
                          'Premium',
                          style: TextStyle(
                            color: control.value ?? false
                                ? colorScheme.primary
                                : null,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                ReactiveValueListenableBuilder<bool>(
                  formControlName: UserDataFormSettings.formNames.premium,
                  builder: (context, control, _) {
                    return Visibility(
                      visible: control.value ?? false,
                      child: Column(
                        children: [
                          ReactiveSlider(
                            formControlName:
                                UserDataFormSettings.formNames.premiumFee,
                            min: 1000,
                            max: 50000,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                ReactiveDateTimePicker(
                  formControlName: UserDataFormSettings.formNames.birthDate,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  decoration: const InputDecoration(
                    label: Text('BirthDay'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class UserDataFormSettings {
  const UserDataFormSettings._();

  static FormGroup form() {
    return fb.group({
      formNames.name: ['', Validators.required],
      formNames.premium: [false, Validators.required],
      formNames.premiumFee: [1000, Validators.min(1000), Validators.max(50000)],
      formNames.birthDate: FormControl<DateTime>(),
    });
  }

  static const formNames = UserDataFormNames();
}

@immutable
class UserDataFormNames {
  const UserDataFormNames();

  String get name => 'name';
  String get premium => 'premium';
  String get premiumFee => 'premiumFee';
  String get birthDate => 'birthDate';
}
