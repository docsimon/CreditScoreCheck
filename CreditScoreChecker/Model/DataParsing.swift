//
//  DataParsing.swift
//  CreditScoreChecker
//
//  Created by doc on 11/02/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import Foundation

typealias CompletionClosure = (CreditScoreData?, Error?) -> Void
typealias JsonHandlerFunction = (Data, CompletionClosure) -> Void

func parseCreditCheckJson(data: Data, completion: CompletionClosure){
    
    let jsonResponse: [String:Any]?
    
    do {
        jsonResponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any]
    }catch {
        sendError(Constants.jsonError, "parseCreditCheckJson", completion: completion)
        return
    }
    
    guard let response = jsonResponse, let creditReportInfo = response["creditReportInfo"] as? [String:Any] else{
        sendError(Constants.jsonError, "parseCreditCheckJson", completion: completion)
        return
    }
    
    let score = creditReportInfo["score"] as? Int
    let maxScore = creditReportInfo["maxScoreValue"] as? Int
    let creditData = CreditScoreData(score: score, maxScoreValue: maxScore)
    completion(creditData, nil)
}
