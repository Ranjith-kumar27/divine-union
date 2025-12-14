import 'package:equatable/equatable.dart';

abstract class LikesEvent extends Equatable {
  const LikesEvent();

  @override
  List<Object> get props => [];
}

class ChangeTab extends LikesEvent {
  final int index;

  const ChangeTab(this.index);

  @override
  List<Object> get props => [index];
}