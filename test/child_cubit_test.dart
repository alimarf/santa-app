import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:santa_app/cubit/child_cubit.dart';

void main() {
  group('ChildCubit', () {
    late ChildCubit childCubit;

    setUp(() {
      childCubit = ChildCubit();
    });

    blocTest<ChildCubit, ChildState>(
      'emits [ChildInitial, ChildLoaded] when loadListChild is called',
      build: () => childCubit,
      act: (cubit) => cubit.loadListChild(),
      expect: () => [ChildInitial(), const ChildLoaded(children: [])],
    );
  });
}
