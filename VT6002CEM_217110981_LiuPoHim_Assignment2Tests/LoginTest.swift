//
//  LoginTest.swift
//  VT6002CEM_217110981_LiuPoHim_Assignment2Tests
//
//  Created by user211668 on 1/13/22.
//

import XCTest
@testable import VT6002CEM_217110981_LiuPoHim_Assignment2

class LoginTest: XCTestCase {

    var sut : LoginViewController!
    
    override func setUpWithError() throws {
       try super.setUpWithError()
        
        sut = LoginViewController()
    }

    override func tearDownWithError() throws {
        sut = nil
        
        try super.tearDownWithError()
    }
    
    func mockValidateFields(email: String, password: String) -> String?{
        if email.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        if password.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
                
        return nil
    }
    
    func testValidateFieldsWithEmptyEmail(){
        let result = mockValidateFields(email: "", password: "test")
        XCTAssertEqual(result, "Please fill in all fields", "The empty field is detected")
    }
    
    func testValidateFieldsWithEmptyPassword(){
        let result = mockValidateFields(email: "test", password: "")
        XCTAssertEqual(result, "Please fill in all fields", "The empty field is detected")
    }
    
    func testValidateFieldsCorrectly(){
        let result = sut.validateFields(email: "test", password: "test")
        XCTAssertEqual(result, nil, "The empty field is detected")
    }
    
    func testLoginWithEmptyEmail(){
        let email = ""
        let password = "password"
        sut.login(email: email, password: password) { Result, Error in
            print(Error?.localizedDescription ?? "No error")
            XCTAssertNotNil(Error, "should not login")
        }
    }
    
    func testLoginWithEmptyPassword(){
        let email = "email"
        let password = ""
        sut.login(email: email, password: password) { Result, Error in
            print(Error?.localizedDescription ?? "No error")
            XCTAssertNotNil(Error, "should not login")
        }
    }
    
    
    func testLoginCorrectly(){
        let email = "test@test.com"
        let password = "Test12345"
        sut.login(email: email, password: password) { Result, Error in
            print(Error?.localizedDescription ?? "No error")
            XCTAssertNil(Error, "should login successful")
        }
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
