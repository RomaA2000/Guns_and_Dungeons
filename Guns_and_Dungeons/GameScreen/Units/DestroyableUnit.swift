//
//  DestroyableUnit.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 16.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import SpriteKit

class DestroyableUnit: AnimatedUnit {
    
    var healthPoints: Int
    var deathAnimation: SKAction
    
    init(params: DestroyableUnitParams) {
        healthPoints = params.healthPoints
        deathAnimation = params.deathAnimation
        super.init(params: params)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DestroyableUnitParams : AnimatedUnitParams{

    var healthPoints: Int
    var deathAnimation: SKAction

    init(animatedUnitParams: AnimatedUnitParams, healthPoints: Int, deathAnimation: SKAction) {
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


