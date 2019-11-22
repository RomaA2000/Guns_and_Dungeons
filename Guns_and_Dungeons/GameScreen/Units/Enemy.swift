//
//  ContactEnemy.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 15.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import SpriteKit

class Enemy : MobileUnit {
    var purviewRange: Int = 0
    
    init(params: EnemyParams) {
        purviewRange = params.purviewRange
        super.init(params: params.mobileUnitParams)
        name = "enemy"
        physicsBody = SKPhysicsBody(circleOfRadius: self.defaultTexture.size().width / 2)
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = CategoryMask.ai
        physicsBody?.collisionBitMask = CategoryMask.player
        physicsBody?.contactTestBitMask = CategoryMask.ai | CategoryMask.player
        runDefaultAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class EnemyParams {
    var mobileUnitParams: MobileUnitParams
    var purviewRange: Int;
    
    init(mobileUnitParams: MobileUnitParams, purvewRange: Int) {
        self.mobileUnitParams = mobileUnitParams
        self.purviewRange = purvewRange
    }
}
