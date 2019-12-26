//
//  PanelButton.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 15.11.2019.
//  Copyright © 2019 Александр Потапов. All rights reserved.
//

import UIKit

class PanelButton : UIButton, PanelSubview {
    typealias Panel = PanelButtonParams
    
    var number: UInt64
    var defaultTexture: UIImage?
    var pressedTexture: UIImage?
    var starTexture:    UIImage?
    var starsNumber: UInt64 = 0
    
    required init(params: PanelButtonParams) {
        self.number = params.number
        self.defaultTexture = params.defaultTexture
        self.pressedTexture = params.pressedTexture
        self.starTexture = params.starTexture
        super.init(frame: params.frame)
        self.setImage(defaultTexture, for: .normal)
        self.setImage(pressedTexture, for: .selected)
        addTarget(self, action: #selector(buttonRelisedInside(sender:)), for: .touchUpInside)
        addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchDown)
        addTarget(self, action: #selector(buttonReleasedOutside(sender:)), for: .touchUpOutside)
        self.setTitle("Level \(number + 1)", for: .normal)
        setStars(stars: params.stars)
        self.isEnabled = params.enabled
    }
    
    required init?(coder: NSCoder) {
        self.number = 0
        self.defaultTexture = nil
        self.pressedTexture = nil
        super.init(coder: coder)
    }
    
    func setStars(stars: UInt64) {
        guard stars > 0, stars > self.starsNumber else { return }
        for starNumber in self.starsNumber + 1 ... stars {
            let star: UIImageView = UIImageView(image: self.starTexture)
            let location = LocationParameters(centerPoint: CGPoint(x: 0.25 * CGFloat(starNumber), y: 0.8), k: 1, square: 0.01)
            self.posSubviewByRect(subView: star, location: location)
        }
        self.starsNumber = stars
    }
    
    @objc func buttonPressed(sender: PanelButton) {
        backgroundColor = .yellow
        self.imageView?.alpha = 0.5
    }
    
    @objc func buttonReleasedOutside(sender: PanelButton) {
        self.imageView?.alpha = 1
        backgroundColor = nil
    }
    
    @objc func buttonRelisedInside(sender: PanelButton) {
        parent(implementing: Callable.self)?.call(number: sender.number)
        self.imageView?.alpha = 0.5
        backgroundColor = nil
    }
}


class ButtonParams {
    let locationParameters: LocationParameters
    let defaultTexture: UIImage?
    let pressedTexture: UIImage?
    let label: String
    
    init(location: LocationParameters, defaultTexture: UIImage?, pressedTexture: UIImage? = nil, label: String = "") {
        self.locationParameters = location
        self.defaultTexture = defaultTexture
        self.pressedTexture = pressedTexture
        self.label = label
    }

    init(copy: ButtonParams) {
        self.locationParameters = copy.locationParameters
        self.defaultTexture = copy.defaultTexture
        self.pressedTexture = copy.pressedTexture
        self.label = copy.label
    }
}

class PanelButtonParams: ButtonParams, PanelSuviewParams {
    
    let starTexture: UIImage?
    let stars: UInt64
    let number: UInt64
    var frame: CGRect
    var enabled: Bool
    
    func setFrame(frame: CGRect) {
        self.frame = frame
    }
    
    func getLocationParams() -> LocationParameters {
        return self.locationParameters
    }
    
    init(buttonParams: ButtonParams, starTexture: UIImage? = nil, number: UInt64 = 0, stars: UInt64 = 0, enabled: Bool) {
        self.stars = stars
        self.starTexture = starTexture
        self.number = number
        self.frame = CGRect()
        self.enabled = enabled
        super.init(copy: buttonParams)
    }
}
