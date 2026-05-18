import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/post_model.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';

class PostFormPage extends StatefulWidget {
  final PostModel? post;
  const PostFormPage({super.key, this.post});

  @override
  State<PostFormPage> createState() => _PostFormPageState();
}

class _PostFormPageState extends State<PostFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post?.title ?? '');
    _bodyController = TextEditingController(text: widget.post?.body ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.post != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Post' : 'Create Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        key: _formKey,
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(labelText: 'Body'),
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final post = PostModel(
                    id: widget.post?.id,
                    title: _titleController.text,
                    body: _bodyController.text,
                    userId: widget.post?.userId ?? 1,
                  );
                  if (isEdit) {
                    context.read<PostBloc>().add(UpdatePostEvent(post));
                  } else {
                    context.read<PostBloc>().add(AddPostEvent(post));
                  }
                  Navigator.pop(context);
                },
                child: Text(isEdit ? 'Update' : 'Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }
}
