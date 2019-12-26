//
//  ImageLabel.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 27.12.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation
import UIKit

class ImageLabel: UIView {
    var background: UIImageView
    var label: UILabel
    
    init(frame: CGRect, image: UIImage?, text: String) {
        let subviewsFrame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        self.background = UIImageView(frame: subviewsFrame)
        self.background.image = image
        self.label = UILabel(frame: subviewsFrame)
        self.label.text = text
        self.label.textAlignment = .center
        super.init(frame: frame)
        self.addSubview(background)
        self.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
