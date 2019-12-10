//
//  FuncSprites.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 16.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation
import SpriteKit

func getAnimation(atlasName: String, frameName: String, defaultName: String, size: Int) -> AnimationTexturesParams {
    let textureAtlas = SKTextureAtlas(named: atlasName)
    var texturesArray: [SKTexture] = []
    for i in 1...size {
        texturesArray.append(textureAtlas.textureNamed(frameName + String(i)))
    }
    let animation = SKAction.repeatForever(SKAction.animate(with: texturesArray, timePerFrame: 0.1, resize: false, restore: false))
    let texture = textureAtlas.textureNamed(defaultName)
    return AnimationTexturesParams(defaultTexture: texture, defaultAnimation: animation)
}

func getAnimation(atlas: SKTextureAtlas, frameName: String, defaultName: String, size: Int) -> AnimationTexturesParams {
    var texturesArray: [SKTexture] = []
    for i in 1...size {
        texturesArray.append(atlas.textureNamed(frameName + String(i)))
    }
    let animation = SKAction.repeatForever(SKAction.animate(with: texturesArray, timePerFrame: 0.1, resize: false, restore: false))
    let texture = atlas.textureNamed(defaultName)
    return AnimationTexturesParams(defaultTexture: texture, defaultAnimation: animation)
}
