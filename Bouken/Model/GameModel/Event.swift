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
    private var monsterList: [Monster]
    
    var model = Model(){
        didSet{
            self.textData.model = self.model
        }
    }
    
    init(){
        self.textList = []
        self.eventList = []
        self.monsterList = []
//        self.textData.model = self.model
        
        self.monsterData.delegete = self
        
        /*
        if let monster = self.monsterData.getMonster(name: "水ゴースト") {
            self.monsterList.append(monster)
        }
         */
        /*
        if let monster = self.monsterData.getMonster(name: "ム゛▼イ゛マ゛ゃ") {
            self.monsterList.append(monster)
        }
         */
        /*
        if let monster = self.monsterData.getMonster(name: "ワンコ") {
            self.monsterList.append(monster)
        }
         */
        if let monster = self.monsterData.getMonster(name: "ゴールド骨") {
            self.monsterList.append(monster)
        }
    }
    
    private func playerTakeDamege(damege: Int){
        self.model.player.takeDamege(damege: damege)
        if self.model.player.death {
            //
            self.append(event: .player(.death), top: true)
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
    
    func append(event: EventType, load: Bool = false, top: Bool = false, next: Bool = false){
        if !load && !top && !next {
            self.eventList.append(event)
        }
        if top {
            self.eventList = [event] + self.eventList
        }
        if load {
            self.eventList.append(event)
            self.loadEvent()
        }
        if next {
            let first = self.eventList.removeFirst()
            self.eventList = [first] + [event] + self.eventList
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
        self.model.monster?.appendEvent()
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
            self.model.player.levelUP()
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
            self.model.setMonster(monster: self.monsterList.randomElement())
            let text = self.textData.getText(event: event)
            self.append(text: text)
            self.append(index: 0, event: .animate(.monster(.respawn)))
            break
        case .monster(.event):
            self.model.monster?.loadEvent()
            break
        default:
            break
        }
    }
}

extension Event: MonsterProtocol{    
    func appendMonsterEvent() -> Bool{
        var bool = false
        guard let monster = self.model.monster else{
            return false
        }
        let eventName = monster.event
        let nextEvent = self.eventList[0]
        switch eventName{
        case "食べる":
            switch nextEvent{
            case .player(.attack):
                self.eventList.removeFirst()
                self.append(event: .monster(.event))
                bool = true
                break
            default:
                break
            }
            break
        case "ランダム":
            switch nextEvent{
            case .player(.attack):
                let lv = self.model.player.lv
                let random = Int.random(in: lv...lv+100)
                self.model.monster?.setRation(ration: random)
                bool = true
                break
            default:
                break
            }
            break
        case "魔法":
            switch nextEvent{
            case .player(.attack):
                self.append(event: .monster(.event), top: true)
                bool = true
                break
            default:
                break
            }
        case "俊敏":
            switch nextEvent{
            case .player(.escape):
                self.eventList.removeFirst()
                self.append(event: .monster(.event))
                bool = true
                break
            default:
                break
            }
        case "毒":
            switch nextEvent{
            case .player(.attack):
                self.eventList.removeFirst()
                self.append(event: .monster(.event))
                bool = true
                break
            default:
                break
            }
            break
        case "経験値UP":
            switch nextEvent{
            case .player(.levelUP):
                self.append(event: .monster(.event), next: true)
                bool = true
                break
            default:
                break
            }
            break
        default:
            break
        }
        return bool
    }
    
    func loadMonsterEvent(){
        guard let monster = self.model.monster else{
            return
        }
        let eventName = monster.event
        switch eventName{
        case "食べる":
            let damage = self.model.player.maxHP
            self.model.player.takeDamege(damege: damage)
            let text = self.textData.getText(event: .monster(.event))
            self.append(text: text, load: true)
            self.append(index: 2, event: .animate(.monster(.event)))
            self.append(event: .system(.last))
            break
        case "魔法":
            guard let eventValue = self.model.monster?.eventValue, let damege = Int(eventValue) else{
                return
            }
            self.playerTakeDamege(damege: damege)
            let text = self.textData.getText(event: .monster(.event))
            self.append(text: text, load: true)
            self.append(index: 0, event: .animate(.monster(.event)))
            break
        case "俊敏":
            guard let eventValue = self.model.monster?.eventValue, let damege = Int(eventValue) else{
                return
            }
            self.playerTakeDamege(damege: damege)
            let text = self.textData.getText(event: .monster(.event))
            self.append(text: text, load: true)
            self.append(index: 0, event: .animate(.monster(.event)))
            let nextEvent: [EventType] = [.player(.walk), .monster(.respawn)]
            self.append(eventList: nextEvent)
            break
        case "毒":
            let player = self.model.player
            self.model.monster?.takeAttack(player: player)
            if monster.death {
                guard let eventValue = self.model.monster?.eventValue, let damege = Int(eventValue) else{
                    return
                }
                self.playerTakeDamege(damege: damege)
                self.append(event: .player(.levelUP))
            }else{
                self.playerTakeDamege(damege: monster.damege)
            }
            let text = self.textData.getText(event: .monster(.event))
            self.append(text: text, load: true)
            let animateEvent: EventType = monster.death ? .animate(.monster(.event)) : .animate(.monster(.attack))
            self.append(index: 0, event: animateEvent)
            if monster.death {
                self.append(index: 2, event: .system(.load))
            }
            let nextEvent: [EventType] = [.player(.walk), .monster(.respawn)]
            self.append(eventList: nextEvent)
            break
        case "経験値UP":
            guard let eventValue = self.model.monster?.eventValue, let levelUPValue = Int(eventValue) else{
                return
            }
            self.model.player.levelUP(value: levelUPValue)
            let text = self.textData.getText(event: .monster(.event))
            self.append(text: text)
            self.append(index: 0, event: .animate(.monster(.event)))
            break
        default:
            break
        }
    }
}
