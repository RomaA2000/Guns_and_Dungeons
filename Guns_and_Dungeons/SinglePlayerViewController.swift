//
//  SinglePlayerViewController.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 18/10/2019.
//  Copyright © 2019 точно не Роман Агеев. All rights reserved.
//

import Foundation
import UIKit

class Panel {
    let buttons : [UIButton]
    let mainView : UIView
    init(frame: CGRect) {
        buttons = []
        mainView = UIView(frame: frame)
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = true
        mainView.backgroundColor = .green;
    }
    func addButton() {}
}

class SinglePlayerViewController : UIViewController, UIScrollViewDelegate {
    
    let levelPanel: UIScrollView = UIScrollView()
    var backButton: UIButton = UIButton()
    var levelNumber: Int = 0
    var marginStart: CGFloat = 0
    var marginMiddle: CGFloat = 0
    var panelWidth: CGFloat = 0
    // MARK: - когда подгружать информацию о уровнях
    var panels: [Panel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        let k_scroll = view.bounds.width / (0.6 * view.bounds.height)
        self.view.posSubviewByRect(subView: levelPanel,
                                   params: AllParameters(centerPoint: CGPoint(x: 0.5, y: 0.4), k: k_scroll , square: 0.6))
        levelPanel.backgroundColor = .gray
        backButton = self.view.addButton(label: "Back", target: self, selector: #selector(toMenuScreen),
                                         params: AllParameters(centerPoint: CGPoint(x: 0.8, y: 0.9), k: 1.25, square: 0.005))
        levelNumber = 16
        //temporary
        levelPanel.isScrollEnabled = true
//        levelPanel.isPagingEnabled = true

        fillLevelPanel(number: levelNumber)

        levelPanel.delegate = self
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let position = targetContentOffset.pointee.x + levelPanel.bounds.width / 2 // cause initially pointee.x is hight left corner point
        var targetX: CGFloat = 0;
        if (position <= levelPanel.bounds.width / 2) {
            targetX = panels.first!.mainView.center.x - levelPanel.bounds.width / 2
        }
        else {
            let idx = Int((position - levelPanel.bounds.width / 2) / (panelWidth + marginMiddle * 2))
            if (idx >= panels.count - 1) {
                targetX = panels.last!.mainView.center.x - levelPanel.bounds.width / 2
            }
            else {
                let nearestIdx = position - panels[idx].mainView.center.x < panels[idx + 1].mainView.center.x - position ? idx : idx + 1
                targetX = panels[nearestIdx].mainView.center.x - levelPanel.bounds.width / 2
            }
        }
        targetContentOffset.pointee.x = targetX

    }
    
    func addPanel(locationRect: CGRect) -> UIView {
        panels.append(Panel(frame: locationRect))
        return panels.last!.mainView
    }
    
    func fillLevelPanel(number: Int) {
        let panelPart : CGFloat = 0.6
        var imageRect : CGRect = CGRect(x: 0, y: 0, width: levelPanel.bounds.width * panelPart, height: levelPanel.bounds.height)
        panelWidth = imageRect.width
        marginMiddle = levelPanel.bounds.width * 0.05
        marginStart = (levelPanel.bounds.width - imageRect.width) / 2
        for i in 0..<number {
            if (i == 0) {
                imageRect.origin.x += marginStart - marginMiddle
            }
            imageRect.origin.x += marginMiddle
            levelPanel.addSubview(addPanel(locationRect: imageRect))
            imageRect.origin.x += imageRect.width + marginMiddle
        }
        levelPanel.contentSize = CGSize(width: marginStart * 2 + marginMiddle * CGFloat(2 * (number - 1)) + imageRect.width * CGFloat(number), height: imageRect.height)
    }
    
    @objc func toMenuScreen() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
