//
//  ViewModelTests.swift
//  GourmapTests
//
//  Created by hiro on 2021/08/21.
//

import XCTest
@testable import Gourmap

class ViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testPracticeTest() throws {
        let viewModel = ViewModelImpl()
        var value = viewModel.practiceTest()
        XCTAssertEqual(value, "Test")
    }
    
    func testPractice2() throws {
        let viewModel = ViewModelImpl()
        var value2 = viewModel.practice2(para1: 100)
        XCTAssertEqual(value2, "bbb")
    }
    
    func testAsyncTasc() throws {
        let expectation = self.expectation(description: "wait for async task")
        var asyncTask: AsyncTask! = AsyncTask()
        
        asyncTask.execute { result in
            // このクロージャが呼び出される前にテストが終了してしまう
            XCTAssertTrue(result)
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 3)
    }
}

class AsyncTask {
    func execute(completion: @escaping (Bool) -> Void) {
        DispatchQueue.global().async {
            completion(true)
        }
    }
}
