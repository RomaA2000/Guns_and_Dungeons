//
//  DestroyableUnit.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 15.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//
import SpriteKit

class DestroyableUnit: AnimatedUnit {
    
    var healthPoints: Int64
    var deathAnimation: SKAction
    
    init(params: DestroyableUnitParams) {
        healthPoints = params.healthPoints
        deathAnimation = params.deathAnimation
        super.init(params: params)
    }
    
    func update(_ currentTime: TimeInterval, target: CGPoint?) {
        // выстрел
    }
//    init(destroyableUnit: DestroyableUnit) {
//        healthPoints = destroyableUnit.healthPoints
//        deathAnimation = destroyableUnit.deathAnimation
//        super.init(params: destroyableUnit)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DestroyableUnitParams : AnimatedUnitParams{

    var healthPoints: Int64
    var deathAnimation: SKAction

    init(animatedUnitParams: AnimatedUnitParams, healthPoints: Int64, deathAnimation: SKAction) {
        self.healthPoints = healthPoints
        self.deathAnimation = deathAnimation
        super.init(animatedUnitParams: animatedUnitParams)
    }

    init(destroyableUnitParams: DestroyableUnitParams) {
        self.healthPoints = destroyableUnitParams.healthPoints
        self.deathAnimation = destroyableUnitParams.deathAnimation
        super.init(animatedUnitParams: destroyableUnitParams)
    }
}


