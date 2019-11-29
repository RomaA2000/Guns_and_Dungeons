//
//  ArgumentsClasses.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 15.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import UIKit
import SpriteKit


class MarnginsInformation {
    var marginStart: CGFloat
    var marginMiddle: CGFloat
    var panelWidth: CGFloat
    init(marginStart : CGFloat, marginMiddle : CGFloat, panelWidth : CGFloat) {
        self.marginStart = marginStart
        self.marginMiddle = marginMiddle
        self.panelWidth = panelWidth
    }
    init() {
        marginStart =  0
        marginMiddle = 0
        panelWidth =  0
    }
}

