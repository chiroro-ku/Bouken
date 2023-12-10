//
//  Player.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/11/21.
//

import Foundation
class Player{
    private(set) var name: String
    private(set) var lv: Int
    private(set) var maxHP: Int
    private(set) var hp: Int {
        didSet{
            if self.hp > self.maxHP {
                self.hp = self.maxHP
            }else if self.hp <= 0{
                self.hp = 0
            }
        }
    }
    
    var death: Bool{
        get{
            self.hp <= 0
        }
    }
    
    init(name: String, lv: Int = 1, maxHP: Int = 100, hp: Int = 100) {
        self.name = name
        self.lv = lv
        self.maxHP = maxHP
        self.hp = hp
    }
    
    func takeDamege(damege: Int){
        self.hp -= damege
    }
    
    func escape(){
        self.takeDamege(damege: 10)
    }
    
    func levelUP(){
        self.lv += 1
        self.maxHP += 10
        self.hp += 30
    }
}
