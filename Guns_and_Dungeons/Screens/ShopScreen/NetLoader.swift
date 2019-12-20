//
//  NetLoader.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 19.12.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import UIKit

class NetCollector {
    
    let gunsLoader : Loader = Loader()
    let basesLoader : Loader = Loader()
    
    func startLoadingData(urlsGuns : [URL], urlsBases : [URL]) {
        gunsLoader.load(urls: urlsGuns)
        basesLoader.load(urls: urlsBases)
    }
    
    func getInfo() -> (Array<UIImage>, Array<UIImage>)? {
        if (gunsLoader.ready && basesLoader.ready) {
            return (gunsLoader.array, basesLoader.array)
        }
        return nil;
    }
}

class Loader {
    
    var array : Array<UIImage> = []
    var ready : Bool = true
    
    func load(urls : [URL]) {
        if (ready) {
            array.removeAll()
            ready = false
                DispatchQueue.main.async { [self, urls] in
                    for i in urls {
                        if let data = try? Data(contentsOf: i) {
                            if let image = UIImage(data: data) {
                                self.array.append(image)
                            }
                        }
                    }
                    self.ready = true
                }
            
        }
    }
}
