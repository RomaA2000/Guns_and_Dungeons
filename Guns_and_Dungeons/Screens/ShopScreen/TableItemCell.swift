//
//  TableItemCell.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 13.12.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import UIKit

class TableItemCell: UICollectionViewCell {
    
    var backgroundImageView: UIImageView
    var imageView: UIImageView
    
    override init(frame: CGRect) {
        let locationParams = LocationParameters(centerPoint: CGPoint(x: 0.5, y: 0.5), k: 1.2, square: 0.4)
        imageView = UIImageView(frame: getRect(parentFrame: frame, params: locationParams))
        backgroundImageView = UIImageView(frame: CGRect(origin: CGPoint.zero, size: frame.size))
        super.init(frame: frame)
        self.addSubview(backgroundImageView)
        self.addSubview(imageView)
    }
    
    func setData(cellInfo: CellInfo) {
        backgroundImageView.image = cellInfo.backgroundImage
        imageView.image = cellInfo.itemImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let identyfire = "cell"
    
}
