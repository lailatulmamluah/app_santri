import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 11, 151, 93)),
      ),
      home: const MyHomePage(title: 'Beranda'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 151, 93),
        
        title: Text(widget.title, style: TextStyle(
          color: Colors.white),
        ),
      ),
      body: Center(
        
        child: Column(
          
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 40,),
            const Text('Sistem Informasi e_santri', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Container(
              alignment: Alignment.center,
              width: 200,
              height: 200,
              margin: const EdgeInsets.only(top: 20, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromARGB(255, 11, 151, 93),

              ),
              child: const Text(
                "Mencoba",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
