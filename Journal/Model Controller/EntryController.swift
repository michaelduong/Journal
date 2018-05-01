//
//  EntryController.swift
//  Journal
//
//  Created by Michael Duong on 1/17/18.
//  Copyright © 2018 Turnt Labs. All rights reserved.
//

import Foundation

class EntryController {
    static let shared = EntryController()
    var entries: [Entry] = []
   
    init() {
        
        self.entries = loadToPersistentData()
    }
    
// CRUD
    
    // CREATE
    func addEntryWith(title: String, text: String) {
        let newEntry = Entry(title: title, bodyText: text)
        entries.append(newEntry)
        saveToPersistentData()
    }
    
    // UPDATE
    func updateEntry(title: String, body: String, entry: Entry) {
      entry.bodyText = body
      entry.title = title
      saveToPersistentData()
    }
    // DESTROY
    func deleteEntry(entry: Entry) {
        guard let index = entries.index(of: entry) else { return }
        entries.remove(at: index)
        saveToPersistentData()
    }
    
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let fileName = "journal.json"
        
        let documentsURL = urls[0].appendingPathComponent(fileName)
        
        return documentsURL
    }
    
    // SAVE
    func saveToPersistentData() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let data = try jsonEncoder.encode(entries)
            try data.write(to: fileURL())
            
        } catch {
            print("Error while saving: \(error.localizedDescription)")
        }
        
    }
    
    
    // LOAD
    func loadToPersistentData() -> [Entry] {
        do {
            let data = try Data(contentsOf: fileURL())
            let jsonDecoder = JSONDecoder()
            let entry = try jsonDecoder.decode([Entry].self, from: data)
            
            return entry
        } catch {
            print("Error while loading: \(error.localizedDescription)")
            return []
        }
        
    }
}


