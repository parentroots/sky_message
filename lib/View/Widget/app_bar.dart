import 'package:flutter/material.dart';
import 'package:sky_message/Utils/AppColors/app_colors.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.name});

  @override
  Size get preferredSize => const Size.fromHeight(100.0);
  final String name;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        color: AppColors.appBarColors,

      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5,left: 10,right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 20,),
            Icon(Icons.arrow_back_ios,color: Colors.white,),
            SizedBox(width: 10,),
            CircleAvatar(),

            SizedBox(width: 10,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(name,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.08,color: AppColors.whiteColor),)
              
            ],),

            Icon(Icons.call,color: AppColors.whiteColor),
            Icon(Icons.videocam,color: AppColors.whiteColor),
            Icon(Icons.more_vert,color: AppColors.whiteColor,),

          ],

        ),
      ),
    );
  }
}