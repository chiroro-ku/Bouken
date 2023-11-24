//
//  Event.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/11/21.
//

import Foundation

class Event{
    
    private var textData = TextData()
    private var monsterData = MonsterData()
    
    private var textList: [GameText]
    private var eventList: [EventType]
    
    var model = Model(){
        didSet{
            self.textData.model = self.model
        }
    }
    
    init(){
        self.textList = []
        self.eventList = []
//        self.textData.model = self.model
    }
    
    private func playerTakeDamege(damege: Int){
        self.model.player.takeDamege(damege: damege)
        if self.model.player.death {
            self.append(event: .player(.death))
        }
    }
    
    private func append(text: String, load: Bool = false){
        if load {
            self.textList = []
        }
        let textList = text.components(separatedBy: ",")
        for text in textList{
            let gameText = GameText(text: text)
            self.textList.append(gameText)
        }
    }
    
    private func append(index: Int, event: EventType){
        self.textList[index].event = event
    }
    
    func append(event: EventType, load: Bool = false, top: Bool = false){
        if top {
            self.eventList = [event] + self.eventList
        }else{
            self.eventList.append(event)
        }
        if load {
            self.loadEvent()
        }
    }
    
    func append(eventList: [EventType]){
        for event in eventList{
            self.append(event: event)
        }
    }
    
    func getGameText() -> GameText?{
        if self.textList.isEmpty{
            self.loadEvent()
            if self.textList.isEmpty{
                return nil
            }
        }
        return self.textList.removeFirst()
    }
    
    func loadEvent(){
        if self.eventList.isEmpty{
            return
        }
        let event = self.eventList.removeFirst()
        switch event{
        case .system(.first):
            let text = self.textData.getText(event: event)
            self.append(text: text)
            break
        case .system(.last):
            let text = "no text"
            self.append(text: text)
            self.append(index: 0, event: .system(.last))
            break
        case .player(.walk):
            self.model.setMonster(monster: nil)
            let text = self.textData.getText(event: event)
            self.append(text: text)
            break
        case .player(.attack):
            let player = self.model.player
            self.model.monster?.takeAttack(player: player)
            guard let monster = self.model.monster else {
                return
            }
            if monster.death {
                self.append(event: .player(.levelUP))
                self.model.player.levelUP()
            }else{
                self.playerTakeDamege(damege: monster.damege)
            }
            let text = self.textData.getText(event: event)
            self.append(text: text, load: true)
            let animateEvent: EventType = monster.death ? .animate(.monster(.death)) : .animate(.monster(.attack))
            self.append(index: 0, event: animateEvent)
            let nextEvent: [EventType] = [.player(.walk), .monster(.respawn)]
            self.append(eventList: nextEvent)
            break
        case .player(.escape):
            self.playerTakeDamege(damege: 10)
            let text = self.textData.getText(event: event)
            self.append(text: text, load: true)
            self.append(index: 0, event: .animate(event))
            let nextEvent: [EventType] = [.player(.walk), .monster(.respawn)]
            self.append(eventList: nextEvent)
            break
        case .player(.levelUP):
            let text = self.textData.getText(event: event)
            self.append(text: text)
            self.append(index: 0, event: .animate(.player(.levelUP)))
            break
        case .player(.death):
            let text = self.textData.getText(event: event)
            self.append(text: text)
            self.append(index: 0, event: .animate(.player(.death)))
            self.append(event: .system(.last), top: true)
            break
        case .monster(.respawn):
            self.model.setMonster(monster: self.monsterData.getRandomMonster())
            let text = self.textData.getText(event: event)
            self.append(text: text)
            self.append(index: 0, event: .animate(.monster(.respawn)))
            break
        default:
            break
        }
    }
}
