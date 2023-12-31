//
//  EventType.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/10/27.
//

import Foundation

indirect enum EventType{
    
    case text
    
    case system(EventType)
    
    case first
    case last
    
    case player(EventType)
    case monster(EventType)
    
    case attack
    case escape
    case respawn
    case death
    case walk
    case levelUP
    case event
    
    case animate(EventType)
    case no
    case load
}
