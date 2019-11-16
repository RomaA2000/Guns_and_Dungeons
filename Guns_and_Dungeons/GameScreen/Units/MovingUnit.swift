//
//  MovingUnit.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 15.11.2019.
//  Copyright © 2019 Роман Геев. All rights reserved.
//

import Foundation
import SpriteKit

class MovingUnit: AnimatedUnit {

    var walkAnimation: SKAction
    var healthPoint: Int
    var maxSpeed: Int
    
    init(animationParams: UnitTexturesParams, dataParams: UnitDataParams) {
        walkAnimation = animationParams.walkAnimation
        healthPoint = dataParams.healthPoint
        maxSpeed = dataParams.maxSpeed
        super.init(texture: animationParams.texture, animation: animationParams.defaultAnimation, location: dataParams.location)
    }
    
    required init?(coder aDecoder: NSCoder) {
        walkAnimation = SKAction()
        healthPoint = 1
        maxSpeed = 1
        super.init(coder: aDecoder)
    }
}

class UnitDataParams {
    var healthPoint: Int
    var location: CGPoint
    var maxSpeed: Int
    init(healthPoint: Int, location: CGPoint, maxSpeed: Int) {
        self.healthPoint = healthPoint
        self.location = location
        self.maxSpeed = maxSpeed
    }
}

class UnitTexturesParams {
    var defaultAnimation: SKAction
    var walkAnimation: SKAction
    var texture: SKTexture
    init(texture: SKTexture, defaultAnimation: SKAction, walkAnimation: SKAction) {
        self.texture = texture
        self.defaultAnimation = defaultAnimation
        self.walkAnimation = walkAnimation
    }
}
