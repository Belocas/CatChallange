//
//  CatDataManager.swift
//  Cats
//
//  Created by Isabel Couto on 06/07/2025.
//

import CoreData

class CatDataManager{
    let context:NSManagedObjectContext
    
    init(context:NSManagedObjectContext = PersistenceController.shared.container.viewContext){
        self.context = context
    }
    
    func save(cats: [Cat]) {
        for cat in cats {
            // Evita duplicados
            let fetchRequest: NSFetchRequest<CatEntity> = CatEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", cat.id)

            if let results = try? context.fetch(fetchRequest), results.isEmpty == false {
                continue
            }

            let entity = CatEntity(context: context)
            entity.id = cat.id
            entity.name = cat.name
            entity.origin = cat.origin
            entity.temperament = cat.temperament
            entity.bredd_description = cat.description
        }

        do {
            try context.save()
            print("Todos os gatos foram guardados (sem duplicados).")
        } catch {
            print("Erro ao guardar gatos: \(error.localizedDescription)")
        }
    }

    
    func loadCatsFromCoreData(context:NSManagedObjectContext) -> [Cat] {
        let request = CatEntity.fetchRequest()
        do {
            let entities = try context.fetch(request)
            return entities.map { Cat(entity: $0) }
        }catch{
            print("ERRO")
            return []
        }
    }
    
    
    func countCats(in context: NSManagedObjectContext) -> Int {
        let fetchRequest: NSFetchRequest<CatEntity> = CatEntity.fetchRequest()

        do {
            let count = try context.count(for: fetchRequest)
            print("Número total de gatos guardados: \(count)")
            return count
        } catch {
            print("Erro ao contar gatos: \(error.localizedDescription)")
            return 0
        }
    }
}
