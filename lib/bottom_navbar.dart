import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,  
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
        color: Color(0xff1a2c50)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: (){},
            icon:Icon(Icons.movie,
                  size: 30, 
                  color: Color(0xfffebc04),
                 )
          ),
          IconButton(
            onPressed: (){},
            icon:Icon(Icons.search, 
                  size: 30,
                  color: Color(0xfffebc04),
                )
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.local_movies_rounded,
                    size: 30,
                    color: Color(0xfffebc04),
                  ),
          ),
          IconButton(
            onPressed: (){},
            icon:Icon(Icons.person,
                  size: 30,
                  color: Color(0xfffebc04),
                ) 
            ,)
        ],
      ),
    );
  }
}