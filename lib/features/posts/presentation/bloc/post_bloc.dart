import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/post_repository.dart';
import '../../data/models/post_model.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;
  List<PostModel> _cachedPosts = [];

  PostBloc(this.repository) : super(PostInitial()) {
    on<LoadPostsEvent>(_onLoadPosts);
    on<AddPostEvent>(_onAddPost);
    on<UpdatePostEvent>(_onUpdatePost);
    on<DeletePostEvent>(_onDeletePost);
  }

  Future<void> _onLoadPosts(LoadPostsEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      _cachedPosts = await repository.fetchPosts();
      emit(PostLoaded(List.from(_cachedPosts)));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onAddPost(AddPostEvent event, Emitter<PostState> emit) async {
    try {
      final newPost = await repository.addPost(event.post);
      // JSONPlaceholder returns a mock post with ID 101. We prepend it locally for UI demonstration.
      _cachedPosts.insert(0, newPost);
      emit(PostLoaded(List.from(_cachedPosts)));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onUpdatePost(UpdatePostEvent event, Emitter<PostState> emit) async {
    try {
      final updatedPost = await repository.editPost(event.post);
      final index = _cachedPosts.indexWhere((p) => p.id == event.post.id);
      if (index != -1) {
        _cachedPosts[index] = updatedPost;
      }
      emit(PostLoaded(List.from(_cachedPosts)));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onDeletePost(DeletePostEvent event, Emitter<PostState> emit) async {
    try {
      await repository.removePost(event.id);
      _cachedPosts.removeWhere((p) => p.id == event.id);
      emit(PostLoaded(List.from(_cachedPosts)));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}
