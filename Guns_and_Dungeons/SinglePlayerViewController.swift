//
//  SinglePlayerViewController.swift
//  Guns_and_Dungeons
//
//  Copyright © 2019 Александр Потапов (который раз уже). All rights reserved.
//

import Foundation
import UIKit

class PanelButton : UIButton {
    let number: Int
    init(frame: CGRect = CGRect(), num: Int) {
        number = num
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Panel: UIView {
    var buttons: [PanelButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AboutLevels {
     var nowPanel : Int = 0
}

protocol Callable: class {
    func itemSelected(number: Int)
}

class PanelsScrollView : UIScrollView {
    
    var panels: [UIView] = []
    let margins: MarnginsInformation
    weak var viewConroller: Callable? = nil
    
    override init(frame: CGRect = CGRect()) {
        margins = MarnginsInformation()
        super.init(frame: frame)
    }
    
    init(viewConterller: Callable?, frame: CGRect, panelsNumber: Int, margins: MarnginsInformation) {
        self.viewConroller = viewConterller
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
//        backgroundColor = .gray
        showsHorizontalScrollIndicator = false
        delegate = self
    }
    
    func addPanel(panelArgs: PanelInformation) {
        let panel: Panel = Panel(frame: panelArgs.panelFrame)
        panel.layer.cornerRadius = 10
        panel.layer.masksToBounds = true
        panel.backgroundColor = .green
        for buttonNumber in panelArgs.numerator..<panelArgs.numerator + 4 {
            let button: PanelButton = PanelButton(num: buttonNumber)
            button.addTarget(self, action: #selector(buttonRelisedInside(sender:)), for: .touchUpInside)
            button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchDown)
            button.addTarget(self, action: #selector(buttonReleasedOutside(sender:)), for: .touchUpOutside)
            button.setTitle(String(buttonNumber), for: .normal)
            panel.posSubviewByRect(subView: button, params: panelArgs.cordinates[buttonNumber % 4])
            panel.buttons.append(button)
        }
        addSubview(panel)
        panels.append(panel)
    }
    
    //Mark: - Иногда при резком отпускании вбок кнопка обратно не отжимается, потом поправить
    
    @objc func buttonPressed(sender: PanelButton) {
        print("touched: ", sender.number)
        sender.backgroundColor = .yellow
    }
    
    @objc func buttonReleasedOutside(sender: PanelButton) {
        print("realised outsied")
        sender.backgroundColor = .red
    }
    
    @objc func buttonRelisedInside(sender: PanelButton) {
        viewConroller?.itemSelected(number: sender.number)
        sender.backgroundColor = .red
    }
    
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

class SinglePlayerViewController : UIViewController, Callable {
    
    var levelPanel : PanelsScrollView = PanelsScrollView()
    var backButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        let k_scroll = view.bounds.width / (0.6 * view.bounds.height)
        let scrollFrame: CGRect = getRect(parentFrame: view.bounds,
                                        params: AllParameters(centerPoint: CGPoint(x: 0.5, y: 0.4),
                                                            k: k_scroll,
                                                            square: 0.6))
        let panelWidth: CGFloat = 0.6 * scrollFrame.width
        let margins: MarnginsInformation = MarnginsInformation(marginStart: (scrollFrame.width - panelWidth) / 2,
                                                         marginMiddle: scrollFrame.width * 0.05,
                                                         panelWidth: scrollFrame.width * 0.6)
        levelPanel = PanelsScrollView(viewConterller: self, frame: getRect(parentFrame: view.bounds,
                                                params: AllParameters(centerPoint: CGPoint(x: 0.5, y: 0.4),
                                                                      k: k_scroll , square: 0.6)),
                                  panelsNumber: 5, margins: margins);
        view.addSubview(levelPanel)
        backButton = view.addButton(label: "Back", target: self, selector: #selector(toMenuScreen),
                                 params: AllParameters(centerPoint: CGPoint(x: 0.8, y: 0.9), k: 1.25, square: 0.005))
    }
    
    func itemSelected(number: Int) {
        print("to level: ", number)
    }

    @objc func toMenuScreen() {
        navigationController?.popViewController(animated: true)
    }
}


class PanelInformation {
    var cordinates : [AllParameters]
    var numerator: Int
    var panelFrame: CGRect
    init(frame: CGRect, x_list : [CGFloat], y_list : [CGFloat], k : CGFloat, s : CGFloat) {
        cordinates  = []
        panelFrame = frame
        for i in x_list {
            for j in y_list {
                cordinates.append(AllParameters(centerPoint: CGPoint(x: i, y: j), k: k, square: s))
            }
        }
        numerator = 0
    }
}

class MarnginsInformation {
    var marginStart: CGFloat
    var marginMiddle: CGFloat
    var panelWidth: CGFloat
    init(marginStart : CGFloat, marginMiddle : CGFloat, panelWidth : CGFloat) {
        self.marginStart = marginStart
        self.marginMiddle = marginMiddle
        self.panelWidth = panelWidth
    }
    init() {
        marginStart =  0
        marginMiddle = 0
        panelWidth =  0
    }
}
