import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movieapp/api/api.dart';
import 'package:movieapp/detail_screen.dart';
import 'package:movieapp/models/movie.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  
  final Api api = Api();
  // List<Movie> movies = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api.fetchPopulerMovie(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(snapshot.hasError){
          return Center(
            child: Text("Error + ${snapshot.error.toString()}"),
          );
        }
        else if(snapshot.hasData){
          // movies = snapshot.data;
          print(snapshot.data.results[0].posterPath);
          return Container(
            height: double.infinity,
            width : double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0,0.25,0.6,0.7],
                colors: [
                  Color(0xFF000080).withOpacity(0.75), // Deep blue, replace with the exact color code
                Color(0xFF800080).withOpacity(0.7),
                  Colors.grey.shade100,
                  Colors.white
                ]
              ),
            ),
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: CarouselSlider.builder(
                    itemCount: snapshot.data.results.length, 
                    options: CarouselOptions(
                      // autoPlay: true,
                      enlargeCenterPage: true,
                      pageSnapping: true,
                      viewportFraction: 0.5,
          
                    ),
                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex){
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DetailPage(movieId: snapshot.data.results[itemIndex].id)),
                            );
                          },
                          child: Container(
                            // height: 400,
                            width: 200,
                            child: Image.network("https://image.tmdb.org/t/p/original${snapshot.data.results[itemIndex].posterPath}"),
                          ),
                        ),
                      );
                    }, 
                  )
                ),
                SizedBox(height: 25,),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.access_time),
                    SizedBox(width: 5,),
                      Text("2h 30m djfkaldjfkadlsfjdkasljfakslf",
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w600,
                        ),
                    )
                  ],
                ),
                SizedBox(height: 25,),
                Text(snapshot.data.results[0].title,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                // Text("Fantastic Beasts: The Secrets of Dumbledore",
                //   style: TextStyle(
                //     fontFamily: 'OpenSans',
                //     fontWeight: FontWeight.w600,
                //     fontSize: 25,
                //   ),
                //   textAlign: TextAlign.center,
                //   maxLines: 2,
                // ),
                SizedBox(height: 25,),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(120),
                        
                      ),
                      child: Text("Fantasy",
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w600,
                              ),
                            
                            ),
                    ),
                    SizedBox(width: 5,)
                  ],
                ),
              ],
            ),
          );
        }
        else{
          return Center(
            child: Text("No data")
          );
        }
      },
    );
  }
}