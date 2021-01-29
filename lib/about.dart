import 'package:flutter/material.dart';

class Platform extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
      ThemeData(
        primaryColor: Color.fromRGBO(240, 151, 38, 1),
      ),

      home: About(),
    );
  }
}

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us',style: TextStyle(color:Colors.white),),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Center(child: Container(
            child: SingleChildScrollView(
              reverse: false,
              child: Column(
                children: <Widget>[
                  Text("Gham Power Nepal Private Limited is a renewable-energy focused social enterprise based in Kathmandu, Nepal. Founded in 2010 by Sandeep Giri, a start-up veteran and co-founder of Logical Matrix (later acquired by Oracle), our initial goals were focused on reducing the burden that excessive power outages (as high as 16 hours a day in dry seasons) posed on Nepal’s urban population. Having installed over 2500 solar projects that cumulatively generate 2.5 MW of electricity, Gham played its part in urban electrification and soon after shifted focus to under-served rural markets by 2013.",style:TextStyle(color: Color.fromRGBO(240, 151, 38, 1),fontSize:22)),
                  const SizedBox(height: 20,),
                  Text("We have partnered with various multinational agencies and local government entities in this duration to pioneer products that increase energy uptake among the rural population. We are also the first enterprise to install Microgrid in rural Nepal; the first energy enterprise in Nepal to adopt PAYG schemes; and during 2015’s massive earthquake that killed more than 10,000 with a substantial incidence in rural areas, we were one of the first corporate responders with low-cost, portable mobile charging and lighting devices. For our many endeavors, we have been extensively featured by the international media and have been awarded several accolades, lately the Frontier Innovators prize.",style:TextStyle(color: Color.fromRGBO(240, 151, 38, 1),fontSize:22)),
                ],
              ),
            ),
          )),
          Positioned.fill(
            child: Image.asset('assets/bottom.png',
              fit: BoxFit.fitWidth,alignment: Alignment.bottomCenter,
            ),
          ),
        ],
      ),
    );
  }
}


