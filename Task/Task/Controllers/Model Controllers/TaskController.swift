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
    var tasks: [Task] {
        return fetchTasks()
    }
    
    //MARK: - Mock Tasks
//    var mockTasks: [Task] {
//        return [
//        Task(name: "Go for a walk", isComplete: false),
//        Task(name: "Go for another walk", notes: "Another one", isComplete: false),
//        Task(name: "Take a third walk", due: Date(), isComplete: true)
//        ]
//    }
    
//    init() {
//        self.tasks = self.fetchTasks()
//    }
    
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
    
    func fetchTasks() -> [Task]{
        let moc = CoreDataStack.context
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            let fetchResults = try moc.fetch(fetchRequest)
            return fetchResults
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
