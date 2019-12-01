//
//  File.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 18.10.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func setUpButton(label: String, color : UIColor, translatesMask : Bool) {
        self.setTitle(label, for: .normal)
//        self.addTarget(target, action: action, for: .touchUpInside)
        self.setTitleColor(UIColor.gray, for: .highlighted)
        self.translatesAutoresizingMaskIntoConstraints = translatesMask
        self.backgroundColor = color
    }
}
