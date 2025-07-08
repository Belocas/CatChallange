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
    var dataManager: CatDataManagerTests!
    
    
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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
