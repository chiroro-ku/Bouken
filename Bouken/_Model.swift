//
//  Model.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/10/27.
//

import Foundation

class _Model{
    
    var eventList: EventList?
    var textList: TextList?
    
    weak var view: ViewProtocol?
    
    init() {
//        let firstText = textList.getFirstTextList()
//        self.eventList.setTextEvent(textList: firstText)
        
        let monsterRespawnEvent = Event(eventType: .system(.monster(.respawn)))
//        self.eventList.appendEvent(events: [monsterRespawnEvent])
    }
    
    private func viewLoad(){
        guard let view = view else {
            return
        }
        view.viewLoad()
    }
    
    func getText() -> String{
        let (event, _ ) = self.eventList.getEventAndNextEvent()
        return event.getText()
    }
    
    func playerAttack(){
//        if !self.isTextListEnd() {
//            return
//        }
//        let textList = self.textList.getAttackTextList(playerName: "冒険者")
//        self.eventList.appendTextEvent(textList: textList)
        let attackEvent = Event(eventType: .player(.attack))
        self.eventList.appendEvent(events: [attackEvent])
        self.viewLoad()
    }
    
    func playerEscape(){
//        if !self.isTextListEnd() {
//            return
//        }
//        let textList = self.textList.getEscapeTextList(playerName: "冒険者")
//        self.eventList.appendTextEvent(textList: textList)
        let attackEvent = Event(eventType: .player(.escape))
        self.eventList.appendEvent(events: [attackEvent])
        self.viewLoad()
    }
    
    private func eventModel(){
        let (event, nextEvent) = self.eventList.getEventAndNextEvent()
        
        let eventList: [Event] = []
        switch event.getEventType(){
        case .system(.first):
//            let firstText = self.textList.getFirstTextList()
//            eventList.setTextEvent(textList: firstText)
            break
        default:
            break
        }
    }
}
