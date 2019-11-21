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
        physicsBody = SKPhysicsBody(circleOfRadius: self.animation.defaultTexture.size().width / 2)
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.categoryBitMask = CategoryMask.player
        physicsBody?.collisionBitMask = CategoryMask.enemy | CategoryMask.wall
        physicsBody?.contactTestBitMask = CategoryMask.enemy | CategoryMask.player
        runDefaultAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PlayerParams {
    var mobileUnitParams: MobileUnitParams
    init(mobileUnitParams: MobileUnitParams) {
        self.mobileUnitParams = mobileUnitParams
    }
}

