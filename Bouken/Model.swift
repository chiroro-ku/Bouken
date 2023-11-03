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
    
    weak var view: ViewProtocol?
    
    init(playerName: String){
        self.event = Event()
        self.player = Player(name: playerName)
        self.monster = self.event.respawnMonster()
        
        self.event.delegate = self
        self.event.append(event: .system(.first))
    }
    
    private func viewLoad(){
        guard let view = view else {
            return
        }
        view.viewLoad()
    }
    
    func getText() -> String?{        
        if self.event.isEmpty() {
            return nil
        }
        return self.event.getText()
    }
    
    func getMonsterImage() -> String{
        return self.monster.getImage()
    }
    
    func playerAttack(){
        if !self.event.isEmpty() {
           return
        }
        self.event.append(event: .player(.attack))
        self.viewLoad()
    }
    
    func playerEscape(){
        if !self.event.isEmpty() {
           return
        }
        self.event.append(event: .player(.escape))
        self.viewLoad()
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
    
    func setMonster(monster: Monster) {
        self.monster = monster
    }
    
}
