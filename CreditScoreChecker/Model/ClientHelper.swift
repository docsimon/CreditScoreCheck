//
//  ClientHelper.swift
//  CreditScoreChecker
//
//  Created by doc on 11/02/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import Foundation

func sendError(_ error: String, _ domain: String, completion: CompletionClosure) {
    print(error)
    let userInfo = [NSLocalizedDescriptionKey : error]
    completion(nil, NSError(domain: domain, code: 1, userInfo: userInfo))
}

func createURL(from urlString: String) ->URL? {
    let urlComponent = URLComponents(string: urlString)
    return urlComponent?.url
}

func createURLRequest(url: URL?) -> URLRequest?{
    if let url = url{
        return URLRequest(url: url)
    }
    return nil
}
