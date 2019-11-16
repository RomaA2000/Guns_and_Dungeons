//
//  SinglePlayerViewController.swift
//  Guns_and_Dungeons
//
//  Copyright © 2019 Александр Потапов . All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension UIResponder {
    func parent<T>(implementing proto: T.Type) -> T? {
        return sequence(first: self) { $0.next }
            .dropFirst()
            .first { $0 is T } as? T
    }
}

class AboutLevels {
    var nowPanel : Int = 0
}

class SinglePlayerViewController : UIViewController, Callable {
    
    var levelPanel : PanelsScrollView = PanelsScrollView()
    var backButton: UIButton = UIButton()
    static let stack = DataBaseController()
    private typealias SPVC = SinglePlayerViewController
    
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
        levelPanel = PanelsScrollView(frame: getRect(parentFrame: view.bounds,
                                                     params: AllParameters(centerPoint: CGPoint(x: 0.5, y: 0.4),
                                                                           k: k_scroll , square: 0.6)),
                                      panelsNumber: 5, margins: margins);
        view.addSubview(levelPanel)
        backButton = view.addButton(label: "Back", target: self, selector: #selector(toMenuScreen),
                                    params: AllParameters(centerPoint: CGPoint(x: 0.8, y: 0.9), k: 1.25, square: 0.005))
        
        let request: NSFetchRequest<Statistics> = Statistics.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "levelNumber", ascending: true)]
        
        SPVC.stack.context.perform {
            let request: NSFetchRequest<Statistics> = Statistics.fetchRequest()
            let contacts = try! request.execute()
            print(contacts)
        }
        //        let level0 = Statistics(context: SPVC.stack.context)
        //        level0.levelNumber = 0
        //        level0.stars = -1
        //        try! SPVC.stack.context.save()
        //
        //        let level1 = Statistics(context: SPVC.stack.context)
        //        level1.levelNumber = 1
        //        level1.stars = -1
        //        try! SPVC.stack.context.save()
        //
        //        let level2 = Statistics(context: SPVC.stack.context)
        //        level2.levelNumber = 2
        //        level2.stars = -1
        //        try! SPVC.stack.context.save()
    }
    
    func call(number: Int) {
        print("to level: ", number)
        (navigationController as! MainNavigationController).toGameSceneViewController()
    }
    
    @objc func toMenuScreen() {
        navigationController?.popViewController(animated: true)
    }
}

