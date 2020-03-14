import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:naqelapp/session/Userprofile.dart';
import 'package:naqelapp/styles/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naqelapp/utilts/panel.dart';
import 'package:naqelapp/utilts/toast_utility.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  {
  ScrollController _controllerddd = ScrollController();

   Completer<GoogleMapController> _controller = Completer();
  static LatLng latLng =LatLng(0, 0,);
   PanelController _pc = new PanelController();

  @override
  void initState(){
    super.initState();
    _fabHeight = _initFabHeight;

    getLocation();
  }
  LatLng userPosition;
   Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS

  Future<void> getLocation() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    if (permission == PermissionStatus.denied) {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.locationAlways]);
    }
    PanelController _pc = new PanelController();


    var geolocator = Geolocator();
    GeolocationStatus geolocationStatus =
    await geolocator.checkGeolocationPermissionStatus();
    switch (geolocationStatus) {
      case GeolocationStatus.denied:
        print('denied');
        break;
      case GeolocationStatus.disabled:
      case GeolocationStatus.restricted:
        print('restricted');
        break;
      case GeolocationStatus.unknown:
        print('unknown');
        break;
      case GeolocationStatus.granted:



        await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
            .then((Position _position) async {
          if (_position != null) {

            userPosition = LatLng(_position.latitude, _position.longitude);
            final GoogleMapController controller = await _controller.future;

            _add(userPosition,controller);

            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: userPosition,
                    bearing: 0,
                    zoom: 15),
              ),

            );
            setState((){
            });
          }
        });
        break;
    }
  }

   Future<void> _add(LatLng p,GoogleMapController controller) async {


     final File markerImageFile = await DefaultCacheManager().getSingleFile(Userprofile.getProfileImage());
     final Uint8List markerImageBytes = await markerImageFile.readAsBytes();



     var markerIdVal = "Location";
     final MarkerId markerId = MarkerId(markerIdVal);

     // creating a new MARKER
     final Marker marker = Marker(
         icon: await getMarkerIcon( Size(150.0, 150.0)),
   //   icon: BitmapDescriptor.fromBytes(markerImageBytes),
       markerId: markerId,
       position: LatLng(
         p.latitude ,
         p.longitude ,
       ),
 //      infoWindow: InfoWindow(title: markerIdVal, snippet: 'click for details',onTap: (){
   //      print("Marker Window Tap");
     //  }),
       onTap: () {
         print("Marker Tap");
         controller.animateCamera(
           CameraUpdate.newCameraPosition(
             CameraPosition(target: p,
                 bearing: 0,
                 zoom: 18),
           ),

         );
        },
     );

     setState(() {
       // adding a new marker to map
       markers[markerId] = marker;
     });
   }
   final double _initFabHeight = 160.0;
   double _fabHeight;
   double _panelHeightOpen;
   double _panelHeightClosed = 130.0;
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
   IconData fab_icon = Icons.gps_fixed;

    @override
  Widget build(BuildContext context) {
      _panelHeightOpen = MediaQuery.of(context).size.height * .80;

      return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        backgroundColor: Colors.white,

        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
              Text('Jobs',style: TextStyle(color: Colors.black),),
            ]
        ),
      ),
      body: Stack(
        children: <Widget>[



          SlidingUpPanel(
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            controller: _pc,
            parallaxOffset: .5,

            collapsed: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(28.0), topRight: Radius.circular(28.0)),
              ),
              child: Column(
                children: <Widget>[
                     Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(

                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            SizedBox(height: 12.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 30,
                                  height: 5,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: BorderRadius.all(Radius.circular(12.0))
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 20.0,),

                          ],
                        ),
                      ],
                    ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _button("Requests", Icons.work, Colors.blue),
                      _button("Offers", Icons.card_giftcard, Colors.amber[800]),//amber
                      _button("On-Going", Icons.hourglass_full, Colors.green),//green
                    ],
                  ),
                ],
              ),
            ),

            body:  GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: latLng,
                zoom: 0,
              ),
              markers: Set<Marker>.of(markers.values),
            ),

            onPanelOpened: (){
              fab_icon=Icons.arrow_downward;

              setState(() {

              });
             },
            onPanelClosed: (){
              fab_icon=Icons.gps_fixed;

              setState(() {

              });
            },
            panelBuilder: (sc) => _panel(sc),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(28.0), topRight: Radius.circular(28.0)),
            onPanelSlide: (double pos) => setState((){
              _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) + _initFabHeight;
            }),
          ),

          Positioned(
            right: 20.0,
            bottom: _fabHeight-15,
            child: FloatingActionButton(
              child: Icon(
                fab_icon,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () async {

               if( _pc.isPanelOpen){


                  fab_icon =Icons.gps_fixed;
                  _pc.close();
                  setState(() {

                 });

               }else {
                 if (userPosition == null) {
                   getLocation();
                 } else {
                   final GoogleMapController controller = await _controller
                       .future;

                   _add(userPosition, controller);

                   controller.animateCamera(
                     CameraUpdate.newCameraPosition(
                       CameraPosition(target: userPosition,
                           bearing: 0,
                           zoom: 15),
                     ),

                   );
                   setState(() {});
                 }
               }
              },
              backgroundColor: Colors.white,
            ),
          ),


        ],
      ),


    );
  }
   Future<ui.Image> getImageFromPath() async {

     final File imageFile = await DefaultCacheManager().getSingleFile(Userprofile.getProfileImage());
  //   final Uint8List markerImageBytes = await markerImageFile.readAsBytes();

 //    File imageFile = File(imagePath);

     Uint8List imageBytes = imageFile.readAsBytesSync();

     final Completer<ui.Image> completer = new Completer();

     ui.decodeImageFromList(imageBytes, (ui.Image img) {
       return completer.complete(img);
     });

     return completer.future;
   }

   Future<BitmapDescriptor> getMarkerIcon( Size size) async {
     final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
     final Canvas canvas = Canvas(pictureRecorder);

     final Radius radius = Radius.circular(size.width / 2);

     final Paint tagPaint = Paint()..color = Colors.blue;
     final double tagWidth = 40.0;

     final Paint shadowPaint = Paint()..color = Colors.blue.withAlpha(100);
     final double shadowWidth = 15.0;

     final Paint borderPaint = Paint()..color = Colors.white;
     final double borderWidth = 3.0;

     final double imageOffset = shadowWidth + borderWidth;

     // Add shadow circle
     canvas.drawRRect(
         RRect.fromRectAndCorners(
           Rect.fromLTWH(
               0.0,
               0.0,
               size.width,
               size.height
           ),
           topLeft: radius,
           topRight: radius,
           bottomLeft: radius,
           bottomRight: radius,
         ),
         shadowPaint);

     // Add border circle
     canvas.drawRRect(
         RRect.fromRectAndCorners(
           Rect.fromLTWH(
               shadowWidth,
               shadowWidth,
               size.width - (shadowWidth * 2),
               size.height - (shadowWidth * 2)
           ),
           topLeft: radius,
           topRight: radius,
           bottomLeft: radius,
           bottomRight: radius,
         ),
         borderPaint);

  /*   // Add tag circle
     canvas.drawRRect(
         RRect.fromRectAndCorners(
           Rect.fromLTWH(
               size.width - tagWidth,
               0.0,
               tagWidth,
               tagWidth
           ),
           topLeft: radius,
           topRight: radius,
           bottomLeft: radius,
           bottomRight: radius,
         ),
         tagPaint);

     // Add tag text
     TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
   textPainter.text = TextSpan( text: '21', style: TextStyle(fontSize: 20.0, color: Colors.white),);

     textPainter.layout();
     textPainter.paint(
         canvas,
         Offset(
             size.width - tagWidth / 2 - textPainter.width / 2,
             tagWidth / 2 - textPainter.height / 2
         )
     );
*/
     // Oval for the image
     Rect oval = Rect.fromLTWH(
         imageOffset,
         imageOffset,
         size.width - (imageOffset * 2),
         size.height - (imageOffset * 2)
     );

     // Add path for oval image
     canvas.clipPath(Path()
       ..addOval(oval));

     // Add image
     ui.Image image = await getImageFromPath(); // Alternatively use your own method to get the image
     paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.cover);

     // Convert canvas to image
     final ui.Image markerAsImage = await pictureRecorder.endRecording().toImage(
         size.width.toInt(),
         size.height.toInt()
     );

     // Convert image to bytes
     final ByteData byteData = await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
     final Uint8List uint8List = byteData.buffer.asUint8List();

     return BitmapDescriptor.fromBytes(uint8List);
   }


   Widget _panel(ScrollController sc){
     return MediaQuery.removePadding(
         context: context,
         removeTop: true,
         child: Padding(
           padding: EdgeInsets.fromLTRB(0, _panelHeightClosed, 0, 0),
           child: ListView(
             controller: sc,
             children: <Widget>[

               Column(
                 children: <Widget>[




                   SizedBox(height: 36.0,),

                   Container(
                     padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[

                         Text("Images", style: TextStyle(fontWeight: FontWeight.w600,)),

                         SizedBox(height: 12.0,),

                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: <Widget>[
                             Image.network(
                               "https://images.fineartamerica.com/images-medium-large-5/new-pittsburgh-emmanuel-panagiotakis.jpg",
                               height: 120.0,
                               width: (MediaQuery.of(context).size.width - 48) / 2 - 2,
                               fit: BoxFit.cover,
                             ),

                             Image.network(
                               "https://cdn.pixabay.com/photo/2016/08/11/23/48/pnc-park-1587285_1280.jpg",
                               width: (MediaQuery.of(context).size.width - 48) / 2 - 2,
                               height: 120.0,
                               fit: BoxFit.cover,
                             ),

                           ],
                         ),
                       ],
                     ),
                   ),

                   SizedBox(height: 36.0,),

                   Container(
                     padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Text("About", style: TextStyle(fontWeight: FontWeight.w600,)),

                         SizedBox(height: 12.0,),

                         Text(
                           """Pittsburgh is a city in the state of Pennsylvania in the United States, and is the county seat of Allegheny County. A population of about 302,407 (2018) residents live within the city limits, making it the 66th-largest city in the U.S. The metropolitan population of 2,324,743 is the largest in both the Ohio Valley and Appalachia, the second-largest in Pennsylvania (behind Philadelphia), and the 27th-largest in the U.S.\n\nPittsburgh is located in the southwest of the state, at the confluence of the Allegheny, Monongahela, and Ohio rivers. Pittsburgh is known both as "the Steel City" for its more than 300 steel-related businesses and as the "City of Bridges" for its 446 bridges. The city features 30 skyscrapers, two inclined railways, a pre-revolutionary fortification and the Point State Park at the confluence of the rivers. The city developed as a vital link of the Atlantic coast and Midwest, as the mineral-rich Allegheny Mountains made the area coveted by the French and British empires, Virginians, Whiskey Rebels, and Civil War raiders.\n\nAside from steel, Pittsburgh has led in manufacturing of aluminum, glass, shipbuilding, petroleum, foods, sports, transportation, computing, autos, and electronics. For part of the 20th century, Pittsburgh was behind only New York City and Chicago in corporate headquarters employment; it had the most U.S. stockholders per capita. Deindustrialization in the 1970s and 80s laid off area blue-collar workers as steel and other heavy industries declined, and thousands of downtown white-collar workers also lost jobs when several Pittsburgh-based companies moved out. The population dropped from a peak of 675,000 in 1950 to 370,000 in 1990. However, this rich industrial history left the area with renowned museums, medical centers, parks, research centers, and a diverse cultural district.\n\nAfter the deindustrialization of the mid-20th century, Pittsburgh has transformed into a hub for the health care, education, and technology industries. Pittsburgh is a leader in the health care sector as the home to large medical providers such as University of Pittsburgh Medical Center (UPMC). The area is home to 68 colleges and universities, including research and development leaders Carnegie Mellon University and the University of Pittsburgh. Google, Apple Inc., Bosch, Facebook, Uber, Nokia, Autodesk, Amazon, Microsoft and IBM are among 1,600 technology firms generating \$20.7 billion in annual Pittsburgh payrolls. The area has served as the long-time federal agency headquarters for cyber defense, software engineering, robotics, energy research and the nuclear navy. The nation's eighth-largest bank, eight Fortune 500 companies, and six of the top 300 U.S. law firms make their global headquarters in the area, while RAND Corporation (RAND), BNY Mellon, Nova, FedEx, Bayer, and the National Institute for Occupational Safety and Health (NIOSH) have regional bases that helped Pittsburgh become the sixth-best area for U.S. job growth.
                    """,
                           softWrap: true,
                         ),
                       ],
                     ),
                   ),

                   SizedBox(height: 24,),
                 ],
               ),


             ],
           ),
         )
     );
   }
   Widget _button(String label, IconData icon, Color color){
     return Column(
       children: <Widget>[
         Container(
           padding: const EdgeInsets.all(16.0),
           child: Icon(
             icon,
             color: Colors.white,
           ),
           decoration: BoxDecoration(
               color: color,
               shape: BoxShape.circle,
               boxShadow: [BoxShadow(
                 color: Color.fromRGBO(0, 0, 0, 0.15),
                 blurRadius: 8.0,
               )]
           ),
         ),

         SizedBox(height: 8.0,),

         Text(label,style: TextStyle(color: color),),
       ],

     );
   }

}

