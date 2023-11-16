//
//  Monster.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/10/30.
//

import Foundation

class Monster{
    private var name: String
    private var ration: Int
    private var damege: Int
    private var image: String
    private var event: String
    
    init(){
        self.name = "-"
        self.ration = 0
        self.damege = 0
        self.image = "error"
        self.event = "error"
    }
    
    init(data: String) {
        let datas = data.components(separatedBy: ",")
        self.name = datas[0]
        self.ration = Int(datas[1]) ?? 0
        self.damege = Int(datas[2]) ?? 0
        self.image = datas[3]
        self.event = datas[4]
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getRation() -> Int {
        return self.ration
    }
    
    func getDamege() -> Int {
        return self.damege
    }
    
    func getImage() -> String {
        return self.image
    }
}
