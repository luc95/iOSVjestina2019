//
//  DataController.swift
//  QuizApp
//
//  Created by Luc on 17/06/2019.
//

import Foundation
import CoreData

class DataController {
    
    static let shared = DataController()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchQuizzes() -> [Quiz]? {
        let request: NSFetchRequest<Quiz> = Quiz.fetchRequest()
        
        let context = DataController.shared.persistentContainer.viewContext
        let reviews = try? context.fetch(request)
        return reviews
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
