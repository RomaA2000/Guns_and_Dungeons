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
    var levelsPerPanel: Int = 4
    var levelsNumber: Int = 20
    private typealias SPVC = SinglePlayerViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        backButton = view.addButton(label: "Back", target: self, selector: #selector(toMenuScreen),
                                    params: LocationParameters(centerPoint: CGPoint(x: 0.8, y: 0.9), k: 1.25, square: 0.005))
        levelsNumber = 20
        levelsPerPanel = 4
        makePanelScrollView()
    }
    
    func makePanelScrollView() {
        levelPanel = PanelsScrollView(parrentBounds: view.bounds, panelsNumber: levelsNumber / levelsPerPanel)
        view.addSubview(levelPanel)
        
        var statistics: [Statistics] = []
        
        let request: NSFetchRequest<Statistics> = Statistics.fetchRequest()
        
        do {
            statistics = try SPVC.stack.context.fetch(request)
        }
        catch {
            statistics = []
        }
        
        print("stat: ", statistics.count)
        let panelFrame: CGRect = levelPanel.panels.first!.frame
        let buttonFrame: CGRect = CGRect(origin: CGPoint(),
                                         size: getRectSize(parentFrame: panelFrame, params: SizeParameters(k: 1.5, square: 0.08)))
        
        let lockedImage: UIImage? = UIImage(named: "locked")
        let unlockedImage: UIImage? = UIImage(named: "unlocked")
        let starImage: UIImage? = UIImage(named: "star")
        
        var buttons : [PanelButton] = []
        var panelNumber = 0
        
        // Unlocked levels
        for number in 0..<statistics.count {
            if buttons.count == levelsPerPanel {
                addButtonsToPanel(panelNumber: &panelNumber, buttons: &buttons)
            }
            let stars = Int(statistics[number].stars)
            let buttonParams = ButtonParams(frame: buttonFrame, defaultTexture: unlockedImage, pressedTexture: nil)
            let panelButtonParams = PanelButtonParams(buttonParams: buttonParams, starTexture: starImage, number: number, stars: stars)
            let unlockedButton = PanelButton(params: panelButtonParams)
            buttons.append(unlockedButton)
        }
        
        // Last unlocked
        let buttonParams = ButtonParams(frame: buttonFrame, defaultTexture: unlockedImage, pressedTexture: nil)
        let panelButtonParams = PanelButtonParams(buttonParams: buttonParams, starTexture: starImage, number: statistics.count)
        let lastUnlocked = PanelButton(params: panelButtonParams)
        buttons.append(lastUnlocked)
        
        // Locked levels
        for _ in statistics.count + 1 ... levelsNumber {
            if buttons.count == levelsPerPanel {
                addButtonsToPanel(panelNumber: &panelNumber, buttons: &buttons)
            }
            let buttonParams = ButtonParams(frame: buttonFrame, defaultTexture: lockedImage, pressedTexture: nil, label: "")
            let panelButtonParams = PanelButtonParams(buttonParams: buttonParams, starTexture: starImage)
            let lockedButton = PanelButton(params: panelButtonParams)
            buttons.append(lockedButton)
        }
    }
    
    func addButtonsToPanel(panelNumber: inout Int, buttons: inout [PanelButton]) {
        levelPanel.panels[panelNumber].addSubviewsEvenly(views: buttons)
        buttons = []
        panelNumber += 1
    }
    
    func updateLevelButton(number: Int, stars: Int = 0) {
        let button = levelPanel.panels[number / levelsPerPanel].panelSubviews[number % levelsPerPanel] as! PanelButton
        button.setStars(stars: stars)
        guard number + 1 < levelsNumber else { return }
        let nextButton = levelPanel.panels[(number + 1) / levelsPerPanel].panelSubviews[(number + 1) % levelsPerPanel] as! PanelButton
        
    }
    
    func setStatistics(statistics: LevelStatistics) {
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
                self.updateLevelButton(number: Int(updatedStatistics.levelNumber - 1), stars: Int(updatedStatistics.stars))
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
}

