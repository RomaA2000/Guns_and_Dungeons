//
//  NetLoader.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 19.12.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import UIKit

typealias ImageAdder = (Array<UIImage>) -> Void

class NetCollector {
    
    let gunsLoader : Loader
    let basesLoader : Loader
    
    init(gunsSelector : @escaping ImageAdder, basesSelector : @escaping ImageAdder) {
        self.gunsLoader = Loader(selector: gunsSelector)
        self.basesLoader = Loader(selector: basesSelector)
    }
    
    func startLoadingData(urlsGuns : [URL], urlsBases : [URL]) {
        gunsLoader.load(urls: urlsGuns)
        basesLoader.load(urls: urlsBases)
    }
}

class Loader {
    var ready : Bool = true
    var selector : (Array<UIImage>) -> Void
    
    init(selector : @escaping ImageAdder) {
        self.selector = selector
    }

    func load(urls : [URL]) -> Void {
        if (ready) {
            ready = false
                DispatchQueue.main.async { [self, urls] in
                    var array : Array<UIImage> = []
                    for i in urls {
                        if let data = try? Data(contentsOf: i) {
                            if let image = UIImage(data: data) {
                                array.append(image)
                            }
                        }
                    }
                    self.selector(array)
                    self.ready = true
                }
        }
    }
}
