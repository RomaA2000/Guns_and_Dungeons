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
    let session : URLSession
    let gunsSelector : ImageAdder
    let basesSelector : ImageAdder
    init(gunsSelector : @escaping ImageAdder, basesSelector : @escaping ImageAdder) {
        self.gunsSelector = gunsSelector
        self.basesSelector = basesSelector
        self.session = URLSession(configuration: .default)
    }
    
    func startLoadingData(urlsGunsPos : [(URL, Int)], urlsBasesPos : [(URL, Int)]) {
        for i in urlsGunsPos {
            loadImage(url: i.0, index: i.1, selector: gunsSelector, session: session)
        }
        for i in urlsBasesPos {
            loadImage(url: i.0, index: i.1, selector: basesSelector, session: session)
        }
    }
}

func loadImage(url: URL, index: Int, selector: @escaping ImageAdder, session: URLSession) {
        let handler = {(data: Data?, response: URLResponse?, error: Error?) -> Void in
            DispatchQueue.main.async{[selector, index] in
                    if let dataUnwrapped = data {
                        if let image = UIImage(data: dataUnwrapped) {
                            selector(image, index)
                        }
                    }
                }
        }
        let task = session.dataTask(with: url, completionHandler: handler)
        task.resume()
}
