library loadie;
import 'dart:async';
import 'dart:html';
import 'dart:convert';

// add extentions to this list to allow the loading of non-standard text files.
List <String> textExtentions = 
[
 'txt'
];

// add extentions to this list to allow the loading of non-standard json files.
List <String> jsonExtentions = 
[
 'json'
];

// image extentions cannot be changed.
final List <String> imageExtentions = 
[
 'svg',
 'png',
 'jpg',
 'jpeg',
 'gif',
 'bmp'
];


class Asset{
  var _asset;
  bool loaded = false;
  String uri;
  
  Asset(this.uri){}
  
  Future load(){
    Completer c = new Completer();
    if (loaded == false){

      // loads images into dom
      for (String ext in imageExtentions)
      {
        if (uri.endsWith('.' + ext))
        {
          ImageElement _asset = new ImageElement()
          ..src = uri;
          _asset.onLoad.listen((_) {loaded = true;c.complete(this);});
        }
      }
      
      // loads simple text files as a string.
      for (String ext in textExtentions)
      {
        if (uri.endsWith('.' + ext))
        {
          HttpRequest.getString(uri).then
          ((String string)  {
            _asset = string;
            loaded = true;
            c.complete(this);
            });
        }
      }
      
      // Returns a decoded object from a json file
      for (String ext in jsonExtentions)
      {
        if (uri.endsWith('.' + ext))
        {
          HttpRequest.getString(uri).then
          ((String string)  {
            _asset =  JSON.decode(string);
            loaded = true;
            c.complete(this);
            });
        }
      }
      

      return c.future;
    }
  
  }  

  
  get(){
    if (loaded == false)
      throw('Asset not yet loaded!');
    else
    return _asset;
  }
}