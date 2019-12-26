//
//  Button.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 20.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import SpriteKit

protocol ButtonDelegate: class {
    func buttonPressed(_ sender: Button)
}

class Button: SKSpriteNode {
    
    weak var delegate: ButtonDelegate? = nil
    let defaultTexture: SKTexture
    let pressedTexture: SKTexture
    
    init(defaultTexture: SKTexture, pressedTexture: SKTexture, params: LocationParameters, sceneFrame: CGRect) {
        self.defaultTexture = defaultTexture
        self.pressedTexture = pressedTexture
        let locationFrame = getRect(parentFrame: sceneFrame, params: params);
        super.init(texture: defaultTexture, color: .black, size: locationFrame.size)
        self.isUserInteractionEnabled = true
        position = CGPoint(x: locationFrame.midX, y: locationFrame.midY)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.texture = pressedTexture
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.texture = defaultTexture
        delegate?.buttonPressed(self)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.texture = defaultTexture
    }
    
}
