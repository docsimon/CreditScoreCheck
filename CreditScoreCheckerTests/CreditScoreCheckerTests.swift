//
//  CreditScoreCheckerTests.swift
//  CreditScoreCheckerTests
//
//  Created by doc on 11/02/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//
//
//import XCTest
//@testable import CreditScoreChecker
//
//class CreditScoreCheckerTests: XCTestCase {
//    
//    var viewModel: CreditScoreViewModel?
//    
//    override func setUp() {
//        super.setUp()
//        viewModel = CreditScoreViewModel()
//    }
//    
//    override func tearDown() {
//        super.tearDown()
//    }
//    
//    func testFormatCreditDataGoodValues(){
//        let creditScoreData = CreditScoreData(score: 500, maxScoreValue: 700)
//        let formattedData = viewModel?.formatCreditData(creditData: creditScoreData) ?? ["",""]
//        XCTAssert(formattedData[0] == "500")
//        XCTAssert(formattedData[1] == "700")
//    }
//    
//    func testFormatCreditDataBadValues(){
//        let creditScoreData = CreditScoreData(score: nil, maxScoreValue: nil)
//        let formattedData = viewModel?.formatCreditData(creditData: creditScoreData) ?? ["",""]
//        XCTAssert(formattedData[0] == "N/A")
//        XCTAssert(formattedData[1] == "N/A")
//    }
//    
//    func testCreateURL(){
//        let badUrl = "ht tp:/ /"
//        XCTAssertNil(createURL(from: badUrl))
//        let goodUrl = "http://www.google.com"
//        XCTAssertNotNil(createURL(from: goodUrl))
//    }
//    
//    func testCreateURLRequest(){
//        let badUrl = "ht tp:/ /"
//        XCTAssertNil(createURLRequest(url: createURL(from: badUrl)))
//        let goodUrl = "http://www.google.com"
//        XCTAssertNotNil(createURLRequest(url: createURL(from: goodUrl)))
//    }
//    
//    func testCheckResponseCode(){
//        XCTAssert(checkResponseCode(code: 200) == true)
//        XCTAssert(checkResponseCode(code: 201) == true)
//        XCTAssert(checkResponseCode(code: 202) == true)
//        XCTAssert(checkResponseCode(code: 203) == true)
//        XCTAssert(checkResponseCode(code: 204) == true)
//        XCTAssert(checkResponseCode(code: 500) == false)
//    }
//    
//    func testJsonParsingSearch() {
//        
//       let stringJson =  "{ \"accountIDVStatus\":\"PASS\",\"creditReportInfo\":{\"score\":514,\"maxScoreValue\":700}}"
//        
//        let dataJson = stringJson.data(using: .utf8)
//        let expectationJ = expectation(description: "Parsing Json")
//        
//        if let data = dataJson {
//            parseCreditCheckJson(data: data) { result, error  in
//                
//                if error != nil {
//                    XCTFail("The parser failed to parse the Json file")
//                }
//                
//                if result?.score == 514 && result?.maxScoreValue == 700{
//                    expectationJ.fulfill()
//                }else{
//                    XCTFail("The parser failed to parse the Json file")
//                }
//            }
//        }else {
//            XCTFail("The parser failed to parse the Json file")
//        }
//        
//        waitForExpectations(timeout: 10, handler: nil)
//    }
//}

