import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_riverpod_app/controller/post_controller.dart';
import 'package:http_riverpod_app/dto/post/post_response_dto.dart';
import 'package:http_riverpod_app/model/post/post.dart';
import 'package:http_riverpod_app/view/pages/post/home/post_home_page_view_model.dart';

class PostHomePage extends ConsumerWidget {
  const PostHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PostController pc = ref.read(postController);
    PostHomePageModel? pm = ref.watch(postHomePageProvider);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: pm != null ? buildListView(pm.posts) : buildListView([])),
          ElevatedButton(
            onPressed: () {
              pc.findPosts(); // provider에 넣어주고 watch한다
            },
            child: Text("페이지로드"),
          ),
          ElevatedButton(
            onPressed: () {
              pc.addPost("제목4");
            },
            child: Text("한 건 추가"),
          ),
          ElevatedButton(
            onPressed: () {
              pc.removePost(1);
            },
            child: Text("한건 삭제"),
          ),
          ElevatedButton(
            onPressed: () {
              pc.updatePost(Post(id: 2,title: "제목 하하"));
            },
            child: Text("한건 수정"),
          ),
        ],
      ),
    );
  }

  Widget buildListView(List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) => ListTile(
        leading: Text("${posts[index].id}"),
        title: Text("${posts[index].title}"),
      ),
    );
  }
}
