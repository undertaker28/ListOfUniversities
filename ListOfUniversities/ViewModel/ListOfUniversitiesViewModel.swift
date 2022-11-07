//
//  ListOfUniversitiesViewModel.swift
//  ListOfUniversities
//
//  Created by Pavel on 7.11.22.
//

class ListOfUniversitiesViewModel {
    var universities = [UniversityModel]()
    
    var count: Int {
        universities.count
    }
    
    func universityAtIndex(_ index: Int) -> UniversityModel {
        universities[index]
    }
    
    func addUniversity(_ university: UniversityModel) {
        universities.append(university)
    }
    
    func removeUniversityAtIndex(_ index: Int) {
        universities.remove(at: index)
    }
}
