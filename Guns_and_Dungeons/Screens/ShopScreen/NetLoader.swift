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
    
    func startLoadingData(urlsGuns : [URL], gunsUpdater : Selector, urlsBases : [URL], basesUpdater : Selector) {
        gunsLoader.load(urls: urlsGuns, selector : gunsUpdater)
        basesLoader.load(urls: urlsBases, selector: basesUpdater)
    }
}

class Loader {

    var array : Array<UIImage> = []
    var ready : Bool = true
    func load(urls : [URL], selector : Selector) -> Void {
        if (ready) {
            array.removeAll()
                DispatchQueue.main.async { [self, urls] in
                    for i in urls {
                        if let data = try? Data(contentsOf: i) {
                            if let image = UIImage(data: data) {
                                self.array.append(image)
                            }
                        }
                    }
            }
        }
    }
}
