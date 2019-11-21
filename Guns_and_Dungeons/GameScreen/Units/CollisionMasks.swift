//
//  CollisinMasks.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 20.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation

struct CategoryMask {
    static let player: UInt32 = 0x1 << 1
    static let bullet: UInt32 = 0x1 << 2
    static let wall:   UInt32 = 0x1 << 3
    static let enemy:  UInt32 = 0x1 << 4
}

// убрать, сделать структуру из трех три маски параметрами конструктора AnimatedUnit
