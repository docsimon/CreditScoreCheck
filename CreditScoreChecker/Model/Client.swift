//
//  Client.swift
//  CreditScoreChecker
//
//  Created by doc on 11/02/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import Foundation

func makeConnection(request: URLRequest, jsonHandler: @escaping JsonHandlerFunction, completion: @escaping (_ jsonData: CreditScoreData?, _ error: Error?) -> Void ) {
    
    let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
        
        // error checking
        guard (error == nil) else {
            sendError((error?.localizedDescription) ?? "Error", "makeConnection", completion: completion)
            return
        }
        // response checking
        if let statusCode = (response as? HTTPURLResponse)?.statusCode{
            guard checkResponseCode(code: statusCode) == true else {
                sendError("Status code: \(String(describing: statusCode))", "makeConnection", completion: completion)
                return
            }
        }else {
            sendError("Status code unknown", "makeConnection", completion: completion)
            return
        }
        
        // data checking
        guard let data = data else {
            sendError("Error receiving the Data", "makeConnection", completion: completion)
            return
        }
        
            jsonHandler(data, completion)
        
    })
    task.resume()
}

func checkResponseCode(code: Int) -> Bool {
    let successCode = [200, 201, 202, 203, 204]
    return successCode.contains(code)
}
