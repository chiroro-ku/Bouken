//
//  Main.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/11/21.
//

import Foundation

class Main: Model{
    
    private var event: Event
    private var gameText: GameText
    
    weak var view: ViewProtocol?
    
    override init(playerName: String){
        self.event = Event()
        self.gameText = GameText(text: "no text")
        super.init(playerName: playerName)
        
        self.event.model = self
        let firstEventList: [EventType] = [.system(.first), .player(.walk), .monster(.respawn)]
        self.event.append(eventList: firstEventList)
    }
    
    private func loadView(){
        guard let view = self.view else{
            return
        }
        view.loadGameView()
    }
    
    func getGameText() -> GameText{
        return self.gameText
    }
    
    func loadEvent(){
        guard let gameText = self.event.getGameText() else{
            return
        }
        self.gameText = gameText
        self.loadView()
    }
    
    func playerAttack(){
        self.event.append(event: .player(.attack), load: true)
        self.loadEvent()
    }
    
    func playerEscape(){
        self.event.append(event: .player(.escape), load: true)
        self.loadEvent()
    }
}
