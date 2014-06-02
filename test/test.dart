import 'package:libld/libld.dart';
import 'dart:html';



main(){
  textExtensions.add('poo');
  jsonExtensions.add('street');

  List <Asset> assets = 
      [
new Asset('./mention.ogg'),
new Asset('./jsontext.json'),
new Asset('./groddle.street'),
new Asset('./text.txt')
       ];
 
  new Batch(assets).load(print) //load all the assets, printing progress after each file.
    ..then((_) {
      doneLoading(); // When they are all loaded, run doneLoading.
    }); 
}


doneLoading() {
  print(ASSET['text'] is Asset); // text.txt is referenced by an Asset object
  print(ASSET['text'].get() is String); // Use the asset's payload with .get()
  
  AudioElement m = ASSET['mention'].get(); // getting an audioElement
  m.volume = 1.0;
  m.play();// doesn't play?
  
}