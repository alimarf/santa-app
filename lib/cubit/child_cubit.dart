import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:santa_app/child_model.dart';

part 'child_state.dart';

class ChildCubit extends Cubit<ChildState> {
  ChildCubit() : super(ChildInitial());

  final List<ChildModel> children = [];

  //This function should call list of children
  void loadListChild() {
    emit(ChildInitial());

    Future.delayed(Duration(seconds: 2), () {
      emit(ChildLoaded(children: children));
    });
  }

  //This function should add new child to the list
  void addChild({required ChildModel childModel}) {
    emit(ChildLoading());
    children.add(childModel);

    emit(ChildLoaded(children: children));
  }

  //This fucntion to change status each child
  void toggleChildStatus(int index) {
    emit(StatusChanged());
    children[index] = children[index].copyWith(isNice: !children[index].isNice);
    emit(ChildLoaded(children: children));
  }
}
