//
//  Task.swift
//  ToDo_CRUD_POC
//
//  Created by Sandesh on 23/03/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//


import Foundation

class Task: NSObject, NSCoding {
    
    var name: String?
    var isDone: Bool?
    
    private let nameKey = NAME_KEY
    private let isDoneKey = IS_DONE_KEY
    
    init(name: String, isDone: Bool = false) {
        self.name = name;
        self.isDone = isDone;
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: nameKey)
        aCoder.encode(isDone, forKey: isDoneKey)
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: nameKey) as? String,
              let isDone = aDecoder.decodeObject(forKey: isDoneKey) as? Bool
              else { return }
        
        self.name = name
        self.isDone = isDone
    }
}
