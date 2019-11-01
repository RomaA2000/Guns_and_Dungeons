//
//  SinglePlayerViewController.swift
//  Guns_and_Dungeons
//
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation
import UIKit

class PanelButton : UIButton {
    let number: Int
    init(frame: CGRect, num: Int) {
        number = num
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AboutLevels {
     var nowPanel : Int = 0
}

class PanelInformation {
    var cordinates : [AllParameters]
    var numerator: Int
    init(x_list : [CGFloat], y_list : [CGFloat], k : CGFloat, s : CGFloat) {
        cordinates  = []
        for i in x_list {
            for j in y_list {
                cordinates.append(AllParameters(centerPoint: CGPoint(x: i, y: j), k: k, square: s))
            }
        }
        numerator = 0
    }
}

class Panel {
    let mainView : UIView
    init(frame: CGRect) {
        mainView = UIView(frame: frame)
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = true
        mainView.backgroundColor = .green
    }
}

class MarnginsInformation {
    var marginStart: CGFloat = 0
    var marginMiddle: CGFloat = 0
    var panelWidth: CGFloat = 0
}

class LevelPanel : UIScrollView {
    var marginsInformation = MarnginsInformation()
    var aboutLevels : AboutLevels = AboutLevels()
    var panels: [Panel] = []
}

class SinglePlayerViewController : UIViewController, UIScrollViewDelegate {
    
    var levelPanel : LevelPanel = LevelPanel()
    var backButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        let k_scroll = view.bounds.width / (0.6 * view.bounds.height)
        view.posSubviewByRect(subView: levelPanel,
                                   params: AllParameters(centerPoint: CGPoint(x: 0.5, y: 0.4), k: k_scroll , square: 0.6))
        levelPanel.backgroundColor = .gray
        backButton = view.addButton(label: "Back", target: self, selector: #selector(toMenuScreen),
                                         params: AllParameters(centerPoint: CGPoint(x: 0.8, y: 0.9), k: 1.25, square: 0.005))
        levelPanel.isScrollEnabled = true
        levelPanel.showsHorizontalScrollIndicator = false
        fillLevelPanel()
        levelPanel.contentOffset = CGPoint(x: levelPanel.panels[levelPanel.aboutLevels.nowPanel].mainView.center.x - levelPanel.bounds.width / 2, y: 0)
        levelPanel.delegate = self
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let position = targetContentOffset.pointee.x + levelPanel.bounds.width / 2
        var targetX: CGFloat = 0;
        var idx : Int = 0
        if (position > levelPanel.bounds.width / 2) {
            idx = Int((position - levelPanel.bounds.width / 2) / (levelPanel.marginsInformation.panelWidth + levelPanel.marginsInformation.marginMiddle * 2))
            if (idx >= levelPanel.panels.count - 1) {
                idx = levelPanel.panels.count - 1
            } else {
                idx += position - levelPanel.panels[idx].mainView.center.x > levelPanel.panels[idx + 1].mainView.center.x - position ? 1 : 0
            }
        }
        levelPanel.aboutLevels.nowPanel = idx
        targetX = levelPanel.panels[idx].mainView.center.x - levelPanel.bounds.width / 2
        targetContentOffset.pointee.x = targetX
    }
    
    @objc func buttonPressed(sender: PanelButton) {
        print(sender.number)
        sender.backgroundColor = .yellow
    }
    
    func addPanel(locationRect: CGRect, information: PanelInformation) -> UIView {
        levelPanel.panels.append(Panel(frame: locationRect))
         for i in 0..<4 {
             let now : PanelButton = PanelButton(frame: CGRect(), num: information.numerator)
            levelPanel.panels.last!.mainView.posSubviewByRect(subView: now, params: information.cordinates[i])
             information.numerator += 1
             now.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
         }
        return levelPanel.panels.last!.mainView
     }
    
    func fillLevelPanel() {
        let number = 10
        let panelPart : CGFloat = 0.6
        var imageRect : CGRect = CGRect(x: 0, y: 0, width: levelPanel.bounds.width * panelPart, height: levelPanel.bounds.height)
        let information: PanelInformation = PanelInformation(x_list: [CGFloat(0.30), CGFloat(0.70)], y_list: [CGFloat(0.25), CGFloat(0.75)], k: CGFloat(1), s: CGFloat(0.1))
        levelPanel.marginsInformation.panelWidth = imageRect.width
        levelPanel.marginsInformation.marginMiddle = levelPanel.bounds.width * 0.05
        levelPanel.marginsInformation.marginStart = (levelPanel.bounds.width - imageRect.width) / 2
        for i in 0..<number {
            if (i == 0) {
                imageRect.origin.x += levelPanel.marginsInformation.marginStart - levelPanel.marginsInformation.marginMiddle
            }
            imageRect.origin.x += levelPanel.marginsInformation.marginMiddle
            levelPanel.addSubview(addPanel(locationRect: imageRect, information: information))
            imageRect.origin.x += imageRect.width + levelPanel.marginsInformation.marginMiddle
        }
        levelPanel.contentSize = CGSize(width: levelPanel.marginsInformation.marginStart * 2 + levelPanel.marginsInformation.marginMiddle * CGFloat(2 * (number - 1)) + imageRect.width * CGFloat(number), height: imageRect.height)
    }

    @objc func toMenuScreen() {
        navigationController?.popViewController(animated: true)
    }
}
