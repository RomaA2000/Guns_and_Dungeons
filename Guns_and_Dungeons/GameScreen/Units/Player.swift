//
//  Player.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 15.11.2019.
//  Copyright © 2019 Александр Потапов. All rights reserved.
//

import Foundation
import SpriteKit

class Player: MovingUnit {
    var id: Int = 0
    
    init(params: PlayerParams) {
        id = params.id
        let animationParams = UnitTexturesParams(texture: <#T##SKTexture#>,
                                                 defaultAnimation: getAnimation(atlasName: params.atlasName, frameName: "s: ", size: ),
                                                 walkAnimation: <#T##SKAction#>)
        super.init(animationParams: params.unitTexturesParams, dataParams: params.unitDataParams)
    }
    
    func setVelocity(velocity: CGVector) {
        physicsBody?.velocity = velocity
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

class PlayerParams {
    var atlasName: String
    var unitDataParams: UnitDataParams
    var id: Int
    
    init(atlasName: String, unitDataParams: UnitDataParams, id: Int) {
        self.atlasName = atlasName
        self.unitDataParams = unitDataParams
        self.id = id
    }
}
