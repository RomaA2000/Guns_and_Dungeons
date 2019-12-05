//
//  UIIndicator.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 02.12.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import UIKit

class UIIndicator: UIImageView {
    
    var imageOn: UIImage?
    var imageOff: UIImage?
    var state: Bool = true
    
    init(frame: CGRect, imageOn: UIImage?, imageOff: UIImage?) {
        self.imageOn = imageOn
        self.imageOff = imageOff
        super.init(frame: frame)
        self.image = imageOn
    }
    
    func switchToOn() {
        state = true
        self.image = imageOn
    }
    
    func switchToOff() {
        state = false
        self.image = imageOff
    }
    
    func switchState(toState: Bool) {
        if (toState) {
            switchToOn()
        }
        else {
            switchToOff()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

