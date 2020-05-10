import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:naqelapp/models/jobs/JobOfferPosts.dart';
import 'package:naqelapp/models/jobs/JobRequests.dart';
import 'package:naqelapp/utilts/DataStream.dart';
import 'package:naqelapp/utilts/UI/ScrollingText.dart';
import 'package:naqelapp/utilts/URLs.dart';
import 'package:naqelapp/utilts/UpdateDataStream.dart';
import 'package:naqelapp/models/DriverProfile.dart';
import 'package:naqelapp/styles/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naqelapp/utilts/UI/panel.dart';
import 'package:naqelapp/utilts/UI/toast_utility.dart';
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
  List<JobRequests>  jobRequests;
  List<JobOfferPosts>  jobOffers;
  int tab_postion=0;
 bool fab_visible = false;
  @override
  void initState(){
    super.initState();
    _fabHeight = _initFabHeight;
   // jobRequests=DriverProfile.getJobRequests();
    getLocation();
  }

   bool jobRequestsloaded=false;
  Future<void> loadjobRequests() async {
    final client = HttpClient();
    final request = await client.getUrl(Uri.parse(URLs.getJobRequestPackagesURL()));
    request.headers.add("Authorization", "JWT "+DataStream.token);

    final response = await request.close();
    print("Status Code: $response.statusCode");

    response.transform(utf8.decoder).listen((contents) async {

      Map<String, dynamic> jobRequestsMap = new Map<String, dynamic>.from(json.decode(contents));
      print(contents);
      if(jobRequestsMap["JobRequests"]!= null) {

        DataStream.requests =DataStream.parseRequests(jobRequestsMap["JobRequests"]);
        print(jobRequestsMap["JobRequests"]);
       jobRequests = DataStream.requests;

        print(jobRequests[0].toJsonAttr());


      }
      jobRequestsloaded=true;

      setState(() {
      });

    });
    //  permits = DriverProfile.getPermit();
  }
  bool jobOfferloaded=false;

  Future<void> loadjobOffers() async {
     final client = HttpClient();
      final res = await client.getUrl(Uri.parse(URLs.getJobOfferPostsURL()));
     res.headers.add("Authorization", "JWT "+DataStream.token);

     final response = await res.close();
     print("Status Code: $response.statusCode");
     response.transform(utf8.decoder).listen((contents) async {
       //print(contents);
       Map<String, dynamic> map = new Map<String, dynamic>.from(json.decode(contents));
       if(map["JobOfferPosts"]!= null) {
         DataStream.joboffersposts =
             DataStream.parseJobOffer(map["JobOfferPosts"]);
         // print(map["JobRequests"]);
         jobOffers = DataStream.joboffersposts;


       }
       jobOfferloaded=true;
       setState(() {

       });

     });


     /*   var data = json.decode(contents);
       var rest = data["JobOfferPosts"] as List;
       print(rest);
       list = rest.map<JobOfferPosts>((json) => JobOfferPosts.fromJson(json)).toList();

       print(list[0].jobOffer.UnloadingPlace);

     */
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


     final File markerImageFile = await DefaultCacheManager().getSingleFile(DataStream.driverProfile.PhotoURL);
   //  final File markerImageFile = await DefaultCacheManager().getSingleFile("");

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

        title: Stack(
           children: <Widget>[

            Positioned(
              right: 5,
              child: GestureDetector(
                  onTap: (){
                    UpdateTokenData(context);
                  },
                  child: Icon(Icons.sync,color: Colors.grey[700],size: 22,)),
            ),


             Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:<Widget>[
                    Text('Jobs',style: TextStyle(color: Colors.black),),

                  ]
              ),

          ],

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
                            SizedBox(height: 10.0,),
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

                            SizedBox(height: 10.0,),

                          ],
                        ),
                      ],
                    ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[

                          GestureDetector(
                        onTap: (){
                          print("Requests clicker");

                          tab_postion=1;
                          _pc.open();
                          loadjobRequests();

                          setState(() {

                          });
                        },
                        child: Column(
                        children: <Widget>[

                          Container(
                                padding: const EdgeInsets.all(16.0),
                                  child: Icon( Icons.work,color: Colors.white,),
                                 decoration: BoxDecoration(
                                 color: tab_postion==1||tab_postion==0?Colors.blue[400]:Colors.grey,
                                shape: BoxShape.circle,
                                boxShadow: [BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.15),
                                  blurRadius: 8.0,
                                )]
                              ),
                            ),

                         SizedBox(height: 8.0,),

                         Text("Requests",style: TextStyle(color: tab_postion==1||tab_postion==0?Colors.blue[600]:Colors.grey),),
                            ],

                          ),
                      ),
                          GestureDetector(
                            onTap: (){
                              print("offers clicker");
                              tab_postion=2;
                              loadjobOffers();
                              _pc.open();
                              setState(() {

                              });
                            },
                            child: Column(
                              children: <Widget>[

                                Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Icon( Icons.card_giftcard,color: Colors.white,),
                                  decoration: BoxDecoration(
                                      color: tab_postion==2||tab_postion==0?Colors.amber[500]:Colors.grey,
                                      shape: BoxShape.circle,
                                      boxShadow: [BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.15),
                                        blurRadius: 8.0,
                                      )]
                                  ),
                                ),

                                SizedBox(height: 8.0,),

                                Text("Offers",style: TextStyle(color: tab_postion==2||tab_postion==0?Colors.amber[700]:Colors.grey),),
                              ],

                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              print("on-going clicker");

                              tab_postion=3;
                              _pc.open();
                              setState(() {

                              });
                            },
                            child: Column(
                              children: <Widget>[

                                Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Icon( Icons.hourglass_full,color: Colors.white,),
                                  decoration: BoxDecoration(
                                      color:tab_postion==3||tab_postion==0?Colors.deepPurpleAccent[100]:Colors.grey,
                                      shape: BoxShape.circle,
                                      boxShadow: [BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.15),
                                        blurRadius: 8.0,
                                      )]
                                  ),
                                ),

                                SizedBox(height: 8.0,),

                                Text("On-Going",style: TextStyle(color: tab_postion==3||tab_postion==0?Colors.deepPurpleAccent[200]:Colors.grey),),
                              ],

                            ),

                          ),
                          GestureDetector(
                            onTap: (){
                              print("on-going clicker");

                              tab_postion=4;
                              _pc.open();
                              setState(() {

                              });
                            },
                            child: Column(
                              children: <Widget>[

                                Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Icon( Icons.done_all,color: Colors.white,),
                                  decoration: BoxDecoration(
                                      color:tab_postion==4||tab_postion==0?Colors.green[400]:Colors.grey,
                                      shape: BoxShape.circle,
                                      boxShadow: [BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.15),
                                        blurRadius: 8.0,
                                      )]
                                  ),
                                ),

                                SizedBox(height: 8.0,),

                                Text("Compleated",style: TextStyle(color: tab_postion==4||tab_postion==0?Colors.green[600]:Colors.grey),),
                              ],

                            ),

                          ),
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
              fab_visible=true;
              fab_icon=Icons.arrow_downward;
              if(tab_postion==0){
                tab_postion=2;
                loadjobOffers();
              }
              setState(() {

              });
             },
            onPanelClosed: (){
              fab_visible=false;

              tab_postion=0;
              fab_icon=Icons.gps_fixed;
              list_sc.jumpTo(1);
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

          Visibility(
            visible: fab_visible,
            child: Positioned(
                bottom: 15,
                right: 15,
                child:  FloatingActionButton(
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor,
                  ),
                  backgroundColor: Colors.white,
                ),
            ),
          ),
        ],
      ),


    );
  }
   Future<ui.Image> getImageFromPath() async {

    final File imageFile = await DefaultCacheManager().getSingleFile(DataStream.driverProfile.PhotoURL);

    // final File imageFile = await DefaultCacheManager().getSingleFile("");
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


  ScrollController list_sc;
   Widget _panel(ScrollController sc){
     list_sc = sc;
     return MediaQuery.removePadding(
         context: context,
         removeTop: true,
         child: Stack(
           children: <Widget>[


             // Job Requests
             tab_postion==1?
             jobRequests!=null?

                 Padding(
                 padding: EdgeInsets.fromLTRB(0, _panelHeightClosed, 0, 0),
                 child: jobRequests != null ? ListView.builder(
                     controller: list_sc,
                     itemCount: jobRequests.length,

                     itemBuilder: (BuildContext context, int index) {
                       return Padding(
                         padding: EdgeInsets.all(8),

                         child: Container(
                           decoration: BoxDecoration(
                               color: Colors.grey[100],
                               shape: BoxShape.rectangle,
                               borderRadius: new BorderRadius.only(
                                 topLeft: const Radius.circular(10.0),
                                 topRight: const Radius.circular(10.0),
                                 bottomLeft: const Radius.circular(10.0),
                                 bottomRight: const Radius.circular(10.0),
                               ),
                               boxShadow: [BoxShadow(
                                 color: Color.fromRGBO(0, 0, 0, 0.15),
                                 blurRadius: 8.0,
                               )
                               ]
                           ),
                           key: ValueKey(jobRequests[index]),
                           child:  Stack(
                                   children: <Widget>[

                                     Row(
                                           mainAxisAlignment: MainAxisAlignment
                                               .start,
                                           crossAxisAlignment: CrossAxisAlignment
                                               .start,
                                           children: <Widget>[
                                             SizedBox(width: 20),
                                             Column(
                                               mainAxisAlignment: MainAxisAlignment
                                                   .start,
                                               crossAxisAlignment: CrossAxisAlignment
                                                   .start,

                                               children: <Widget>[
                                                 SizedBox(height: 30),
                                                  Text("Loading: ",
                                                     style: TextStyle(
                                                       color: AppTheme.grey,
                                                       fontSize: 16,
                                                     ),
                                                   ),

                                                 SizedBox(height: 5),

                                                 Text("Unloading: ",
                                                     style: TextStyle(
                                                       color: AppTheme.grey,
                                                       fontSize: 16,
                                                     ),
                                                   ),

                                                 SizedBox(height: 5),

                                                 Text("Trip Type: ",
                                                     style: TextStyle(
                                                       color: AppTheme.grey,
                                                       fontSize: 16,
                                                     ),
                                                   ),


                                                 SizedBox(height: 5),
                                                 Text("Price: ",
                                                     style: TextStyle(
                                                       color: AppTheme.grey,
                                                       fontSize: 16,
                                                     ),
                                                   ),

                                                 SizedBox(height: 5),

                                                  Text("Waiting Time: ",
                                                     style: TextStyle(
                                                       color: AppTheme.grey,
                                                       fontSize: 16,
                                                     ),
                                                   ),
                                                 SizedBox(height: 30),

                                               ],),

                                             SizedBox(width: 10),

                                             Column(

                                               mainAxisAlignment: MainAxisAlignment
                                                   .start,
                                               crossAxisAlignment: CrossAxisAlignment
                                                   .start,
                                               children: <Widget>[
                                                 SizedBox(height: 30),

                                                 Text(
                                                     '${jobRequests[index].LoadingPlace}',
                                                     style: TextStyle(
                                                       fontWeight: FontWeight.w800,
                                                       color: AppTheme.grey,
                                                       fontSize: 16,
                                                     ),
                                                   ),

                                                 SizedBox(height: 5),

                                                 Text('${jobRequests[index]
                                                       .UnloadingPlace}',
                                                     style: TextStyle(
                                                       fontWeight: FontWeight.w800,
                                                       color: AppTheme.grey,
                                                       fontSize: 16,
                                                     ),
                                                   ),

                                                 SizedBox(height: 5),

                                                 Text('${jobRequests[index]
                                                       .TripType}',
                                                     style: TextStyle(
                                                       fontWeight: FontWeight.w800,
                                                       color: AppTheme.grey,
                                                       fontSize: 16,
                                                     ),
                                                   ),

                                                 SizedBox(height: 5),



                                                   Text('${jobRequests[index]
                                                       .Price}',
                                                     style: TextStyle(
                                                       fontWeight: FontWeight.w800,
                                                       color: AppTheme.grey,
                                                       fontSize: 16,
                                                     ),
                                                   ),

                                                 SizedBox(height: 5),



                                                   Text('${jobRequests[index]
                                                       .WaitingTime}',
                                                     style: TextStyle(
                                                       fontWeight: FontWeight.w800,
                                                       color: AppTheme.grey,
                                                       fontSize: 16,
                                                     ),
                                                   ),
                                                 SizedBox(height: 30),

                                               ],
                                             ),
                                           ],
                                         ),
                                     Positioned(
                                       right: -5,
                                       top: -5,
                                       child: InkWell(
                                         // When the user taps the button, show a snackbar.
                                         onTap: () {
                                           //     pr.show();
                                           deleteRequest(jobRequests[index].JobRequestID);
                                         },
                                         child: Container(
                                           padding: EdgeInsets.all(12.0),
                                           child: Column(
                                             children: <Widget>[

                                               Icon(Icons.cancel,
                                                 color: Colors.redAccent, size: 30,),
                                              // Text("Delete",style: TextStyle(color: Colors.redAccent),),
                                             ],
                                           ),
                                         ),
                                       ),
                                     ),
                                     Positioned(
                                       right: -5,
                                       bottom: -5,
                                       child: InkWell(
                                         // When the user taps the button, show a snackbar.
                                         onTap: () {
                                           //     pr.show();
                                         //  deleteRequest(jobRequests[index].JobRequestID);
                                         },
                                         child: Container(
                                           padding: EdgeInsets.all(12.0),
                                           child: Column(
                                             children: <Widget>[
                                               Icon(Icons.more_horiz,
                                                 color: Colors.black, size: 30,),
                                              // Text("More",style: TextStyle(color: Colors.redAccent),),

                                             ],
                                           ),
                                         ),
                                       ),
                                     ),

                                   ],
                                 ),

                         ),
                       );
                     }

                 ) : SizedBox(height: 1.0,),

               ):
                 jobRequestsloaded?
                 Container(
                     alignment: Alignment.center,
                     child: Text("No Job Requests found",style: TextStyle(color:Colors.blue[600]),)
                 ):
                 Container(
                     alignment: Alignment.center,
                     child: Text("Loading Requests",style: TextStyle(color:Colors.blue[600]),)
                 )
                 :
             tab_postion==2?
             jobOffers!=null?
             Padding(
               padding: EdgeInsets.fromLTRB(0, _panelHeightClosed, 0, 0),
               child: jobOffers != null ? ListView.builder(
                   controller: list_sc,
                   itemCount: jobOffers.length,

                   itemBuilder: (BuildContext context, int index) {
                     return Padding(
                       padding: EdgeInsets.all(8),

                       child: Container(
                         decoration: BoxDecoration(
                             color: Colors.grey[100],
                             shape: BoxShape.rectangle,
                             borderRadius: new BorderRadius.only(
                               topLeft: const Radius.circular(10.0),
                               topRight: const Radius.circular(10.0),
                               bottomLeft: const Radius.circular(10.0),
                               bottomRight: const Radius.circular(10.0),
                             ),
                             boxShadow: [BoxShadow(
                               color: Color.fromRGBO(0, 0, 0, 0.15),
                               blurRadius: 8.0,
                             )
                             ]
                         ),
                         key: ValueKey(jobOffers[index]),
                         child:  Stack(
                           children: <Widget>[

                             Row(
                               mainAxisAlignment: MainAxisAlignment
                                   .start,
                               crossAxisAlignment: CrossAxisAlignment
                                   .start,
                               children: <Widget>[
                                 SizedBox(width: 20),
                                 Column(
                                   mainAxisAlignment: MainAxisAlignment
                                       .start,
                                   crossAxisAlignment: CrossAxisAlignment
                                       .start,

                                   children: <Widget>[
                                     SizedBox(height: 40),
                                     Text("Posted By: ",
                                       style: TextStyle(
                                         color: AppTheme.grey,
                                         fontSize: 16,
                                       ),
                                     ),

                                     SizedBox(height: 5),

                                     Text("From: ",
                                       style: TextStyle(
                                         color: AppTheme.grey,
                                         fontSize: 16,
                                       ),
                                     ),

                                     SizedBox(height: 5),

                                     Text("To: ",
                                       style: TextStyle(
                                         color: AppTheme.grey,
                                         fontSize: 16,
                                       ),
                                     ),


                                     SizedBox(height: 5),
                                     Text("Price: ",
                                       style: TextStyle(
                                         color: AppTheme.grey,
                                         fontSize: 16,
                                       ),
                                     ),



                                   ],),

                                 SizedBox(width: 10),

                                 Column(

                                   mainAxisAlignment: MainAxisAlignment
                                       .start,
                                   crossAxisAlignment: CrossAxisAlignment
                                       .start,
                                   children: <Widget>[
                                     SizedBox(height: 40),

                                     Text(
                                       '${jobOffers[index].trader.FirstName}  ${jobOffers[index].trader.LastName}',
                                       style: TextStyle(
                                         fontWeight: FontWeight.w800,
                                         color: AppTheme.grey,
                                         fontSize: 16,
                                       ),
                                     ),

                                     SizedBox(height: 5),

                                     Text('${jobOffers[index].jobOffer.LoadingPlace}',
                                       style: TextStyle(
                                         fontWeight: FontWeight.w800,
                                         color: AppTheme.grey,
                                         fontSize: 16,
                                       ),
                                     ),

                                     SizedBox(height: 5),

                                     Text('${jobOffers[index].jobOffer
                                         .UnloadingPlace}',
                                       style: TextStyle(
                                         fontWeight: FontWeight.w800,
                                         color: AppTheme.grey,
                                         fontSize: 16,
                                       ),
                                     ),

                                     SizedBox(height: 5),



                                     Text('${jobOffers[index].jobOffer
                                         .Price}',
                                       style: TextStyle(
                                         fontWeight: FontWeight.w800,
                                         color: AppTheme.grey,
                                         fontSize: 16,
                                       ),
                                     ),


                                     SizedBox(height: 40),

                                   ],
                                 ),
                               ],
                             ),
                             Positioned(
                               right: -5,
                               top: -5,
                               child: InkWell(
                                 // When the user taps the button, show a snackbar.
                                 onTap: () {
                                   //     pr.show();
                               //    deleteRequest(jobOffers[index].JobRequestID);
                                 },
                                 child: Container(
                                   padding: EdgeInsets.all(12.0),
                                   child: Column(
                                     children: <Widget>[

                                       Icon(Icons.cancel,
                                         color: Colors.redAccent, size: 30,),
                                        Text("Cancel",style: TextStyle(color: Colors.redAccent),),
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                             Positioned(
                               right: -1,
                               bottom: -5,
                               child: InkWell(
                                 // When the user taps the button, show a snackbar.
                                 onTap: () {
                                   //     pr.show();
                                //   deleteRequest(jobRequests[index].JobRequestID);
                                 },
                                 child: Container(
                                   padding: EdgeInsets.all(12.0),
                                   child: Column(
                                     children: <Widget>[
                                       Icon(Icons.more_horiz,
                                         color: Colors.black, size: 30,),
                                         Text("More",style: TextStyle(color: Colors.black),),

                                     ],
                                   ),
                                 ),
                               ),
                             ),

                           ],
                         ),

                       ),
                     );
                   }

               ) : SizedBox(height: 1.0,),

             ):
             jobRequestsloaded?
             Container(
                 alignment: Alignment.center,
                 child: Text("No Job Offers found",style: TextStyle(color:Colors.amber[700]),)
             ):
             //jobOfferloaded
             Container(
                 alignment: Alignment.center,
                 child:  Text("Loading Offers",style: TextStyle(color:Colors.amber[700]),)
             ):tab_postion==3?
             Container(
                 alignment: Alignment.center,
                 child: Text("Loading On-Going",style: TextStyle(color: Colors.deepPurpleAccent[200]),),
             ):
             Container(
               alignment: Alignment.center,
               child: Text("Loading Compleated Jobs",style: TextStyle(color: Colors.green[600]),),
             )


             // Job Offers

           ],

         )
     );
   }

  Future<void> deleteRequest(int jobRequestID) async {
    print("Deleting Request $jobRequestID");

    final client = HttpClient();
    final request = await client.deleteUrl(Uri.parse(URLs.deleteDriverRequestURL()));
    request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    request.headers.add("Authorization", "JWT "+DataStream.token);


    //   request.write('{"Token": "'+DriverProfile.getUserToken()+'","PermitLicenceID": "$permitLicenceID"}');
    request.write('{"JobRequestID": "$jobRequestID"}');

    final response = await request.close();
    print("Status Code: $response.statusCode");

    response.transform(utf8.decoder).listen((contents) async {
      print(contents);

      Map<String, dynamic> updateMap = new Map<String, dynamic>.from(json.decode(contents));

      setState(() {
        loadjobRequests();

      });


    });
  }


}

