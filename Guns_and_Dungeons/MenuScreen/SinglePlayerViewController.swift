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
    
    var levelPanel : PanelsScrollView = PanelsScrollView<PanelButton>()
    var backButton: UIButton = UIButton()
    static let stack = DataBaseController()
    private typealias SPVC = SinglePlayerViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        backButton = view.addButton(label: "Back", target: self, selector: #selector(toMenuScreen),
                                    params: LocationParameters(centerPoint: CGPoint(x: 0.8, y: 0.9), k: 1.25, square: 0.005))
        makePanelScrollView(levelsNumber: 20, levelsPerPanel: 4)
    }
    
    func makePanelScrollView(levelsNumber: Int, levelsPerPanel: Int) {
        levelPanel = PanelsScrollView(parrentBounds: view.bounds, panelsNumber: levelsNumber / levelsPerPanel)
        view.addSubview(levelPanel)
        
        var statistics: [Statistics] = []
        
        SPVC.stack.context.perform {
            let request: NSFetchRequest<Statistics> = Statistics.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "levelNumber", ascending: true)]
            statistics = try! request.execute()
        }
        
        let panelFrame: CGRect = levelPanel.panels.first!.frame
        let buttonFrame: CGRect = CGRect(origin: CGPoint(),
                                         size: getRectSize(parentFrame: panelFrame, params: SizeParameters(k: 1.5, square: 0.08)))
        
        let buttonsPerPanel: Int = 4
        let lockedImage: UIImage? =  UIImage(named: "locked")
        let unlockedImage: UIImage? = nil //UIImage(named: "unlocked")
        for panelNumber in 0..<levelPanel.panels.count {
            var levelButtons: [PanelButton] = []
            for buttonOnPanelNumber in 0..<buttonsPerPanel {
                let number: Int = panelNumber * buttonsPerPanel + buttonOnPanelNumber
                let buttonParams: ButtonParams = ButtonParams(frame: buttonFrame, defaultTexture: lockedImage, pressedTexture: nil, label: "Level \(number + 1)")
                let panelButtonParams: PanelButtonParams = PanelButtonParams(buttonParams: buttonParams, starTexture: nil, number: number, stars: 3)
                let button: PanelButton = PanelButton(params: panelButtonParams)
                levelButtons.append(button)
            }
            levelPanel.panels[panelNumber].addViews(views: levelButtons)
        }
    }
    
    func setStatistics(statistics: LevelStatistics) {
        print("saving")
        SPVC.stack.context.perform {
            let request: NSFetchRequest<Statistics> = Statistics.fetchRequest()
            let dataBaseLevelStatistiks = try! request.execute()
            if (dataBaseLevelStatistiks.count < statistics.levelNumber) {
                let updatedStatistics = Statistics(context: SPVC.stack.context)
                updatedStatistics.levelNumber = Int16(statistics.levelNumber)
                updatedStatistics.stars = Int16(statistics.stars)
                do {
                    try SPVC.stack.context.save()
                }
                catch {
                    print("Unexpected error while  saving")
                }
            }
        }
    }
    
    func call(number: Int) {
        print("to level: ", number + 1)
        (navigationController as! MainNavigationController).toGameSceneViewController(levelNumber: number + 1)
    }
    
    @objc func toMenuScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("deinit vc")
    }
}

