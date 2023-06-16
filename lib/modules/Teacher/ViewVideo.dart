import 'package:graduation/modules/Teacher/Bloc/Cubit.dart';
import 'package:graduation/modules/Teacher/Bloc/States.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';


class ViewVideo extends StatelessWidget {
final String url;
ViewVideo({required this.url});
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return BlocProvider(
      create: (context)=>CubitTeacher()..ChangeVideoPlayer(url),
      child: BlocConsumer<CubitTeacher,TeacherStates>(
        listener: (context,state){

        },
        builder: (context,state){
          var cubit=CubitTeacher.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('View  Video'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: cubit.controller.value.isInitialized?
                      SizedBox(
                        height: size.height *0.5,
                        width: double.infinity,
                        child: AspectRatio(
                          child: VideoPlayer(
                              cubit.controller
                          ),
                          aspectRatio: cubit.controller.value.aspectRatio,

                        ),
                      ):Container()
                  ),
                  VideoProgressIndicator(cubit.controller, allowScrubbing: true),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: ()async{
                            Duration? value=await cubit.controller.position;
                            var d=value! - Duration(seconds: 10);
                            cubit.controller.seekTo(Duration(seconds: d.inSeconds));
                          },
                          child: Text('<=')
                      ),
                      ElevatedButton(
                          onPressed: ()async{
                            cubit.controller.play();
                          },
                          child: Icon(Icons.play_arrow_rounded)
                      ),
                      ElevatedButton(
                          onPressed: ()async{
                            cubit.controller.pause();
                          },
                          child: Icon(Icons.pause)
                      ),
                      ElevatedButton(
                          onPressed: ()async{
                            Duration? value=await cubit.controller.position;
                            var d=value! + Duration(seconds: 10);
                            cubit.controller.seekTo(Duration(seconds: d.inSeconds));
                          },
                          child: Text('<=')
                      ),



                    ],
                  ),
                ],
              ),
            ),

          );
        },

      ),
    );
  }
}
