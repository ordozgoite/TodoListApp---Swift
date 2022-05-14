//
//  TodoItem.swift
//  Todoey
//
//  Created by Victor Ordozgoite on 13/05/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

class TodoItem {
    let text: String
    var isDone: Bool
    
    init(text: String) {
        self.text = text
        self.isDone = false
    }
}
