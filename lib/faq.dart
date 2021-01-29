import 'package:flutter/material.dart';
class Platform extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
      ThemeData(
        primaryColor: Color.fromRGBO(240, 151, 38, 1),
      ),

      home: Faq(),
    );
  }
}


class Faq extends StatefulWidget {
  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends State<Faq> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ',style: TextStyle(color:Colors.white),),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body:Center(
        child: Container(
          child: ListView(
            padding: EdgeInsets.all(8.0),
            children: <Widget>[
              Card(
                child: ExpansionTile(
                  title: Wrap(
                    alignment: WrapAlignment.end,

                    children: <Widget>[
                      new RichText(
                        text: new TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            new TextSpan(text: 'Q. ', style: new TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(240, 151, 38, 1),fontSize: 20)),
                            new TextSpan(text: 'Can we enter data even when device is not connected to internet?',style: TextStyle(fontSize: 20,color: Color.fromRGBO(240, 151, 38, 1))),
                          ],
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0,left: 20,top: 8,bottom: 8),
                      child: new RichText(
                        text: new TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            new TextSpan(text: 'Ans. ', style: new TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(240, 151, 38, 1),fontSize: 20)),
                            new TextSpan(text: 'Yes, you can insert data even if your device is not connected to an internet.',style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      )
                    )
                  ],
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: Wrap(
                    alignment: WrapAlignment.end,

                    children: <Widget>[
                      new RichText(
                        textAlign: TextAlign.left,

                        text: new TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: new TextStyle(

                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            new TextSpan(text: 'Q. ', style: new TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(240, 151, 38, 1),fontSize: 20)),
                            new TextSpan(text: 'Do we need to manually send data to remote server when online?',style: TextStyle(fontSize: 20,color: Color.fromRGBO(240, 151, 38, 1))),
                          ],
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(right: 20.0,left: 20,top: 8,bottom: 8),
                        child: new RichText(
                          text: new TextSpan(
                            // Note: Styles for TextSpans must be explicitly defined.
                            // Child text spans will inherit styles from parent
                            style: new TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              new TextSpan(text: 'Ans. ', style: new TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(240, 151, 38, 1),fontSize: 20)),
                              new TextSpan(text: 'No, syncing data is automatic process.When your device gets connected to an internet connection, the app will automatically sync all data.',style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        )
                    )
                  ],
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: Wrap(
                    alignment: WrapAlignment.end,

                    children: <Widget>[
                      new RichText(
                        textAlign: TextAlign.left,

                        text: new TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            new TextSpan(text: 'Q. ', style: new TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(240, 151, 38, 1),fontSize: 20)),
                            new TextSpan(text: 'Is it compulsory to add image of a farmer?',style: TextStyle(fontSize: 20,color: Color.fromRGBO(240, 151, 38, 1))),
                          ],
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(right: 20.0,left: 20,top: 8,bottom: 8),
                        child: new RichText(
                          text: new TextSpan(
                            // Note: Styles for TextSpans must be explicitly defined.
                            // Child text spans will inherit styles from parent
                            style: new TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              new TextSpan(text: 'Ans. ', style: new TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(240, 151, 38, 1),fontSize: 20)),
                              new TextSpan(text: 'No, adding image is not compulsory.',style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        )
                    )
                  ],
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: Wrap(
                    alignment: WrapAlignment.end,

                    children: <Widget>[
                      new RichText(
                        textAlign: TextAlign.left,

                        text: new TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            new TextSpan(text: 'Q. ', style: new TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(240, 151, 38, 1),fontSize: 20)),
                            new TextSpan(text: 'How can we search farmers data from app?',style: TextStyle(fontSize: 20,color: Color.fromRGBO(240, 151, 38, 1))),
                          ],
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(right: 20.0,left: 20,top: 8,bottom: 8),
                        child: new RichText(
                          textAlign: TextAlign.left,
                          text: new TextSpan(
                            // Note: Styles for TextSpans must be explicitly defined.
                            // Child text spans will inherit styles from parent
                            style: new TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              new TextSpan(text: 'Ans. ', style: new TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(240, 151, 38, 1),fontSize: 20)),
                              new TextSpan(text: 'You can enter the name of the farmer in the search bar and app shows all the matching result as precisely as possible.',style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        )
                    )
                  ],
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: Wrap(
                    alignment: WrapAlignment.end,

                    children: <Widget>[
                      new RichText(
                        textAlign: TextAlign.left,

                        text: new TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            new TextSpan(text: 'Q. ', style: new TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(240, 151, 38, 1),fontSize: 20)),
                            new TextSpan(text: 'Can we update the survey data of a farmer?',style: TextStyle(fontSize: 20,color: Color.fromRGBO(240, 151, 38, 1))),
                          ],
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(right: 20.0,left: 20,top: 8,bottom: 8),
                        child: new RichText(
                          text: new TextSpan(
                            // Note: Styles for TextSpans must be explicitly defined.
                            // Child text spans will inherit styles from parent
                            style: new TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              new TextSpan(text: 'Ans. ', style: new TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(240, 151, 38, 1),fontSize: 20)),
                              new TextSpan(text: 'Yes, you can update the data of farmer by clicking on the farmer profile and selecting edit option below',style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        )
                    )
                  ],
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}


