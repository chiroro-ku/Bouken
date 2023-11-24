//
//  GameText.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/11/21.
//

import Foundation

class GameText{
    var text: String
    var event: EventType
    
    init(text: String, event: EventType = .animate(.no)){
        self.text = text
        self.event = event
    }
}
