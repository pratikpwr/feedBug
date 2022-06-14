import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app/injection_container.dart';
import '../../../core/enums/flavors.dart';
import '../../../core/views/atomic/atoms/drop_down_item.dart';
import '../../../core/views/atomic/atoms/padding.dart';
import '../../../core/views/atomic/atoms/textfield_item.dart';
import '../../projects/models/project_model.dart';
import '../../releases/models/release_model.dart';
import '../bloc/create_update_release_bloc/create_update_release_bloc.dart';
import '../bloc/release_cubit/release_cubit.dart';

class CreateEditReleaseScreen extends StatelessWidget {
  final Release? release;
  final Project project;

  const CreateEditReleaseScreen({
    Key? key,
    this.release,
    required this.project,
  }) : super(key: key);

  bool get isEdit => release != null;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ReleaseCubit(release),
        ),
        BlocProvider(
          create: (context) => CreateUpdateReleaseBloc(repository: sl()),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(isEdit ? 'Edit Release' : 'Create Release'),
        ),
        floatingActionButton: Builder(builder: _buildFab),
        body: BlocBuilder<ReleaseCubit, ReleaseState>(
          builder: (context, state) {
            final cubit = context.read<ReleaseCubit>();
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    LabelledTextFieldItem(
                      title: 'Title*',
                      controller: cubit.titleController,
                      onChanged: cubit.title,
                    ),
                    padding16,
                    LabelledTextFieldItem(
                      title: 'Description',
                      controller: cubit.descriptionController,
                      onChanged: cubit.description,
                    ),
                    padding16,
                    DropdownItem<Flavor>(
                      hint: 'Release Flavor',
                      items: Flavor.values,
                      value: cubit.state.flavor,
                      onChanged: (value) {
                        if (value != null) {
                          cubit.flavor(value);
                        }
                      },
                      itemToString: (type) {
                        return type.name;
                      },
                    ),
                    padding16,
                    DropdownItem<bool>(
                      hint: 'Is Active',
                      items: const [true, false],
                      value: cubit.state.isActive,
                      onChanged: (value) {
                        if (value != null) {
                          cubit.isActive(value);
                        }
                      },
                      itemToString: (type) {
                        return type.toString();
                      },
                    ),
                    padding16,
                    LabelledTextFieldItem(
                      title: 'Build Link',
                      controller: cubit.buildLinkController,
                      onChanged: cubit.buildLink,
                    ),
                    // TODO : add icon to visit web link
                    padding64,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        final newTicket =
            BlocProvider.of<ReleaseCubit>(context).createRelease(project);

        isEdit
            ? BlocProvider.of<CreateUpdateReleaseBloc>(context)
                .add(UpdateRelease(release: newTicket))
            : BlocProvider.of<CreateUpdateReleaseBloc>(context)
                .add(SubmitRelease(release: newTicket));
      },
      child: BlocConsumer<CreateUpdateReleaseBloc, CreateUpdateReleaseState>(
        listener: (context, state) {
          if (state is CreateUpdateReleaseSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is CreateUpdateReleaseLoading) {
            return const CircularProgressIndicator();
          }
          return const Icon(Icons.save);
        },
      ),
    );
  }
}
