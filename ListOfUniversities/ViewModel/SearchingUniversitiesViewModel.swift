//
//  SearchingUniversitiesViewModel.swift
//  ListOfUniversities
//
//  Created by Pavel on 7.11.22.
//

import CoreData

class SearchingUniversitiesViewModel {
    var searchResponse: [UniversityModel]? = nil
    var networkManagerURLSession = NetworkManagerURLSession()
    var networkManagerAlamofire = NetworkManagerAlamofire()
    var networkManagerCombine = NetworkManagerCombine()
    var addedUniversities = ListOfUniversitiesViewModel().getAllUniversities()
    
    var isLoaded = false
    
    var count: Int {
        searchResponse?.count ?? 0
    }
    
    func searchResponseAtIndex(_ index: Int) -> UniversityModel {
        searchResponse?[index] ?? UniversityModel(domains: [], alphaTwoCode: "", webPages: [], country: "", stateProvince: "", name: "")
    }
    
    func getUniversityByCountry(countryName: String, completion: @escaping () -> Void) {
        let choice = Int.random(in: 0...2)
        let urlString = "http://universities.hipolabs.com/search?country=\(countryName)"
        
        if choice == 0 {
            networkResponse(urlString: urlString, networkManager: networkManagerURLSession, completion: completion)
        } else if choice == 1 {
            networkResponse(urlString: urlString, networkManager: networkManagerAlamofire, completion: completion)
        } else {
            networkResponse(urlString: urlString, networkManager: networkManagerCombine, completion: completion)
        }
    }
    
    func networkResponse(urlString: String, networkManager: NetworkOutput, completion: @escaping () -> Void) {
        self.networkManagerURLSession.fetchData(urlString: urlString, completion: { [weak self] (result) in
            guard let result = result else { return }
            if result.count != 0 {
                self?.isLoaded = true
                self?.searchResponse = result
                completion()
            } else {
                self?.searchResponse = nil
            }
        })
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
    
    func addUniversity(id: Int, appendedUniversity: UniversityModel) {
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "AddedUniversity", in: context)!
        let university = NSManagedObject(entity: entity, insertInto: context)
        university.setValue(appendedUniversity.name, forKeyPath: "name")
        university.setValue(id, forKeyPath: "id")
        university.setValue(appendedUniversity.webPages[0], forKeyPath: "webPage")
        university.setValue(appendedUniversity.country, forKeyPath: "country")
        university.setValue(appendedUniversity.domains[0], forKeyPath: "domain")
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
    
    func getState(id: Int, name: String) -> Bool {
        addedUniversities.contains(where: { $0.name == name}) && addedUniversities.contains(where: { $0.id == id })
    }
}
