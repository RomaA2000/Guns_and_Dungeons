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
    
    var levelPanel : PanelsScrollView<PanelButton>!
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
        levelPanel = PanelsScrollView(parrentBounds: view.bounds, panelsNumber: 5, elementsPerPanel: 4)
        view.addSubview(levelPanel)
        
        var statistics: [Statistics] = []
        let request: NSFetchRequest<Statistics> = Statistics.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "levelNumber", ascending: false)]
        do {
            statistics = try SPVC.stack.context.fetch(request)
        }
        catch {
            statistics = []
        }
        
        let panelFrame: CGRect = levelPanel.panels.first!.frame
        let buttonFrame: CGRect = CGRect(origin: CGPoint(),
                                         size: getRectSize(parentFrame: panelFrame, params: SizeParameters(k: 1.5, square: 0.08)))
        
        var buttonsParams : [PanelButtonParams] = []
        for number in 0..<levelsNumber {
            if (number < statistics.count) {
                buttonsParams.append(makeUnlockedButtonParams(number: number, stars: Int(statistics[number].stars)))
            }
            else if (number == statistics.count) {
                buttonsParams.append(makeUnlockedButtonParams(number: number, stars: 0))
            }
            else {
                buttonsParams.append(makeLockedButtonParams())
            }
        }
        levelPanel.createElementsOnPanels(params: buttonsParams)
    }
    
    func makeLockedButtonParams() -> PanelButtonParams {
        let lockedImage = UIImage(named: "locked")
        let location: LocationParameters = LocationParameters(centerPoint: CGPoint.zero, k: 1.5, square: 0.06)
        let buttonParams = ButtonParams(location: location, defaultTexture: lockedImage, pressedTexture: nil, label: "")
        return PanelButtonParams(buttonParams: buttonParams)
    }
    
    func makeUnlockedButtonParams(number: Int, stars: Int = 0) -> PanelButtonParams {
        let unlockedImage = UIImage(named: "unlocked")
        let starImage = UIImage(named: "star")
        let location: LocationParameters = LocationParameters(centerPoint: CGPoint.zero, k: 1.5, square: 0.06)
        let buttonParams = ButtonParams(location: location, defaultTexture: unlockedImage, pressedTexture: nil)
        let panelButtonParams = PanelButtonParams(buttonParams: buttonParams, starTexture: starImage, number: number, stars: stars)
        return panelButtonParams
    }
    
    func updateLevelButton(number: Int, stars: Int = 0) {
        levelPanel.setElement(number: number, params: makeUnlockedButtonParams(number: number, stars: stars))
    }
    
    func setStatistics(levelStatistics: LevelStatistics) {
        let statistics: [Statistics] = getStatistics()
        if (levelStatistics.levelNumber == statistics.count) {
            updateLevelButton(number: levelStatistics.levelNumber, stars: levelStatistics.stars)
            saveStatistics(levelStatistics: levelStatistics)
            updateLevelButton(number: levelStatistics.levelNumber + 1)
        }
        else if (levelStatistics.stars > statistics[levelStatistics.levelNumber].stars) {
            updateLevelButton(number: levelStatistics.levelNumber, stars: levelStatistics.stars)
            saveStatistics(levelStatistics: levelStatistics)
        }
    }
    
    func saveStatistics(levelStatistics: LevelStatistics) {
        SPVC.stack.context.perform {
            let updatedStatistics = Statistics(context: SPVC.stack.context)
            updatedStatistics.levelNumber = Int16(levelStatistics.levelNumber)
            updatedStatistics.stars = Int16(levelStatistics.stars)
            try! SPVC.stack.context.save()
        }
    }
    
    func getStatistics() -> [Statistics] {
        var statistics: [Statistics] = []
        let request: NSFetchRequest<Statistics> = Statistics.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "levelNumber", ascending: false)]
        statistics = try! SPVC.stack.context.fetch(request)
        return statistics
    }
    
    func call(number: Int) {
        print("to level: ", number + 1)
        (navigationController as! MainNavigationController).toGameSceneViewController(levelNumber: number)
    }
    
    @objc func toMenuScreen() {
        navigationController?.popViewController(animated: true)
    }
}

