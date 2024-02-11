import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/api/api.dart';
import 'package:movieapp/detail_screen.dart';

class HomeScreen3 extends StatefulWidget {
  const HomeScreen3({super.key});

  @override
  State<HomeScreen3> createState() => _HomeScreen3State();
}

class _HomeScreen3State extends State<HomeScreen3> {
  int _index = 0;
  Api api = new Api();
  late Future _movieFuture;
  // late Future _detailFuture;
  Future? _detailFuture;
  int idMovie = 0;
  int _minutes = 0;
  List<int> moviess = [];
  void initState() {
    super.initState();
    _movieFuture = api.fetchPopulerMovie();
    _movieFuture.then((movieData){
      if(movieData.results.isNotEmpty){
        // print(movieData.results[0].id);
        // _detailFuture = api.fetchPopulerMovieDetail(movieData.results[0].id);
         setState(() {
          _detailFuture = api.fetchPopulerMovieDetail(movieData.results[0].id);
        });
      }
    }).catchError((error) {
    // Handle any errors here
    print("Error fetching movie details: $error");
  });
    // _detailFuture = api.fetchPopulerMovieDetail(movie index of the first movie);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _movieFuture,
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
                      height: 280,
    
                      onPageChanged: (idx, reason) {
                        print('Page changed to $idx at ${DateTime.now()}');
                        setState(() {
                          _index = idx;
                          _detailFuture = api.fetchPopulerMovieDetail(snapshot.data.results[idx].id);


                        });
                      }


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
                            width: 200,
                            // child: Text(snapshot.data.results[_index].title)
                            child: Image.network("https://image.tmdb.org/t/p/original${snapshot.data.results[itemIndex].posterPath}",
                              fit: BoxFit.fill,
                              loadingBuilder: (BuildContext context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    }, 
                  )
                ),
                SizedBox(height: 25,),
                FutureBuilder(
                  future: _detailFuture,
                  // initialData: InitialData,
                  builder: (BuildContext context, AsyncSnapshot snapshotDetail) {
                    if(snapshotDetail.data == ConnectionState.waiting){
                      return Center(
                        child: CircularProgressIndicator(),      
                      );
                    }
                    else if(snapshotDetail.hasError){
                      return Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.access_time),
                              SizedBox(width: 5,),
                              Text("No Data",
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          );
                    }
                    else if(snapshotDetail.hasData){
                      return Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.access_time),
                              SizedBox(width: 5,),
                              Text("${snapshotDetail.data.runtime} minutes",
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          );
                      }
                    else{
                      return Center(
                        child: Text("No data")
                      );
                    }
                  },
                ),
                SizedBox(height: 25,),
                Text(snapshot.data.results[_index].title,
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
                FutureBuilder(
                  future: _detailFuture,
                  builder: (BuildContext context, AsyncSnapshot snapshotDetaill) {
                    if (snapshotDetaill.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshotDetaill.hasError) {
                      return Text("Error: ${snapshotDetaill.error}");
                    }
                    else if(snapshotDetaill.hasData){
                      return 
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: List.generate(
                      //     snapshotDetaill.data.genres.length, 
                      //     (index) => Row(
                      //       children: [
                      //         Container(
                      //           padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      //           decoration: BoxDecoration(
                      //             border: Border.all(color: Colors.grey),
                      //             borderRadius: BorderRadius.circular(120),
                                  
                      //           ),
                      //           child: Text(snapshotDetaill.data.genres[index].name,
                      //                   style: TextStyle(
                      //                     fontFamily: 'OpenSans',
                      //                     fontWeight: FontWeight.w600,
                      //                   ),
                                      
                      //                 ),
                      //         ),
                      //         SizedBox(width: 5,),
                      //       ],
                      //     ),
                      //   ),
                      //   // children: [
                      //   // ],
                      // );
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 5,
                        runSpacing: 5,
                        children: List.generate(
                            snapshotDetaill.data.genres.length, 
                            (index) =>  
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(120),
                                  
                                ),
                                child: 
                                  Text(snapshotDetaill.data.genres[index].name,
                                    style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ),
                          ),
                      );
                    }
                    else {
                      return Text("No data");
                    }
                  },
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