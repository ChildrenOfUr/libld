import 'package:loadie/loadie.dart';
import 'dart:html';




main(){
  textExtensions.add('poo');
  jsonExtensions.add('street');
  
  // this ogg file is played aloud
  Asset soundfile = new Asset('./mention.ogg')
  ..load()
    .then((Asset e) => e.get().play());
  
  // the contents of this file become a String
  Asset textfile = new Asset('./text.txt')
    ..load()
    .then((Asset e) => print(e.get()));
  
  // the contents of this file become a String, ala 'textExtensions.add('poo');'
  Asset poofile = new Asset('./text.poo')
    ..load()
    .then((Asset e) => print(e.get()));
  
  // the contents of this file become a map.
  Asset jsonfile = new Asset('./jsontext.json')
  ..load()
    .then((Asset e) => print(e.get()['A']));
  
  // the contents of this file become a map.
  Asset streetfile = new Asset('./groddle.street')
  ..load()
    .then((Asset e) => print(e.get()['label']));
  
  // this file is drawn on a tiny canvas
  Asset svgfile = new Asset('./currant.svg')
  ..load()
    .then((Asset e) 
        {
      print(e.get().runtimeType);
      CanvasElement c = querySelector('canvas');
      c.context2D.drawImage(e.get(), 0, 0);      
        }
    );
  

  
  
}