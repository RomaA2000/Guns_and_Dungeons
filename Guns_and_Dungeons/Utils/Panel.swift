//
//  Panel.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 15.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation
import UIKit


class Panel<Element : PanelSubview>: UIView {
    var buttons: [Element] = []
    
    init(panelArgs: PanelInformation) {
        super.init(frame: panelArgs.panelFrame)
        for buttonNumber in panelArgs.numerator..<panelArgs.numerator + 4 {
            let button = Element(frame : CGRect(), num: buttonNumber)
            self.posSubviewByRect(subView: button, params: panelArgs.cordinates[buttonNumber % 4])
            buttons.append(button)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
