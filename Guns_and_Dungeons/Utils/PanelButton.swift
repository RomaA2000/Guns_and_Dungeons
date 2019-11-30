//
//  PanelButton.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 15.11.2019.
//  Copyright © 2019 Александр Потапов. All rights reserved.
//

import UIKit

class PanelButton : UIButton {
    var number: Int
    var defaultTexture: UIImage?
    var pressedTexture: UIImage?
    var starTexture:    UIImage?
    var starsNumber: Int = 0
    
    required init(params: PanelButtonParams) {
        self.number = params.number
        self.defaultTexture = params.defaultTexture
        self.pressedTexture = params.pressedTexture
        self.starTexture = params.starTexture
        super.init(frame: params.frame) // need to locate manualy
        self.setImage(defaultTexture, for: .normal)
        self.setImage(pressedTexture, for: .selected)
        backgroundColor = .black
        addTarget(self, action: #selector(buttonRelisedInside(sender:)), for: .touchUpInside)
        addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchDown)
        addTarget(self, action: #selector(buttonReleasedOutside(sender:)), for: .touchUpOutside)
        setTitle("Level \(number + 1)", for: .normal)
        setStars(stars: params.stars)
        print("stars: ", params.stars)
    }
    
    required init?(coder: NSCoder) {
        self.number = 0
        self.defaultTexture = nil
        self.pressedTexture = nil
        super.init(coder: coder)
    }
    
    func setStars(stars: Int) {
        guard stars > 0, stars > self.starsNumber else { return }
        for starNumber in self.starsNumber + 1 ... stars {
            let star: UIImageView = UIImageView(image: self.starTexture)
            let location = LocationParameters(centerPoint: CGPoint(x: 0.25 * CGFloat(starNumber), y: 0.8), k: 1, square: 0.01)
            self.posSubviewByRect(subView: star, location: location)
            print(star.frame)
        }
        self.starsNumber = stars
    }
    
    @objc func buttonPressed(sender: PanelButton) {
        backgroundColor = .yellow
        self.imageView?.alpha = 0.5
    }
    
    @objc func buttonReleasedOutside(sender: PanelButton) {
        self.imageView?.alpha = 1
    }
    
    @objc func buttonRelisedInside(sender: PanelButton) {
        parent(implementing: Callable.self)?.call(number: sender.number)
        self.imageView?.alpha = 0.5
    }
}


class ButtonParams {
    let frame: CGRect
    let defaultTexture: UIImage?
    let pressedTexture: UIImage?
    let label: String
    
    init(frame: CGRect, defaultTexture: UIImage?, pressedTexture: UIImage? = nil, label: String = "") {
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
    init(buttonParams: ButtonParams, starTexture: UIImage? = nil, number: Int = 0, stars: Int = 0) {
        self.stars = stars
        self.starTexture = starTexture
        self.number = number
        super.init(copy: buttonParams)
    }
}
