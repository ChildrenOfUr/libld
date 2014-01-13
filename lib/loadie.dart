library loadie;
import 'dart:async';
import 'dart:html';
import 'dart:convert';


Map <String,Asset> ASSET = {};


// add extentions to this list to allow the loading of non-standard text files.
List <String> textExtensions = 
[
 'txt'
];

// add extentions to this list to allow the loading of non-standard json files.
List <String> jsonExtensions = 
[
 'json'
];

// image extentions cannot be changed, because they have to be embedded into an <img> tag.
// Browsers will not render custom file formats 
final List <String> imageExtensions = 
[
 'svg',
 'png',
 'jpg',
 'jpeg',
 'gif',
 'bmp'
];

// audio extentions cannot be changed, because they have to be embedded into an <audio> tag.
// Browsers will not play custom audio formats 
final List <String> audioExtensions = 
[
 'mp3',
 'ogg'
];



// a helper class for loading bars and such.
// the callback function will be provided with the percent of the batch that is loaded.
class Batch {
  List <Asset> _toLoad = [];
  num _percentDone = 0;
  
  Batch(this._toLoad);
  Future<List <Asset> > load(Function callback){
    num percentEach = 100/_toLoad.length; 
   
    // creates a list of Futures
    List <Future> futures = [];
    for (Asset asset in _toLoad)
       {
     futures.add(asset.load().whenComplete((){
       // Broadcast that we loaded a file.
       _percentDone += percentEach;
       callback(_percentDone.floor());}
     ));
       }     
  
    return Future.wait(futures);
  }
}



class Asset{
  var _asset;
  bool loaded = false;
  String _uri;
  
  String name;
  
  Asset(String uri){this._uri = uri;}
  
  Future <Asset> load(){
    name = _uri.split('/')[_uri.split('/').length - 1].split('.')[0];
    Completer c = new Completer();    
    if (loaded == false){

      bool loading = false;
      
      // loads ImageElements into memory
      for (String ext in imageExtensions)
      {
        if (_uri.endsWith('.' + ext))
        {
          this._asset = new ImageElement()
          ..src = _uri;
          loading = true;
          _asset.onLoad.listen((_) {
            ASSET[name] = this;
            loaded = true;
            c.complete(this);
            });
        }
      }
      if (loading == true)
        return c.future;
      
      // loads AudioElements into memory
      for (String ext in audioExtensions)
      {
        if (_uri.endsWith('.' + ext))
        {
          AudioElement audio = new AudioElement()
          ..src = _uri;
          loading = true;
          audio.onError.listen((Event err) {
            print('Error in loading Audio : $_uri');
            c.complete(null);
          });
          audio.onCanPlayThrough.listen((_) {
            ASSET[name] = this;
            this._asset= audio;
            loaded = true;
            c.complete(this);});
        }
      }
      if (loading == true)
        return c.future;
      
      // loads simple text files as a string.
      for (String ext in textExtensions)
      {
        if (_uri.endsWith('.' + ext))
        {
          loading = true;
          Future request = HttpRequest.getString(_uri).then
          ((String string)  {
            _asset = string;
            loaded = true;
            ASSET[name] = this;
            });
          c.complete(request);
        }
      }
      if (loading == true)
        return c.future;
      
      // Returns a decoded object from a json file
      for (String ext in jsonExtensions)
      {
        if (_uri.endsWith('.' + ext))
        {
          loading = true;
          HttpRequest.getString(_uri).then
          ((String string)  {
            ASSET[name] = this;
            _asset =  JSON.decode(string);
            loaded = true;
            c.complete(this);
            });
        }
      }
      if (loading == true)
       return c.future;
      else 
        throw('nothing is being loaded!');
    }
  }  

  
  get(){
    if (loaded == false)
      throw('Asset not yet loaded!');
    else
    return _asset;
  }
}