libld
======

a simple asset loader for Children of Ur, works with other projects too!

Loading a single asset:

    Asset textAsset = new Asset('some_text.txt');
    assert(textAsset is Asset); // true
    // Assets aren't very useful on their own.
    
    assert(textAsset.get() is String); // true 
    // However the contents of an Asset can be.
    
    print(textAsset.get()); // prints the text that was in the file.
    
The ASSET object:

    //All assets are stored in a global ASSET object, and indexed by their filename.
    assert(Asset['some_text'] is Asset); // true
    
Loading multiple assets in a Batch:

    Batch assetBatch = new Batch([new Asset('url1.txt'), new Asset('url2.txt'), ...]);
    assetBatch.load(callback); // Actually loads each asset into memory,
    //sending a number between 1-100 to the callback.
