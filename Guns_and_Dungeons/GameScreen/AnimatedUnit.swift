//
//  Unit.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 14.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation
import SpriteKit

protocol AnimatedUnit {
    var walkAnimation: SKAction? { get }
    var standAnimation: SKAction? { get }
    
    
}
