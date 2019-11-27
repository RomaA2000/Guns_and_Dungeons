//
//  PanelButton.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 15.11.2019.
//  Copyright © 2019 Александр Потапов. All rights reserved.
//

import UIKit


class PanelButton : UIButton, PanelSubview {
    let number: Int
    
    required init(frame: CGRect, num: Int) {
        number = num
        super.init(frame: frame)
        backgroundColor = .red
        addTarget(self, action: #selector(buttonRelisedInside(sender:)), for: .touchUpInside)
        addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchDown)
        addTarget(self, action: #selector(buttonReleasedOutside(sender:)), for: .touchUpOutside)
        setTitle("Level \(number + 1)", for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        parent(implementing: Callable.self)?.call(number: sender.number)
        sender.backgroundColor = .red
    }
}
