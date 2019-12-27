//
//  Unit.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 15.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import SpriteKit

class AnimatedUnit: SKSpriteNode {
    var type: UInt64
    var weapon: Weapon?
    var defaultTexture: SKTexture
    var defaultAnimation: SKAction

    init(params: AnimatedUnitParams) {
        self.defaultAnimation = params.defaultAnimation
        self.defaultTexture = params.defaultTexture
        self.weapon = params.weapon
        self.type = params.type
        super.init(texture: params.defaultTexture, color: .black, size: defaultTexture.size())
        self.position = params.location
        if (weapon != nil) {
            self.addChild(weapon!)
            weapon?.zPosition = self.zPosition + 1
            weapon?.base = self
        }
    }

//    init(animatedUnit : AnimatedUnit) {
//        self.weapon = animatedUnit.weapon
//        self.defaultTexture = animatedUnit.defaultTexture
//        self.defaultAnimation = animatedUnit.defaultAnimation
//        super.init(imageNamed: animatedUnit)
//    }

    func changeWeapon(weapon: Weapon) -> Weapon? {
        let temp = self.weapon
        self.weapon = weapon
        return temp
    }
    
    func getVector(to: CGPoint) -> CGVector {
        return CGVector(dx: to.x - self.position.x, dy: to.y - self.position.y)
    }

    func rotateGunTo(angel: CGFloat) {
        self.weapon?.zRotation = angel - self.zRotation
    }

    func gunVector() {
            
    }

    func runDefaultAnimation() {
        run(defaultAnimation, withKey: "default")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AnimatedUnit: UnitHolder {
    func getAngleOnScene() -> CGFloat {
        return self.zRotation
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

class AnimatedUnitParams : AnimationTexturesParams {
    let type: UInt64
    let location: CGPoint
    let weapon: Weapon?

    init(animationTexturesParams : AnimationTexturesParams, location: CGPoint, weapon: Weapon?, type: UInt64) {
        self.type = type
        self.location = location
        self.weapon = weapon
        super.init(animationTexturesParams: animationTexturesParams)
    }

     init(animatedUnitParams: AnimatedUnitParams) {
        self.location = animatedUnitParams.location
        self.weapon = animatedUnitParams.weapon
        self.type = animatedUnitParams.type
        super.init(animationTexturesParams: animatedUnitParams)
    }
}
