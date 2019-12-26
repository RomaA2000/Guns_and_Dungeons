//
//  Unit.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 15.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

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
    
    func update(_ currentTime: TimeInterval, target: CGPoint?) {
        if let point = target {
            print("point: ", point)
            weapon?.fire(currentTime: currentTime)
        }
    }
    
    func changeWeapon(weapon: Weapon) -> Weapon? {
        let temp = self.weapon
        self.weapon = weapon
        return temp
    }
    
    func rotateGunTo(angel: CGFloat) {
        self.weapon?.zRotation = angel - self.zRotation
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
