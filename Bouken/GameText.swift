//
//  GameText.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/11/13.
//

import Foundation

class GameText{
    private var textList: [String]
    private var animateList: [EventType] = []
    
    var text: String {
        get{
            self.textList[0]
        }
        set{
            self.textList.append(newValue)
        }
    }
    var animate: EventType {
        get{
            self.animateList[0]
        }
        set{
            self.animateList.insert(newValue, at: 0)
        }
    }
    
    init() {
        self.textList = []
    }
    
    init(text: String){
        self.textList = text.components(separatedBy: ",")
        for _ in textList{
            self.animateList.append(.animate(.no))
        }
    }
    
    func setAnimate(index: Int, eventType: EventType){
        self.animateList.insert(eventType, at: index)
    }
    
    func setAnimate(text: String, eventType: EventType){
        guard let index = self.textList.firstIndex(of: text) else {
            return
        }
        self.setAnimate(index: index, eventType: eventType)
    }
    
    func getText() -> String {
        return self.textList.removeFirst()
    }
    
    func getAnimate() -> EventType{
        if self.animateList.isEmpty {
            return .animate(.no)
        }
        return self.animateList.removeFirst()
    }
    
    func append(text: String){
        self.textList += text.components(separatedBy: ",")
    }
    
    func getGameText() -> GameText {
        let text = self.getText()
        let animate = self.getAnimate()
        let gameText = GameText(text: text)
        gameText.animate = animate
        return gameText
    }
    
    func isEmpty() -> Bool {
        return self.textList.isEmpty
    }
    
    func getTextList() -> [String] {
        return self.textList
    }
}
