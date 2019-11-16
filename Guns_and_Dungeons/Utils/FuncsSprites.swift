//
//  FuncSprites.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 16.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation
import SpriteKit

func getAnimation(atlasName: String, frameName: String, size: Int) -> SKAction {
    let textureAtlas = SKTextureAtlas(named: atlasName)
    var texturesArray: [SKTexture] = []
    for i in 0...size {
        texturesArray.append(textureAtlas.textureNamed(frameName + String(i)))
    }
    return SKAction.repeatForever(SKAction.animate(with: texturesArray, timePerFrame: 0.1, resize: false, restore: false))
}
