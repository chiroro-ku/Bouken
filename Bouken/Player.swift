//
//  Player.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/10/27.
//

import Foundation

class Player{
    
    private var name: String
    private var lv: Int
    private var maxHP: Int
    private var hp: Int
    
    init(name: String){
        self.name = name
        self.lv = 1
        self.maxHP = 100
        self.hp = 100
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getLv() -> Int {
        return self.lv
    }
    
    func getHP() -> Int {
        return self.hp
    }
    
    func getMaxHP() -> Int{
        return self.maxHP
    }
    
    func receiveDamage(value: Int) -> Bool{
        self.hp -= value
        if self.hp < 0 {
            self.hp = 0
        }
        return self.hp <= 0
    }
}
