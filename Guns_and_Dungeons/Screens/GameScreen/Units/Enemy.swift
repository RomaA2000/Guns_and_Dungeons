//
//  ContactEnemy.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 15.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//
import SpriteKit

class Enemy : MobileUnit {
    var purviewRange: Int = 0
    
    init(params: EnemyParams) {
        purviewRange = params.purviewRange
        super.init(params: params)
        name = "enemy"
        physicsBody = params.body
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.categoryBitMask = params.mask.category
        physicsBody?.collisionBitMask = params.mask.collision
        physicsBody?.contactTestBitMask = params.mask.contact
        runDefaultAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class EnemyParams : MobileUnitParams {
    var purviewRange: Int;
    let mask: PhysicsBodyMask
    let body : SKPhysicsBody;

    init(mobileUnitParams: MobileUnitParams, mask : PhysicsBodyMask, body : SKPhysicsBody, purviewRange: Int) {
        self.mask = mask
        self.purviewRange = purviewRange
        self.body = body
        super.init(mobileUnitParams: mobileUnitParams)
    }
    
    convenience init(mobileUnitParams: MobileUnitParams, mask : PhysicsBodyMask, radius: CGFloat, purviewRange: Int) {
        self.init(mobileUnitParams: mobileUnitParams, mask: mask, body: SKPhysicsBody(circleOfRadius: radius), purviewRange: purviewRange)
    }
}
