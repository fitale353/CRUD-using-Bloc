import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/network/dio_client.dart';
import 'features/posts/data/datasources/post_remote_data_source.dart';
import 'features/posts/domain/repositories/post_repository.dart';
import 'features/posts/presentation/bloc/post_bloc.dart';
import 'features/posts/presentation/bloc/post_event.dart';
import 'features/posts/presentation/pages/post_list_page.dart';

void main() {
  // Initialize dependencies
  final dioClient = DioClient();
  final remoteDataSource = PostRemoteDataSource(dioClient.dio);
  final repository = PostRepository(remoteDataSource);

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final PostRepository repository;
  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(repository). .add(LoadPostsEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
        home: const PostListPage(),
      ),
    );
  }
}
