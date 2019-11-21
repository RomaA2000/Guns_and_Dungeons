//
//  Player.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 15.11.2019.
//  Copyright © 2019 Александр Потапов. All rights reserved.
//

import Foundation
import SpriteKit

class Player: MobileUnit {
    init(params: PlayerParams) {
        super.init(params: params.mobileUnitParams)
        name = "player"
        physicsBody = params.body
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.categoryBitMask = params.mask.category
        physicsBody?.collisionBitMask = params.mask.collision
        physicsBody?.contactTestBitMask = params.mask.contact
        runDefaultAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PlayerParams {
    let mobileUnitParams: MobileUnitParams
    let mask: PhysicsBodyMask
    let body : SKPhysicsBody;

    init(mobileUnitParams: MobileUnitParams, mask : PhysicsBodyMask, body : SKPhysicsBody) {
        self.mobileUnitParams = mobileUnitParams
        self.mask = mask
        self.body = body
    }
    
    convenience init(mobileUnitParams: MobileUnitParams, mask : PhysicsBodyMask, radius: CGFloat) {
        self.init(mobileUnitParams: mobileUnitParams, mask: mask, body: SKPhysicsBody(circleOfRadius: radius))
    }
}

