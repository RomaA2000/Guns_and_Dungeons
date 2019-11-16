//
//  ContactEnemy.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 15.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation

class ContactEnemy : MovingUnit {

    var purviewRange: Int = 0
    var contactDamage: Int = 0
    
    init(params: ContactEnemyParams) {
        purviewRange = params.purviewRange
        contactDamage = params.contactDamage
        super.init(animationParams: params.unitTexturesParams, dataParams: params.unitDataParams)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


class ContactEnemyParams {
    var unitTexturesParams: UnitTexturesParams
    var unitDataParams: UnitDataParams
    var purviewRange: Int;
    var contactDamage: Int;
    
    init(unitTexturesParams: UnitTexturesParams, unitDataParams: UnitDataParams, purvewRange: Int, contactDamage: Int) {
        self.unitTexturesParams = unitTexturesParams
        self.unitDataParams = unitDataParams
        self.purviewRange = purvewRange
        self.contactDamage = contactDamage
    }
}
