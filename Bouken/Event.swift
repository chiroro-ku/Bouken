//
//  Event.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/10/27.
//

import Foundation

class Event{
    
    private var monsterData: MonsterData = MonsterData()
    private var textData: TextData = TextData()
    private var textList: GameText = GameText()
    private var eventList: [EventType] = []
    
    var delegate: EventProtocol? {
        didSet{
            self.textData.delegate = self.delegate
        }
    }
    
    func append(event: EventType){
        self.append(eventList: [event])
    }
    
    func append(eventList: [EventType]){
        self.eventList += eventList
        self.textListLoad()
    }
    
    func getEvent() -> EventType{
        return self.eventList.removeFirst()
    }
    
    func getGameText() -> GameText{
        self.textListLoad()
        return self.textList.getGameText()
    }
    
    func textListLoad() {
        self.printData()
        if !self.textList.isEmpty() {
            return
        }
        let eventType = self.getEvent()
        switch eventType {
        case .system(.first):
            self.textList = self.textData.getTextList(eventType: eventType)
            self.append(event: .monster(.respawn))
            break
        case .monster(.respawn):
            self.respawnMonster()
            
            self.textList = self.textData.getTextList(eventType: eventType)
            break
        case .monster(.attack):
            self.playerReceiveDamage()
            
            self.textList = self.textData.getTextList(eventType: eventType)
            self.append(event: .monster(.respawn))
            break
        case .monster(.death):
            self.playerLevelUp()
            
            self.textList = self.textData.getTextList(eventType: eventType)
            self.append(event: .monster(.respawn))
            break
        case .player(.attack):
            self.textList = self.textData.getTextList(eventType: eventType)
            guard let bool = self.isPlayerAttack() else {
                return
            }
            let event: EventType = bool ? .monster(.death) : .monster(.attack)
            self.append(event: event)
            break
        case .player(.escape):
            self.playerEscape()
            
            self.textList = self.textData.getTextList(eventType: eventType)
            self.append(event: .monster(.respawn))
            break
        case .player(.death):
            self.textList = self.textData.getTextList(eventType: eventType)
            break
        case .system(.last):
            self.textList = self.textData.getTextList(eventType: eventType)
            break
        default:
            break
        }
    }
    
    func isEmpty() -> Bool {
        return self.textList.isEmpty() && self.eventList.isEmpty
    }
    
    func respawnMonster() {
        let monster = self.monsterData.getRandomMonster()
        guard let delegate = self.delegate else {
            return
        }
        delegate.setMonster(monster: monster)
    }
    
    func printData(){
        Swift.print(self.textList.getTextList())
        Swift.print(self.eventList)
    }
    
    private func isPlayerAttack() -> Bool?{
        guard let delegate = self.delegate else {
            return nil
        }
        let player = delegate.getPlayer()
        let monster = delegate.getMonster()
        let monsterRation = monster.getRation()
        let playerLv = player.getLv()
        let ration = monsterRation - playerLv
        let random = Int.random(in: 0..<100)
        let bool = random > ration

        return bool
    }
    
    private func playerReceiveDamage(escape: Bool = false) {
        guard let delegate = self.delegate else {
            return
        }
        let player = delegate.getPlayer()
        if escape{
            player.escape()
        }else{
            let monster = delegate.getMonster()
            let damege = monster.getDamege()
            player.receiveDamage(value: damege)
        }
        delegate.setPlayer(player: player)

        if player.death {
            self.eventList.append(.system(.last))
        }
    }
    
    private func playerLevelUp() {
        guard let delegate = self.delegate else {
            return
        }
        let player = delegate.getPlayer()
        player.levelUP()
        delegate.setPlayer(player: player)
    }
    
    private func playerEscape() {
        self.playerReceiveDamage(escape: true)
    }
}
