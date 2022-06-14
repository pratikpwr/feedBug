part of 'release_cubit.dart';

class ReleaseState extends Equatable {
  final String? title;
  final String? description;
  final bool isActive;
  final Flavor flavor;
  final String? buildLink;

  const ReleaseState({
    this.title,
    this.description,
    this.isActive = true,
    this.flavor = Flavor.dev,
    this.buildLink,
  });

  ReleaseState copyWith({
    String? title,
    String? description,
    bool? isActive,
    Flavor? flavor,
    String? buildLink,
  }) {
    return ReleaseState(
      title: title ?? this.title,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      flavor: flavor ?? this.flavor,
      buildLink: buildLink ?? this.buildLink,
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        isActive,
        flavor,
        buildLink,
      ];
}
