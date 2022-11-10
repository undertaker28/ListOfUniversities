//
//  ListOfUniversitiesViewModel.swift
//  ListOfUniversities
//
//  Created by Pavel on 7.11.22.
//

import CoreData

class ListOfUniversitiesViewModel {
    var universities = [AddedUniversityModel]()
    
    var count: Int {
        universities.count
    }
    
    func universityAtIndex(_ index: Int) -> AddedUniversityModel {
        universities[index]
    }
    
    func getNameOfUniversity(_ index: Int) -> String {
        universities[index].name
    }
    
    func getPageLinkOfUniversity(_ index: Int) -> String {
        universities[index].webPage
    }
    
    func getDomainOfUniversity(_ index: Int) -> String {
        universities[index].domain
    }
    
    func getCountryLinkOfUniversity(_ index: Int) -> String {
        universities[index].country
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AddedUniversities")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func removeUniversityAtIndex(_ index: Int) {
        universities.remove(at: index)
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<AddedUniversity> = AddedUniversity.fetchRequest()
        if let result = try? context.fetch(fetchRequest) {
            context.delete(result[index])
        }
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchAll() {
        universities.removeAll()
        let fetchRequest: NSFetchRequest<AddedUniversity> = AddedUniversity.fetchRequest()
        if let objects = try? persistentContainer.viewContext.fetch(fetchRequest) {
            objects.forEach {
                universities.append(AddedUniversityModel(id: Int($0.id), webPage: $0.webPage ?? "", name: $0.name ?? "", country: $0.country ?? "", domain: $0.domain ?? ""))
            }
        }
    }
    
    func getAllUniversities() -> [AddedUniversityModel] {
        var returnData = [AddedUniversityModel]()
        let fetchRequest: NSFetchRequest<AddedUniversity> = AddedUniversity.fetchRequest()
        if let objects = try? persistentContainer.viewContext.fetch(fetchRequest) {
            objects.forEach {
                returnData.append(AddedUniversityModel(id: Int($0.id), webPage: $0.webPage ?? "", name: $0.name ?? "", country: $0.country ?? "", domain: $0.domain ?? ""))
            }
        }
        return returnData
    }
}
