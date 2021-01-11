//
//  APIManager.swift
//  CentralTechAssignment
//
//  Created by Nantarat Buranajinda on 11/1/2564 BE.
//

import Foundation
import Alamofire

public class APIManager {
    func callRequest<T: Decodable>(url: String,
                                   method: HTTPMethod,
                                   type: T.Type,
                                   success: @escaping (_ result: T?) -> (),
                                   failure: @escaping () -> ()) {
        
        print("=============== Start: Call Service ===============")
        print("URL :", url)
        AF.request(url, method: method)
            .validate()
            .responseDecodable(of: type) { response in
                switch response.result {
                case .success(let data):
                    success(data)
                case .failure(let err):
                    print(err.localizedDescription)
                    failure()
                }
                print("=============== END: Call Service =================")
            }
    }
}
