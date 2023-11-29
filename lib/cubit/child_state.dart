part of 'child_cubit.dart';

sealed class ChildState extends Equatable {
  const ChildState();

  @override
  List<Object> get props => [];
}

final class ChildInitial extends ChildState {}

final class ChildLoading extends ChildState {}

final class StatusChanged extends ChildState {}

final class ChildLoaded extends ChildState {
  final List<ChildModel> children;

  const ChildLoaded({required this.children});

  @override
  List<Object> get props => [children];
}
