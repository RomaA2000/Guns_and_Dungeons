//
//  PanelButton.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 15.11.2019.
//  Copyright © 2019 Александр Потапов. All rights reserved.
//

import UIKit

class PanelButton : UIButton, PanelSubview {
    typealias Params = PanelButtonParams
    let number: Int
    let defaultTexture: UIImage?
    let pressedTexture: UIImage?
    
    required init(params: PanelButtonParams) {
        self.number = params.number
        self.defaultTexture = params.defaultTexture
        self.pressedTexture = params.pressedTexture
        super.init(frame: params.frame) // need to locate manualy
        self.setImage(defaultTexture, for: .normal)
        backgroundColor = .red
        addTarget(self, action: #selector(buttonRelisedInside(sender:)), for: .touchUpInside)
        addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchDown)
        addTarget(self, action: #selector(buttonReleasedOutside(sender:)), for: .touchUpOutside)
        setTitle("Level \(number + 1)", for: .normal)
        for starNumber in 1...params.stars {
            let star: UIImageView = UIImageView(image: params.starTexture)
            let location = LocationParameters(centerPoint: CGPoint(x: 0.25 * CGFloat(starNumber), y: 0.8), k: 1, square: 0.01)
            self.posSubviewByRect(subView: star, location: location)
            print(star.frame)
        }
    }
    
    required init?(coder: NSCoder) {
        self.number = 0
        self.defaultTexture = nil
        self.pressedTexture = nil
        super.init(coder: coder)
    }
    
    @objc func buttonPressed(sender: PanelButton) {
        print("touched: ", sender.number)
        backgroundColor = .yellow
    }
    
    @objc func buttonReleasedOutside(sender: PanelButton) {
        print("realised outsied")
        backgroundColor = .red
    }
    
    @objc func buttonRelisedInside(sender: PanelButton) {
        print("relised")
        parent(implementing: Callable.self)?.call(number: sender.number)
        sender.backgroundColor = .red
    }
}


class ButtonParams {
    let frame: CGRect
    let defaultTexture: UIImage?
    let pressedTexture: UIImage?
    let label: String
    
    init(frame: CGRect, defaultTexture: UIImage?, pressedTexture: UIImage?, label: String) {
        self.frame = frame
        self.defaultTexture = defaultTexture
        self.pressedTexture = pressedTexture
        self.label = label
    }

    init(copy: ButtonParams) {
        self.frame = copy.frame
        self.defaultTexture = copy.defaultTexture
        self.pressedTexture = copy.pressedTexture
        self.label = copy.label
    }
}

class PanelButtonParams: ButtonParams {
    let starTexture: UIImage?
    let stars: Int
    let number: Int
    init(buttonParams: ButtonParams, starTexture: UIImage?, number: Int, stars: Int) {
        self.stars = stars
        self.starTexture = starTexture
        self.number = number
        super.init(copy: buttonParams)
    }
}
