//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Michael Duong on 1/17/18.
//  Copyright © 2018 Turnt Labs. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {

    var entry: Entry?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBAction func userTappedBackground(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func clearEntryBtn(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }

    @IBAction func saveButton(_ sender: Any) {
        guard let entryTitle = titleTextField.text,
            let entryBody = bodyTextView.text,
            !entryTitle.isEmpty,
            !entryBody.isEmpty else { return }
        if let entry = self.entry {
            EntryController.shared.updateEntry(title: entryTitle, body: entryBody, entry: entry)
            
        }
        else {
            EntryController.shared.addEntryWith(title: entryTitle, text: entryBody)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        bodyTextView.resignFirstResponder()
        return true
    }
    
    func updateViews() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextView.text = entry.bodyText
    }



}
