//
//  CollisinMasks.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 20.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation

struct CategoryMask {
    static let player: UInt32 = 1 << 1
    static let bullet: UInt32 = 1 << 2
    static let wall: UInt32 = 1 << 3
    static let ai: UInt32 = 1 << 4
}


class PhysicsBodyMask {
    let category : UInt32
    let contact : UInt32
    let collision : UInt32
    init(category : UInt32, collision : UInt32, contact : UInt32) {
        self.category = category
        self.collision = collision
        self.contact = contact
    }
}

func physicsBodyMaker(categoryShift : UInt32, collisionShift : UInt32, contactShift : UInt32) -> PhysicsBodyMask {
    return PhysicsBodyMask(category: 1 << categoryShift, collision: 1 << collisionShift, contact: 1 << contactShift);
}
