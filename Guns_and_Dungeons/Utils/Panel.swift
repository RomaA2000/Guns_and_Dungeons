//
//  Panel.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 15.11.2019.
//  Copyright © 2019 Александр Потапов. All rights reserved.
//

import Foundation
import UIKit

protocol PanelSubview: UIView {
    associatedtype Params
    init(params: Params)
}

class Panel: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, defaultImage: UIImage?) {
        self.init(frame: frame)
//        self.image = defaultImage
        self.isUserInteractionEnabled = true
    }
    
    func addViews(views: [UIView]) {
        let number: Int = views.count
        guard number % 2 == 0, let viewSize = views.first?.frame.size else { return }
        var rows: Int = 2
        var colomns: Int = number / 2
        let bias: Int = Int(sqrt(Double(number)))
        for conformRows in (0...bias).reversed() {
            if (number % rows == 0) {
                rows = conformRows
                break
            }
        }
        colomns = number / rows
        let x_dist = (self.bounds.width - viewSize.width * CGFloat(colomns)) / CGFloat(colomns + 1)
        let y_dist = (self.bounds.height - viewSize.height * CGFloat(rows)) / CGFloat(rows + 1)
        let x_arr: [CGFloat] = Array(stride(from: x_dist + viewSize.width / 2,
                                            to: self.bounds.width - 1, by: x_dist + viewSize.width))
        let y_arr: [CGFloat] = Array(stride(from: y_dist + viewSize.height / 2,
                                            to: self.bounds.height - 1, by: y_dist + viewSize.height))
        guard x_arr.count * y_arr.count == number else { return }
        var current_view: Int = 0
        for y in y_arr {
            for x in x_arr {
                let viewSize: CGSize = views[current_view].frame.size
                views[current_view].frame.origin = CGPoint(x: x - viewSize.width / 2, y: y - viewSize.height / 2)
                addSubview(views[current_view])
                current_view += 1
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
