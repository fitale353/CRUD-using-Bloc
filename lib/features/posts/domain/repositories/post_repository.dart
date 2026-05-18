import 'package:dio/dio.dart';
import '../../../../core/errors/failures.dart';
import '../../data/datasources/post_remote_data_source.dart';
import '../../data/models/post_model.dart';

class PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepository(this.remoteDataSource);

  Future<List<PostModel>> fetchPosts() async {
    try {
      return await remoteDataSource.getPosts();
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Failed to load posts');
    }
  }

  Future<PostModel> addPost(PostModel post) async {
    try {
      return await remoteDataSource.createPost(post);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Failed to create post');
    }
  }

  Future<PostModel> editPost(PostModel post) async {
    try {
      return await remoteDataSource.updatePost(post);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Failed to update post');
    }
  }

  Future<void> removePost(int id) async {
    try {
      await remoteDataSource.deletePost(id);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Failed to delete post');
    }
  }
}
