//
//  CreditScoreViewController.swift
//  CreditScoreChecker
//
//  Created by doc on 11/02/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import UIKit

class CreditScoreViewController: UIViewController, AlertDisplay, CircleSizeFactor {
    
    @IBOutlet weak var creditScoreLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var barItem: UINavigationBar!
    @IBOutlet weak var baseCircleView: BaseCircleView!
    @IBOutlet weak var maxScoreLabel: UILabel!
    var viewModel: CreditScoreViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        viewModel = CreditScoreViewModel()
        bindViewModel()
        viewModel?.delegate = self
        viewModel?.fetchCreditData(endpoint: Constants.murl)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    

    func bindViewModel(){
        viewModel?.creditScoreClosure = {[weak self] (data) in
                let creditScore = data[0]
                let maxScore = data[1]
                // set the view
            DispatchQueue.main.async {
                self?.creditScoreLabel.text = creditScore
                self?.maxScoreLabel.text = maxScore

            }
        }
        viewModel?.activityClosure = {[weak self] (startIndicator) in
            DispatchQueue.main.async {
                startIndicator == true ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    func riseError(errorTitle: String, errorBody: Error?) {
        displayError(errorTitle: errorTitle, errorMsg: errorBody?.localizedDescription, presenting: {[weak self] alert in
            self?.present(alert, animated: true)
        })
    }
    @IBAction func reloadScoreData(_ sender: Any) {
        viewModel?.fetchCreditData(endpoint: Constants.murl)
    }
    
    func initViews(){
        barItem.topItem?.title = Constants.navigationBarTitle
        baseCircleView.delegate = self
        activityIndicator.hidesWhenStopped = true
        creditScoreLabel.text = "N/A"
    }
}

extension CreditScoreViewController {
    var sizeFactor: CGFloat {
        return 5
    }
}
