import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movieapp/api/api.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key, required this.movieId});
  Api api = Api();
  final int movieId;
  late Future _detailPeopleFuture;
  
  // void initState(){
  //   super.initState();
  //   _detailFuture = getMovieDetail(movieId);

  // }
  @override
  Widget build(BuildContext context) {
    Future _detailFuture = api.fetchPopulerMovieDetail(movieId);
    Future _creditFuture = api.fetchPopulerMovieCredits(movieId);

    return FutureBuilder(
      future: _detailFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(snapshot.hasError){
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        else if(snapshot.hasData){
          return Container(
            color: Colors.grey.withOpacity(0.8),
            child: Column(
              children: [
                Container(
                  height: 300,
                  child: Image.network(
                    "https://image.tmdb.org/t/p/original${snapshot.data.backdropPath}",
                    fit: BoxFit.fill,
                  )
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                      color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top:25.0),
                                child: Column(
                                  children: [
                                    Text(snapshot.data.voteAverage.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        decoration: TextDecoration.none
                                      ),
                                    ),
                                    Text("Vote Average",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'OpenSans',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.none
                                      ),
                                    )
                                  ],
                                ),
                                
                              ),            
                              SizedBox(height: 25,),        
                              Text(snapshot.data.title,
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25,
                                  color: Colors.black,
                                  decoration: TextDecoration.none
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                              SizedBox(height: 25,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  snapshot.data.genres.length, 
                                  (index) => Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(120),
                                          
                                        ),
                                        child: Text(snapshot.data.genres[index].name,
                                                style: TextStyle(
                                                  fontFamily: 'OpenSans',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  decoration: TextDecoration.none
                                                ),
                                              
                                              ),
                                      ),
                                      SizedBox(width: 5,),
                                    ],
                                  ),
                                ),
                                // children: [
                                // ],
                              ),
                              SizedBox(height:35),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                                child: SizedBox(
                                  height: 50,
                                  child: FutureBuilder(
                                    future: _creditFuture,
                                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                                      
                                      if(snapshot.connectionState == ConnectionState.waiting){
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      else if(snapshot.hasError){
                                        return Text("Error: ${snapshot.error}");
                                      }
                                      else if(snapshot.hasData){
                                        return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                                  
                                          itemCount: min(10,snapshot.data.cast.length),
                                          itemBuilder: (context,index){
                                            return Container(
                                              margin: EdgeInsets.symmetric(horizontal:2),
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.amber,
                                              ),  
                                              child:FutureBuilder(
                                                future: api.fetchPeopleDetail(snapshot.data.cast[index].id),
                                                builder: (BuildContext context, AsyncSnapshot snapshotPerson) {
                                                  if(snapshotPerson.connectionState == ConnectionState.waiting){
                                                    return Center(child: CircularProgressIndicator());
                                                  }
                                                  else if(snapshotPerson.hasError){
                                                    return Center(
                                                      child: Text("No Data",
                                                      style: TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 10,
                                                        color: Colors.black,
                                                        decoration: TextDecoration.none
                                                      ),),
                                                    );
                                                  }
                                                  else if(snapshotPerson.hasData){
                                                    return ClipOval(
                                                      child: snapshotPerson.data.profilePath != null && snapshotPerson.data.profilePath.isNotEmpty
                                                      ? Image.network(
                                                          "https://image.tmdb.org/t/p/original${snapshotPerson.data.profilePath}",
                                                          fit: BoxFit.fill,
                                                        )
                                                      : Container(
                                                          color: Colors.grey, 
                                                          child: Icon(
                                                            Icons.person, 
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                    );
                                                  }
                                                  else{
                                                    return Text("No data");
                                                  }
                                                },
                                              )
                                            );  
                                          }
                                        );
                                      }
                                      else{
                                        return Text("No Data");
                                      }
                                    },
                                  ), 
                                )
                              ),
                              SizedBox(height: 30,),
                              Padding(
                                padding:EdgeInsets.symmetric(horizontal: 40),
                                child: Text(
                                  snapshot.data.overview,
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.black,
                                    decoration: TextDecoration.none
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                ),
                              ), 
                              SizedBox(height:25),
                              GestureDetector(
                                onTap: (){
                                },
                                child: Container(
                                  height:50,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: Color(0xff1a2c50),
                                    borderRadius: BorderRadius.all(Radius.circular(100))
                                  ),
                                  child: Center(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.wallet,
                                          color: Color(0xfffebc04),
                                        ),
                                        SizedBox(width: 5),
                                        Text("Booking",
                                          style: TextStyle(
                                            color: Color(0xfffebc04),
                                            fontFamily: 'OpenSans',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            decoration: TextDecoration.none
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                              
                            
                          
                            
                          ),
                        ],
                      ),
                    )
                  ),
                ),
              ],
            ),
          );
        }
        else{
          return Center(
            child: Text("No Data") ,
          );
        }
      }
    );
  }
}
  //     child: Container(
  //       color: Colors.grey,
  //       child: Column(
  //         children: [
  //           Container(
  //             height: 300,
  //             color: Colors.amber
  //           ),
  //           Expanded(
  //             child: Container(
  //               width: double.infinity,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
  //                 color: Colors.white
  //               ),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Column(
  //                   children: [
  //                     Column(
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.only(top:25.0),
  //                           child: Column(
  //                             children: [
  //                               Text("63%",
  //                                 style: TextStyle(
  //                                   color: Colors.black,
  //                                   fontSize: 20,
  //                                   decoration: TextDecoration.none
  //                                 ),
  //                               ),
  //                               Text("Rotten Tomatoes",
  //                                 style: TextStyle(
  //                                   color: Colors.grey,
  //                                   fontFamily: 'OpenSans',
  //                                   fontSize: 16,
  //                                   fontWeight: FontWeight.w400,
  //                                   decoration: TextDecoration.none
  //                                 ),
  //                               )
  //                             ],
  //                           ),
                            
  //                         ),            
  //                         SizedBox(height: 25,),        
  //                         Text("Fantastic Beasts: The Secrets of Dumbledore",
  //                           style: TextStyle(
  //                             fontFamily: 'OpenSans',
  //                             fontWeight: FontWeight.w600,
  //                             fontSize: 25,
  //                             color: Colors.black,
  //                             decoration: TextDecoration.none
  //                           ),
  //                           textAlign: TextAlign.center,
  //                           maxLines: 2,
  //                         ),
  //                         SizedBox(height: 25,),
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             Container(
  //                               padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
  //                               decoration: BoxDecoration(
  //                                 border: Border.all(color: Colors.grey),
  //                                 borderRadius: BorderRadius.circular(120),
                                  
  //                               ),
  //                               child: Text("Fantasy",
  //                                       style: TextStyle(
  //                                         fontFamily: 'OpenSans',
  //                                         fontWeight: FontWeight.w600,
  //                                         fontSize: 16,
  //                                         color: Colors.black,
  //                                         // no underline
  //                                         decoration: TextDecoration.none
  //                                       ),
                                      
  //                                     ),
  //                             ),
  //                             SizedBox(width: 5,),
  //                             Container(
  //                               padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
  //                               decoration: BoxDecoration(
  //                                 border: Border.all(color: Colors.grey),
  //                                 borderRadius: BorderRadius.circular(120),
                                  
  //                               ),
  //                               child: Text("Adventure",
  //                                       style: TextStyle(
  //                                         fontFamily: 'OpenSans',
  //                                         fontWeight: FontWeight.w600,
  //                                         fontSize: 16,
  //                                         color: Colors.black,
  //                                         decoration: TextDecoration.none
  //                                       ),
                                      
  //                                     ),
  //                             ),
  //                           ],
  //                         ),
  //                         SizedBox(height:35),
  //                         Padding(
  //                           padding: const EdgeInsets.symmetric(horizontal: 28.0),
  //                           child: SizedBox(
  //                             height: 50,
  //                             child: ListView.builder(
  //                               scrollDirection: Axis.horizontal,
      
  //                               itemCount: 10,
  //                               itemBuilder: (context,index){
  //                                 return Container(
  //                                   margin: EdgeInsets.symmetric(horizontal:2),
  //                                   height: 50,
  //                                   width: 50,
  //                                   decoration: BoxDecoration(
  //                                     shape: BoxShape.circle,
  //                                     color: Colors.amber,
  //                                   ),  
  //                                 );
  //                               }
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(height: 30,),
  //                         Padding(
  //                           padding:EdgeInsets.symmetric(horizontal: 40),
  //                           child: Text(
  //                             "Professor Albus Dumbledore knows the powerful, dark wizard Gellert Grindelwald is moving to seize control of the wizarding world. Unable to stop him fjdklfjadsfjadfjadfdkfjdl;f",
  //                             style: TextStyle(
  //                               fontFamily: 'OpenSans',
  //                               fontWeight: FontWeight.w500,
  //                               fontSize: 14,
  //                               color: Colors.black,
  //                               decoration: TextDecoration.none
  //                             ),
  //                             textAlign: TextAlign.center,
  //                             maxLines: 3,
  //                           ),
  //                         ), 
  //                         SizedBox(height:25),
  //                         GestureDetector(
  //                           onTap: (){
  //                           },
  //                           child: Container(
  //                             height:50,
  //                             width: 140,
  //                             decoration: BoxDecoration(
  //                               color: Colors.amber,
  //                               borderRadius: BorderRadius.all(Radius.circular(100))
  //                             ),
  //                             child: Center(
  //                               child: Row(
  //                                 crossAxisAlignment: CrossAxisAlignment.center,
  //                                 mainAxisAlignment: MainAxisAlignment.center,
  //                                 children: [
  //                                   Icon(
  //                                     Icons.wallet
  //                                   ),
  //                                   SizedBox(width: 5),
  //                                   Text("Booking",
  //                                     style: TextStyle(
  //                                       color: Colors.white,
  //                                       fontFamily: 'OpenSans',
  //                                       fontSize: 18,
  //                                       fontWeight: FontWeight.w600,
  //                                       decoration: TextDecoration.none
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         )
  //                       ],
                          
                        
                      
                        
  //                     ),
  //                   ],
  //                 ),
  //               )
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }