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
    private var textList: [String] = []
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
    
    func getText() -> String{
        self.textListLoad()
        return self.textList.removeFirst()
    }
    
    func textListLoad() {
//        self.printData()
        if !self.textList.isEmpty {
            return
        }
        let eventType = self.getEvent()
        switch eventType{
        case .system(.first):
            self.textList += self.textData.getFirstTextList()
            self.append(event: .monster(.respawn))
            break
        case .monster(.respawn):
            let monster = self.respawnMonster()
            self.delegate?.setMonster(monster: monster)
            self.textList += self.textData.getMonsterRespawnTextList()
            break
        case .monster(.attack):
            self.textList += self.textData.getMonsterAttackTextList()
            guard let delegate = self.delegate else {
                return
            }
            let monster = delegate.getMonster()
            let damage = monster.getDamege()
            self.playerReceiveDamage(value: damage)
            self.append(event: .monster(.respawn))
            break
        case .monster(.death):
            self.textList += self.textData.getMonsterDeathTextList()
            self.append(event: .monster(.respawn))
            break
        case .player(.attack):
            self.textList += self.textData.getAttackTextList()
            guard let bool = self.isPlayerAttack() else {
                return
            }
            let event: EventType = bool ? .monster(.death) : .monster(.attack)
            self.append(event: event)
            break
        case .player(.escape):
            self.textList += self.textData.getEscapeTextList()
            self.playerEscape()
            self.append(event: .monster(.respawn))
            break
        case .player(.death):
            self.textList += self.textData.getPlayerDeath()
            break
        default:
            break
        }
        
    }
    
    func isEmpty() -> Bool {
        return self.textList.isEmpty && self.eventList.isEmpty
    }
    
    func respawnMonster() -> Monster{
        return self.monsterData.getRandomMonster()
    }
    
    func printData(){
        Swift.print(self.textList)
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
    
    private func playerReceiveDamage(value: Int) {
        guard let delegate = self.delegate else {
            return
        }

        if delegate.getPlayer().receiveDamage(value: value) {
            self.append(event: .player(.death))
        }
        Swift.print(delegate.getPlayer().getHP())
    }
    
    private func playerEscape() {
        self.playerReceiveDamage(value: 10)
    }
}
