//
//  Model.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/10/27.
//

import Foundation

class Model{
    
    private var event: Event
    
    private var player: Player
    private var monster: Monster
    private var text: String
    private var animateFlag: Bool
    private var animateEventType: EventType
    
    weak var view: ViewProtocol?
    
    init(playerName: String){
        self.event = Event()
        self.player = Player(name: playerName)
        self.monster = Monster()
        self.text = ""
        self.animateFlag = false
        self.animateEventType = .animate(.no)
        
        self.event.delegate = self
        self.event.append(event: .system(.first))
        _ = self.textLoad()
    }
    
    private func viewLoad(){
        guard let view = view else {
            return
        }
        view.viewLoad()
    }
    
    func textLoad() -> Bool{
        if self.event.isEmpty() {
            return false
        }
        let gameText = self.event.getGameText()
        self.text = gameText.text
        self.animateEventType = gameText.animate
        self.animateFlag = true
        self.viewLoad()
        return true
    }
    
    func getText() -> String{
        return self.text
    }
    
    func getMonsterImage() -> String{
        return self.monster.getImage()
    }
    
    func playerAttack() -> Bool{
        if !self.event.isEmpty() {
           return false
        }
        self.event.append(event: .player(.attack))
        _ = self.textLoad()
        return true
    }
    
    func playerEscape() -> Bool{
        if !self.event.isEmpty() {
           return false
        }
        self.event.append(event: .player(.escape))
        _ = self.textLoad()
        return true
    }
    
    func getAnimateFlag() -> Bool {
        let bool = self.animateFlag
        self.animateFlag = false
        return bool
    }
    
    func getAnimateEventType() -> EventType {
        return self.animateEventType
    }
}

extension Model: EventProtocol{
    
    func getPlayerName() -> String {
        return self.player.getName()
    }
    
    func getMonsterName() -> String {
        return self.monster.getName()
    }
    
    func getPlayer() -> Player {
        return self.player
    }
    
    func getMonster() -> Monster {
        return self.monster
    }
    
    func setPlayer(player: Player) {
        self.player = player
    }
    
    func setMonster(monster: Monster) {
        self.monster = monster
    }
}
