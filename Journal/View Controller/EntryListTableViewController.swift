//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by Michael Duong on 1/17/18.
//  Copyright © 2018 Turnt Labs. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.shared.entries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // get a journal entry
        let entry = EntryController.shared.entries[indexPath.row]
        
        // get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        // format the cell
        cell.textLabel?.text = entry.title
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = self.tableView.backgroundColor
        cell.detailTextLabel?.textColor = UIColor.white
        cell.detailTextLabel?.text = DateFormatter.localizedString(from: entry.timestamp, dateStyle: .short, timeStyle: .short)
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entryToDelete = EntryController.shared.entries[indexPath.row]
            EntryController.shared.deleteEntry(entry: entryToDelete)
            tableView.reloadData()
        }
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //identify
        if segue.identifier == "toEdit" {
            
        //destination
        guard let toEdit = segue.destination as? EntryDetailViewController else { return }
            
        //location of index
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
        let entryId = EntryController.shared.entries[indexPath.row]
            
        //update cell
        toEdit.entry = entryId
            
        }
    }


}
