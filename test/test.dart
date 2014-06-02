import 'package:libld/libld.dart';


main(){
  textExtensions.add('poo');
  jsonExtensions.add('street');

  List <Asset> assets = 
      [
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
  
  new Asset('mention.ogg').load()
    .then((_) {
      ASSET['mention'].get().play(); // Should play audio...
    });

}