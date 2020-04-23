//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Leonardo Diaz on 4/22/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    //MARK: - Properties
    var task: Task? {
        didSet{
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    var dueDateValue: Date?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dueDateTextField.inputView = dueDatePicker
    }
    
    //MARK: - Actions
    /// DatePicker
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        dueDateTextField.text = sender.date.stringValue()
        dueDateValue = sender.date
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty else { return }
        if let task = task {
            TaskController.shared.update(task: task, name: name, notes: notesTextView.text, due: dueDateValue)
        } else {
            TaskController.shared.addTaskWithName(name: name, notes: notesTextView.text, due: dueDateValue)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    /// Tap Gesture
    @IBAction func userTappedView(_ sender: UITapGestureRecognizer) {
        self.nameTextField.resignFirstResponder()
        self.notesTextView.resignFirstResponder()
        self.dueDateTextField.resignFirstResponder()
    }

    //MARK: - Private Methods
    private func updateViews(){
        guard let task = task else {return}
        nameTextField.text = task.name
        dueDateTextField.text = task.due?.stringValue()
        dueDateValue = task.due
        notesTextView.text = task.notes
        title = task.name
    }
    
}
