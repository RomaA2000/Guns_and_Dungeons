//
//  Unit.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 14.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation
import SpriteKit

class AnimatedUnit: SKSpriteNode {
    typealias ATP = AnimationTexturesParams
    let animation: ATP
    var weapon: Weapon?
    
    init(params: AnimatedUnitParams) {
        self.animation = params.animationParams
        self.weapon = params.weapon
        super.init(texture: animation.defaultTexture, color: .black, size: animation.defaultTexture.size())
        self.position = params.location
    }
    
    func runDefaultAnimation() {
        run(animation.defaultAnimation, withKey: "default")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AnimationTexturesParams {
    var defaultTexture: SKTexture
    var defaultAnimation: SKAction
    init(defaultAnimation: SKAction, defaultTexture: SKTexture) {
        self.defaultTexture = defaultTexture
        self.defaultAnimation = defaultAnimation
    }
}

class AnimatedUnitParams {
    var animationParams: AnimationTexturesParams
    var location: CGPoint
    var weapon: Weapon?
    init(animationParams: AnimationTexturesParams, location: CGPoint, weapon: Weapon?) {
        self.location = location
        self.weapon = weapon
        self.animationParams = animationParams
    }
}
