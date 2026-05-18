import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/post_model.dart';

class PostRemoteDataSource {
  final Dio dio;

  PostRemoteDataSource(this.dio);

  Future<List<PostModel>> getPosts() async {
    final response = await dio.get(ApiConstants.posts);
    return (response.data as List).map((json) => PostModel.fromJson(json)).toList();
  }

  Future<PostModel> createPost(PostModel post) async {
    final response = await dio.post(ApiConstants.posts, data: post.toJson());
    return PostModel.fromJson(response.data);
  }

  Future<PostModel> updatePost(PostModel post) async {
    final response = await dio.put('${ApiConstants.posts}/${post.id}', data: post.toJson());
    return PostModel.fromJson(response.data);
  }

  Future<void> deletePost(int id) async {
    await dio.delete('${ApiConstants.posts}/$id');
  }
}
