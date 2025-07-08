//
//  CatsTests.swift
//  CatsTests
//
//  Created by Isabel Couto on 04/07/2025.
//

import XCTest
import CoreData
@testable import Cats

final class CatDataManagerTests: XCTestCase {
    
    var inMemoryContext: NSManagedObjectContext!
    var dataManager: CatDataManager!
    
    
    override func setUp() {
        super.setUp()
        let container = NSPersistentContainer(name: "Cats")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        
        let expectation = self.expectation(description: "Load in-memory store")
        container.loadPersistentStores{ _,error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        inMemoryContext = container.viewContext
        dataManager = CatDataManager(context: inMemoryContext)
    }

    
    override  func tearDown() {
        inMemoryContext = nil
        dataManager = nil
        super.tearDown()
    }
    
    
    func testSaveAndCountCats(){
        let cats = [
            Cat(id: "1", name: "Milo", temperament: "UK", origin: "Calm", description: "Friendly cat", imageId: ""),
            Cat(id: "2", name: "Luna", temperament: "PT", origin: "Playful", description: "Very active", imageId: ""),
        ]
        dataManager.save(cats: cats)
        let count = dataManager.countCats(in: inMemoryContext)
        XCTAssertEqual(count, 2)
    }
    
    func testPreventDuplicateCats(){
        let cats = [
            Cat(id: "1", name: "Milo",temperament: "Calm" ,  origin: "UK", description: "Friendly cat",imageId: "")
        ]
        dataManager.save(cats: cats)
               
        let loadedCats = dataManager.loadCatsFromCoreData(context: inMemoryContext)
        XCTAssertEqual(loadedCats.count, 1)
        XCTAssertEqual(loadedCats.first?.name, "Milo")
    }

}
