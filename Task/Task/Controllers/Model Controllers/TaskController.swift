//
//  TaskController.swift
//  Task
//
//  Created by Leonardo Diaz on 4/22/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    //MARK: - Shared Instance
    static let shared = TaskController()
    
    //MARK: - Source o Truth
    let fetchedResultsController: NSFetchedResultsController<Task>
    
    init() {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: true), NSSortDescriptor(key: "due", ascending: true)]
        let resultsController: NSFetchedResultsController<Task> = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
        
        fetchedResultsController = resultsController
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("There was an error fetching \(error.localizedDescription)")
        }
    }
    
    
    //MARK: - CRUD
    
    func toggleIsCompleteFor(task: Task){
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    
    func addTaskWithName(name: String, notes: String?, due: Date?){
        _ = Task(name: name, notes: notes, due: due)
        saveToPersistentStore()
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?){
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
    }
    
    func remove(task: Task) {
        if let moc = task.managedObjectContext {
            moc.delete(task)
            saveToPersistentStore()
        }
    }
    
    //MARK: - Persistence
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.context
        do{
            try moc.save()
        } catch let saveError{
            print("There was an issue saving: \(saveError)")
        }
    }
}
