//
//  TableItemCell.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 13.12.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import UIKit

class TableItemCell: UICollectionViewCell {
    
    var button: UIButton
    var backgroundImageView: UIImageView?
    var imageView: UIImageView?
    
    override init(frame: CGRect) {
        let locationParams = LocationParameters(centerPoint: CGPoint(x: 0.5, y: 0.8), k: 1.8, square: 0.1)
        let buttonFrame = getRect(parentFrame: frame, params: locationParams)
        button = UIButton(frame: buttonFrame)
        super.init(frame: frame)
        button.backgroundColor = .red
        self.addSubview(button)
    }
    
    func setData(cellInfo: CellInfo) {
        backgroundImageView = UIImageView(image: cellInfo.background)
        
        imageView = UIImageView(image: cellInfo.itemImage)
        
        button.titleLabel?.text = cellInfo.text
        
        button.isEnabled = cellInfo.unlocked
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let identyfire = "cell"
    
}
