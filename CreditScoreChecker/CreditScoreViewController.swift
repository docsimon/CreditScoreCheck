//
//  CreditScoreViewController.swift
//  CreditScoreChecker
//
//  Created by doc on 11/02/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import UIKit

class CreditScoreViewController: UIViewController, AlertDisplay {
    
    @IBOutlet weak var creditScoreLabel: UILabel!
    
    var viewModel: CreditScoreViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creditScoreLabel.text = "N/A"
        viewModel = CreditScoreViewModel()
        bindViewModel()
        //let pippo = viewModel?.creditScoreData
        //viewModel?.creditScoreData = CreditScoreData(score: 500, maxScoreValue: 700)
        viewModel?.delegate = self
        viewModel?.fetchCreditData(endpoint: "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values")
    }
    
    func bindViewModel(){
        viewModel?.creditScoreClosure = {[weak self] (data) in
                let creditScore = data[0]
                //let maxCreditScore = data[1]
                // set the view
            DispatchQueue.main.async {
                self?.creditScoreLabel.text = creditScore
            }
        }
    }
    
    func riseError(errorTitle: String, errorBody: Error?) {
        displayError(errorTitle: errorTitle, errorMsg: errorBody?.localizedDescription, presenting: {[weak self] alert in
            self?.present(alert, animated: true)
        })
    }

}

