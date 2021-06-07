// import 'package:flutter/material.dart';
// import 'package:flutter_movie_app/UI/movie_details_post/MovieDetailsPost_provider.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:provider/provider.dart';
//
// class MovieDetailsPostScreen extends StatelessWidget {
//   const MovieDetailsPostScreen({
//     Key key,
//     @required this.id,
//   }) : super(key: key);
//
//   final int id;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ChangeNotifierProvider<MovieDetailsPostProvider>(
//         create: (context) => MovieDetailsPostProvider(id),
//         child: Consumer<MovieDetailsPostProvider>(
//           builder: (buildContext, movieDetailsPostProvider, _) {
//             final movieDetails = movieDetailsPostProvider.posts;
//             return (movieDetails != null)
//                 ? NestedScrollView(
//                     headerSliverBuilder:
//                         (BuildContext context, bool innerBoxIsScrolled) {
//                       return <Widget>[
//                         SliverAppBar(
//                           expandedHeight: 550.0,
//                           floating: false,
//                           pinned: true,
//                           flexibleSpace: FlexibleSpaceBar(
//                               centerTitle: true,
//                               title: Text(movieDetails.title,
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16.0,
//                                   )),
//                               background: Image.network(
//                                 'https://image.tmdb.org/t/p/w500${movieDetails.posterPath}',
//                                 fit: BoxFit.cover,
//                               )),
//                         ),
//                       ];
//                     },
//                     body: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   '${movieDetails.title}',
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 Row(
//                                   children: [
//                                     RatingBarIndicator(
//                                       rating: movieDetails.voteAverage / 2,
//                                       itemCount: 5,
//                                       itemSize: 20.0,
//                                       physics: BouncingScrollPhysics(),
//                                       itemBuilder: (context, _) => Icon(
//                                         Icons.star,
//                                         color: Colors.amber,
//                                       ),
//                                     ),
//                                     Text(
//                                         '${movieDetails.voteAverage.toString()}/10')
//                                   ],
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 8.0),
//                                   child: Text(
//                                     'Release date: ${movieDetails.releaseDate}',
//                                     style: TextStyle(fontSize: 16),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 8.0),
//                                   child: Text(
//                                     '${movieDetails.overview}',
//                                     style: TextStyle(fontSize: 16),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       top: 5.0, bottom: 5.0),
//                                   child: Wrap(
//                                     children: movieDetails.genres
//                                         .map(
//                                           (e) => Padding(
//                                             padding: const EdgeInsets.only(
//                                                 right: 5.0),
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                 border: Border.all(
//                                                   color: Colors.black,
//                                                 ),
//                                                 borderRadius:
//                                                     BorderRadius.circular(20),
//                                               ),
//                                               child: Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(5.0),
//                                                 child: Text(
//                                                   e.name,
//                                                   style:
//                                                       TextStyle(fontSize: 15),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                         .toList(),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ))
//                 : Center(child: CircularProgressIndicator());
//           },
//         ),
//       ),
//     );
//   }
// }
