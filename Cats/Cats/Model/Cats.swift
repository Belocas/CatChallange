//
//  Cats.swift
//  Cats
//
//  Created by Isabel Couto on 05/07/2025.
//


import CoreData
struct Cat:Codable{
    let id:String
    let name:String
    let temperament:String
    let origin:String
    let description:String
    
    
    enum CodingKeys: String, CodingKey {
        case  id, name,temperament, origin, description
    }
}



extension Cat{
    
    init(entity:CatEntity){
        self.id = entity.id ?? ""
        self.name = entity.name ?? ""
        self.temperament = entity.temperament ?? ""
        self.origin = entity.origin ?? ""
        self.description = entity.bredd_description ?? ""

    }
    
    
    func toEntity(context:NSManagedObjectContext)->CatEntity{
        let entity = CatEntity(context: context)
        entity.id = id
        entity.name = name
        entity.temperament = temperament
        entity.origin = origin
        entity.bredd_description = description
        return entity
    }
}
