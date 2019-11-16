//
//  PanelScrollView.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 15.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation
import UIKit


class PanelsScrollView : UIScrollView {
    var panels: [UIView] = []
    let margins: MarnginsInformation
    
    override init(frame: CGRect = CGRect()) {
        margins = MarnginsInformation()
        super.init(frame: frame)
    }
    
    init(frame: CGRect, panelsNumber: Int, margins: MarnginsInformation) {
        self.margins = margins
        super.init(frame: frame)
        let locationRect: CGRect = CGRect(x: margins.marginStart, y: 0, width: margins.panelWidth, height: bounds.height)
        let panelArgs: PanelInformation = PanelInformation(frame: locationRect,
                                                           x_list: [CGFloat(0.30), CGFloat(0.70)],
                                                           y_list: [CGFloat(0.25), CGFloat(0.75)],
                                                           k: CGFloat(1),
                                                           s: CGFloat(0.1))
        for _ in 0..<panelsNumber {
            addPanel(panelArgs: panelArgs)
            panelArgs.numerator += 4
            panelArgs.panelFrame.origin.x += margins.marginMiddle + margins.panelWidth
        }
        
        contentSize = CGSize(width: 2 * margins.marginStart + CGFloat(panelsNumber) * margins.panelWidth + CGFloat(panelsNumber - 1) * margins.marginMiddle, height: bounds.height)
        isScrollEnabled = true;
        showsHorizontalScrollIndicator = false
        delegate = self
    }
    
    func addPanel(panelArgs: PanelInformation) {
        let panel = Panel<PanelButton>(panelArgs: panelArgs)
        panel.layer.cornerRadius = 10
        panel.layer.masksToBounds = true
        panel.backgroundColor = .green
        addSubview(panel)
        panels.append(panel)
    }
    
    //MARK: - Иногда при резком отпускании вбок кнопка обратно не отжимается, потом поправить
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PanelsScrollView: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let position = targetContentOffset.pointee.x + bounds.width / 2
        var targetX: CGFloat = 0;
        var idx : Int = 0
        if (position > bounds.width / 2) {
            idx = Int((position - bounds.width / 2) / (margins.panelWidth + margins.marginMiddle * 2))
            if (idx >= panels.count - 1) {
                idx = panels.count - 1
            } else {
                idx += position - panels[idx].center.x > panels[idx + 1].center.x - position ? 1 : 0
            }
        }
        targetX = panels[idx].center.x - bounds.width / 2
        targetContentOffset.pointee.x = targetX
    }
}
