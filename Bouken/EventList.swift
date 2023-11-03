//
//  EventList.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/10/27.
//

import Foundation

class EventList{
    
    private var list: [Event] = []
    
    func append(event: Event) {
        self.list.append(event)
    }
}
