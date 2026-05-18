import 'package:equatable/equatable.dart';
import '../../data/models/post_model.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
  @override
  List<Object?> get props => [];
}

class LoadPostsEvent extends PostEvent {}
class AddPostEvent extends PostEvent { final PostModel post; const AddPostEvent(this.post); }
class UpdatePostEvent extends PostEvent { final PostModel post; const UpdatePostEvent(this.post); }
class DeletePostEvent extends PostEvent { final int id; const DeletePostEvent(this.id); }
