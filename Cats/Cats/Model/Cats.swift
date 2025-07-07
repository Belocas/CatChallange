//
//  Cats.swift
//  Cats
//
//  Created by Isabel Couto on 05/07/2025.
//


import CoreData
struct Cat:Identifiable, Equatable, Codable{
    let id:String
    let name:String
    let temperament:String
    let origin:String
    let description:String
    let imageId:String
    
    enum CodingKeys: String, CodingKey {
        case  id, name,temperament, origin, description, imageId = "reference_image_id"
    }
}



extension Cat{
    
    init(entity:CatEntity){
        self.id = entity.id ?? ""
        self.name = entity.name ?? ""
        self.temperament = entity.temperament ?? ""
        self.origin = entity.origin ?? ""
        self.description = entity.bredd_description ?? ""
        self.imageId = "" //TODO

    }
    
    
    func toEntity(context:NSManagedObjectContext)->CatEntity{
        let entity = CatEntity(context: context)
        entity.id = id
        entity.name = name
        entity.temperament = temperament
        entity.origin = origin
        entity.bredd_description = description
        //TODO: reference_image_id
        return entity
    }
}
