//
//  MovingUnit.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 15.11.2019.
//  Copyright © 2019 Роман Геев. All rights reserved.
//

import Foundation
import SpriteKit

class MobileUnit: DestroyableUnit {
    var maxSpeed: Int
    var walkAnimation: SKAction
    init(params: MobileUnitParams) {
        maxSpeed = params.maxSpeed;
        walkAnimation = params.walkAnimation
        super.init(params: params.destoyableUntiParams)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MobileUnitParams {
    var destoyableUntiParams: DestroyableUnitParams
    var maxSpeed: Int
    var walkAnimation: SKAction
    
    init(destoyableUntiParams: DestroyableUnitParams, maxSpeed: Int, walkAnimation: SKAction) {
        self.destoyableUntiParams = destoyableUntiParams
        self.maxSpeed = maxSpeed
        self.walkAnimation = walkAnimation
    }
}
