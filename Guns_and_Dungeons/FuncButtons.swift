//
//  File.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 18.10.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation
import UIKit

class SizeParameters {
    var k : CGFloat = CGFloat()
    var square : CGFloat = CGFloat()
    init(k : CGFloat, square : CGFloat) {
        self.k = k;
        self.square = square;
    }
}

class AllParameters : SizeParameters {
    var centerPoint : CGPoint = CGPoint()
    init(centerPoint : CGPoint, k : CGFloat, square : CGFloat) {
        super.init(k : k, square : square)
        self.centerPoint = centerPoint
    }
}

extension UIButton {
    func setUpButton(label: String, color : UIColor, translatesMask : Bool) {
        self.setTitle(label, for: .normal)
        self.setTitleColor(UIColor.gray, for: .highlighted)
        self.translatesAutoresizingMaskIntoConstraints = translatesMask
        self.backgroundColor = color
    }
}
