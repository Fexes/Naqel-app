
import 'package:flutter/material.dart';
import 'package:naqelapp/session/Permit.dart';
import 'package:naqelapp/session/Userprofile.dart';
import 'package:naqelapp/styles/app_theme.dart';
import 'package:naqelapp/utilts/custom_dialogue.dart';

class PermitPage extends StatefulWidget  {


  const PermitPage({Key key}) : super(key: key);



  @override
  _PermitPageState createState() => _PermitPageState();
}

class _PermitPageState extends State<PermitPage>  {

  List<Permit>  permits;


  @override
  void initState() {
    super.initState();

    loadData();
  }
  @override
  void dispose() {
    super.dispose();
  }

  void loadData() {

    permits = Userprofile.getPermit();
  }
  TextEditingController _numbernumbertextFieldController = TextEditingController();
  TextEditingController _ExpirytextFieldController = TextEditingController();
  TextEditingController _CodetextFieldController = TextEditingController();
  TextEditingController _PlacetextFieldController = TextEditingController();

   _displayDialog(BuildContext context) {
     Dialog dialog= Dialog(
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(60),
       ),
       elevation: 0.0,
       backgroundColor: Colors.transparent,
       child: dialogContent(context),
     );

     showDialog(context: context, builder: (BuildContext context) => dialog);

}

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 90.0+ 16.0,
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          margin: EdgeInsets.only(top: 90.0),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                "Success",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // To close the dialog
                  },
                  child: Text("OK"),
                ),
              ),
            ],
          ),
        ),

        Positioned(
          left: 16.0,
          right: 16.0,
          child: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: 90.0,
          ),
        ),
      ],
    );


  }

  @override
  Widget build(BuildContext context) {

    return Align(

      child: SafeArea(

        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,

            title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                  Text('Permits',style: TextStyle(color: Colors.black),),
                ]
            ),
          ),
          backgroundColor: Color(0xffF7F7F7),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[

              const SizedBox(
                height: 30,
              ),
              permits!=null? Container(
                  height:(MediaQuery.of(context).size.height)-110,
                  width: MediaQuery.of(context).size.width,
                  child:
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: permits.length,

                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          key: ValueKey(permits[index]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,


                            children: <Widget>[

                              Row(

                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,


                                children: <Widget>[

                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                    child: Container(
                                      height: 95,
                                      width: 95,
                                      decoration: BoxDecoration(

                                        shape: BoxShape.rectangle,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: AppTheme.grey.withOpacity(0.6),
                                              offset: const Offset(2.0, 4.0),
                                              blurRadius: 8),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(8)),
                                        child: Image.network(permits[index].PhotoURL,fit: BoxFit.cover),
                                      ),

                                    ),
                                  ),
                                  SizedBox(width: 20),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[

                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                        children: <Widget>[
                                          Padding(

                                            padding: const EdgeInsets.only(top: 0, left: 0),
                                            child: Text("Permit Number: ",
                                              style: TextStyle(
                                                color: AppTheme.grey,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5),

                                          Padding(
                                            padding: const EdgeInsets.only(top: 0, left: 0),
                                            child: Text("Permit Code: ",
                                              style: TextStyle(
                                                color: AppTheme.grey,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5),

                                          Padding(
                                            padding: const EdgeInsets.only(top: 0, left: 0),
                                            child: Text("Permit Place: ",
                                              style: TextStyle(
                                                color: AppTheme.grey,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],),

                                      SizedBox(width: 10),

                                      Column(

                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(top: 0, left: 0),
                                            child: Text('${permits[index].PermitNumber}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                color: AppTheme.grey,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5),

                                          Padding(
                                            padding: const EdgeInsets.only(top: 0, left: 0),
                                            child: Text('${permits[index].Code}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                color: AppTheme.grey,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5),

                                          Padding(
                                            padding: const EdgeInsets.only(top: 0, left: 0),
                                            child: Text('${permits[index].Place}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                color: AppTheme.grey,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Container(
                                 child :FloatingActionButton(

                                  onPressed: (){

                                    _displayDialog(context);
                                  },
                                  backgroundColor: Colors.black,
                                  child: Icon(Icons.add),
                                )

                              ),

                            ],
                          ),

                        );
                      }
                  )


              )  :Container(
                  child: FloatingActionButton(

                    onPressed: (){
                      _displayDialog(context);
                    },
                    backgroundColor: Colors.black,
                    child: Icon(Icons.add),
                  )
              ),



            ],
          )

        ),
      ),
    );
  }




}

