//
//  Covid19Tests.swift
//  Covid19Tests
//
//  Created by Pavel Ivanovski on 26.01.21.
//

import XCTest
@testable import Covid19


class Covid19Tests: XCTestCase {
    
    var validator: UserFieldsChecker!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        validator = UserFieldsChecker()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        validator = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        print("testExample")
    }

    func testThatOnFilled3digitsFieldsCheckPasses () {
        let result = validator.loginFieldsCheck("123", "dsfs")
        XCTAssertFalse(result)
    }
    
    func testThatOnEmptyFieldsCheckPasses () {
        let result = validator.loginFieldsCheck("", "")
        XCTAssertFalse(result)
    }
    func testThatOnFilled6diigitsFieldsCheckPasses () {
        let result = validator.loginFieldsCheck("123456", "123456")
        XCTAssertFalse(result)
    }
    func testThatOnFilled6diigitsAndCharsactersFieldsCheckPasses () {
        let result = validator.loginFieldsCheck("123abc", "123abc")
        XCTAssertFalse(result)
    }
    func testThatOnFilled8diigitsAndCharsactersFieldsCheckPasses () {
        let result = validator.loginFieldsCheck("123abcDE", "123abcDE")
        XCTAssertTrue(result)
    }
    func testThatOnFilled8CharsactersFieldsCheckPasses () {
        let result = validator.loginFieldsCheck("abcdDEFG", "abcdDEFG")
        XCTAssertTrue(result)
    }
    func testThatOnFilled8UpperCharsactersFieldsCheckPasses () {
        let result = validator.loginFieldsCheck("ABCDEFGH", "ABCDEFGH")
        XCTAssertTrue(result)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
