//
//  Entry.swift
//  Journal
//
//  Created by Michael Duong on 1/17/18.
//  Copyright © 2018 Turnt Labs. All rights reserved.
//

import Foundation

class Entry: Equatable, Codable {
    
    var timestamp = Date()
    var title: String
    var bodyText: String
    
    init(timestamp: Date = Date(), title: String, bodyText: String) {
        self.title = title
        self.bodyText = bodyText
    }
    
    static func ==(lhs: Entry, rhs: Entry) -> Bool {
        return lhs.title == rhs.title && lhs.bodyText == rhs.bodyText && lhs.timestamp == rhs.timestamp
    }
}
