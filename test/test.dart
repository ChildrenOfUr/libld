import 'package:loadie/loadie.dart';




main(){
  textExtensions.add('poo');
  jsonExtensions.add('street');

  List <Asset> assets = 
      [
new Asset('./mention.ogg'),
new Asset('./text.txt'),
new Asset('./jsontext.json'),
new Asset('./groddle.street'),
new Asset('./currant.svg')
       ];
  
  Batch b = new Batch(assets)
  ..load(print).then((assets) => ASSET['mention'].get().play());
}

