//
//  NetLoader.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 19.12.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import UIKit

typealias ImageAdder = (UIImage, Int) -> Void

class NetCollector {
    
    let gunsSelector : ImageAdder
    let basesSelector : ImageAdder
    
    init(gunsSelector : @escaping ImageAdder, basesSelector : @escaping ImageAdder) {
        self.gunsSelector = gunsSelector
        self.basesSelector = basesSelector
    }
    
    func startLoadingData(urlsGunsPos : [(URL, Int)], urlsBasesPos : [(URL, Int)]) {
        for i in urlsGunsPos {
            loadImage(url: i.0, index: i.1, selector: gunsSelector)
        }
        for i in urlsBasesPos {
            loadImage(url: i.0, index: i.1, selector: basesSelector)
        }
    }
}

func loadImage(url: URL, index: Int, selector: @escaping ImageAdder) {
    DispatchQueue.main.async{[selector, url, index] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                        selector(image, index)
                }
            }
            
    }
}

