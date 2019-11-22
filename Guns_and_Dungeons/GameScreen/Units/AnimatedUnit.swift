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
    var weapon: Weapon?
    var defaultTexture: SKTexture
    var defaultAnimation: SKAction
    init(params: AnimatedUnitParams) {
        self.defaultAnimation = params.defaultAnimation
        self.defaultTexture = params.defaultTexture
        self.weapon = params.weapon
        super.init(texture: params.defaultTexture, color: .black, size: defaultTexture.size())
        self.position = params.location
    }
    
    func runDefaultAnimation() {
        run(defaultAnimation, withKey: "default")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AnimationTexturesParams {
    let defaultTexture: SKTexture
    let defaultAnimation: SKAction
    init(defaultTexture: SKTexture, defaultAnimation: SKAction) {
        self.defaultAnimation = defaultAnimation
        self.defaultTexture = defaultTexture
    }
    init(animationTexturesParams: AnimationTexturesParams) {
        self.defaultAnimation = animationTexturesParams.defaultAnimation
        self.defaultTexture = animationTexturesParams.defaultTexture
    }
}

class AnimatedUnitParams :  AnimationTexturesParams{

    let location: CGPoint
    let weapon: Weapon?
    
    init(animationTexturesParams : AnimationTexturesParams, location: CGPoint, weapon: Weapon?) {
        self.location = location
        self.weapon = weapon
        super.init(animationTexturesParams: animationTexturesParams)
    }
    
     init(animatedUnitParams: AnimatedUnitParams) {
        self.location = animatedUnitParams.location
        self.weapon = animatedUnitParams.weapon
        super.init(animationTexturesParams: animatedUnitParams)
    }
}
