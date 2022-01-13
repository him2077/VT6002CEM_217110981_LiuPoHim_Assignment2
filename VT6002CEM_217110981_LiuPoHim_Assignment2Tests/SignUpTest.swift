//
//  SignUpTest.swift
//  VT6002CEM_217110981_LiuPoHim_Assignment2Tests
//
//  Created by user211668 on 1/14/22.
//

import XCTest
@testable import VT6002CEM_217110981_LiuPoHim_Assignment2

class SignUpTest: XCTestCase {
    var sut : SignUpViewController!
    override func setUpWithError() throws {
       try super.setUpWithError()
        
        sut = SignUpViewController()
    }

    override func tearDownWithError() throws {
        sut = nil
        
        try super.tearDownWithError()
    }
    
    func mockValidateFields(nickName:String, email: String, password: String) -> String?{
        if nickName.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        if email.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        if password.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        
        let clearPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.CheckInputValid(clearPassword) == false {
            return "Please make sure your password at least 8 characters, contain a UPPERCASE letter and a lowercase letter"
        }
        
        return nil
    }
    
    func testValidateFieldsWithEmptyName(){
        let result = mockValidateFields(nickName:"", email: "test", password: "test")
        XCTAssertEqual(result, "Please fill in all fields", "The empty name field is detected")
    }
    
    func testValidateFieldsWithEmptyEmail(){
        let result = mockValidateFields(nickName:"test", email: "", password: "test")
        XCTAssertEqual(result, "Please fill in all fields", "The empty email field is detected")
    }
    
    func testValidateFieldsWithEmptyPassword(){
        let result = mockValidateFields(nickName:"test", email: "test", password: "")
        XCTAssertEqual(result, "Please fill in all fields", "The empty password field is detected")
    }
    
    func testValidateFieldsWithWrongPassword(){
        let result = mockValidateFields(nickName:"test", email: "test", password: "wrongpw")
        XCTAssertEqual(result, "Please make sure your password at least 8 characters, contain a UPPERCASE letter and a lowercase letter", "The wrong password is detected")
    }
    
    func testValidateFieldsWithCorrectPassword(){
        let result = mockValidateFields(nickName:"test", email: "test", password: "Test1234")
        XCTAssertEqual(result, nil, "The password should pass")
    }
    
   

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
