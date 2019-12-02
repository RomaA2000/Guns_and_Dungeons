//
//  ImageSwitch.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 02.12.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import UIKit

protocol SwitcherDelegate: class {
    func stateChanged(_ sender: Switcher)
}

class Switcher: UIImageView {
    
    let switcher: UIImageView
    let switcherOffCenter: CGPoint
    let switcherOnCenter: CGPoint
    var state: Bool = true
    weak var delegate: SwitcherDelegate?
    
    init(frame: CGRect, backgroundImage: UIImage?, buttonImage: UIImage?) {
        let borderPart: CGFloat = 0.1
        let border: CGFloat = min(frame.width, frame.height) * borderPart
        let switcherSize: CGSize = CGSize(width: frame.width * 0.5, height: frame.height - 2 * border)
        switcherOffCenter = CGPoint(x: border + switcherSize.width / 2, y: frame.height * 0.5)
        switcherOnCenter = CGPoint(x: frame.width - border - switcherSize.width / 2, y: frame.height * 0.5)
        self.switcher = UIImageView(frame: CGRect(origin: CGPoint.zero, size: switcherSize))
        self.switcher.image = buttonImage
        self.switcher.center = switcherOnCenter
        super.init(frame: frame)
        self.image = backgroundImage
        self.addSubview(switcher)
        self.isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        setState(state: !state)
    }
    
    func setState(state: Bool) {
        if (state) {
            switcher.animateTo(centerPoint: switcherOnCenter, duration: 0.2)
            self.alpha = 1
        }
        else {
            switcher.animateTo(centerPoint: switcherOffCenter, duration: 0.2)
            self.alpha = 0.7
        }
        self.state = state
        delegate?.stateChanged(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
