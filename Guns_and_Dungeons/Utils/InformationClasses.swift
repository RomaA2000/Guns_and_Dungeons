//
//  ArgumentsClasses.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 15.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import UIKit
import SpriteKit

class PanelInformation {
    var cordinates : [AllParameters]
    var numerator: Int
    var panelFrame: CGRect
    init(frame: CGRect, x_list : [CGFloat], y_list : [CGFloat], k : CGFloat, s : CGFloat) {
        cordinates = []
        panelFrame = frame
        for i in y_list {
            for j in x_list {
                cordinates.append(AllParameters(centerPoint: CGPoint(x: j, y: i), k: k, square: s))
            }
        }
        numerator = 0
    }
}

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

