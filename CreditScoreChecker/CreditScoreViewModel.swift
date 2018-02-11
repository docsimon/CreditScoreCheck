//
//  CreditScoreViewModel.swift
//  CreditScoreChecker
//
//  Created by doc on 11/02/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import Foundation

protocol AlertDisplay: class {
   func riseError(errorTitle: String, errorBody: Error?)
}

typealias CreditScoreClosure = (([String]) -> ())?
typealias ActivityClosure = ((Bool) -> ())?


class CreditScoreViewModel {
    
    // define the view/viewmodel binding closure
    var creditScoreClosure: CreditScoreClosure
    var activityClosure: ActivityClosure

    weak var delegate: AlertDisplay?
    
    // when the viewModel changes, the view gets notified calling the creditScoreClosure closure
    var creditScoreData: CreditScoreData? {
        didSet {
            if let creditScoreData = creditScoreData{
                let scoreData = formatCreditData(creditData: creditScoreData)
                creditScoreClosure?(scoreData)
            }
        }
    }
    var activityIndicator: Bool = true {
        didSet {
                activityClosure?(activityIndicator)
            }
    }
    
    // Since score and maxScore are passed as Int we provide here a way to convert them to String,
    // so they are ready to use by the View
    func formatCreditData(creditData: CreditScoreData) -> [String]{
        let score = String(creditData.score ?? 0)
        let maxScore = String(creditData.maxScoreValue ?? 0)
        return [score, maxScore]
    }
    
    // this function fetches credit data fromthe remote endpoint
    func fetchCreditData(endpoint: String){
       
        activityIndicator = true
        
        guard let url = createURL(from: endpoint) else {
            self.delegate?.riseError(errorTitle: "Url error", errorBody: nil)
            activityIndicator = false
            return
        }
        guard let request = createURLRequest(url: url) else {
            self.delegate?.riseError(errorTitle: "Request error", errorBody: nil)
            activityIndicator = false
            return
        }
        makeConnection(request: request, jsonHandler: parseCreditCheckJson, completion: {[weak self] (data, error) in
            
            guard error == nil else {
                self?.delegate?.riseError(errorTitle: "Error fetching data", errorBody: error!)
                self?.activityIndicator = false
                return
            }
            
            guard let data = data else {
                self?.delegate?.riseError(errorTitle: "No data", errorBody: nil)
                self?.activityIndicator = false
                return
            }
        
            // this attribution trigger the observer in the variable creditScoreData and executes the closure
            // which in turn update the UI
            self?.creditScoreData = data
            self?.activityIndicator = false
            
        })
        
    }
    
    public init(){}
}

