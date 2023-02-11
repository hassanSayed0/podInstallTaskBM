//
//  NetworkManager.swift
//  task5
//
//  Created by hassan sayed on 8/11/22.
//

import Foundation
import Alamofire

struct NetworkManager {
    
    static func authoticateUser(email: String, pass: String, url: String, completion: @escaping (RegistrationResponse) -> Void, onFailure: @escaping (String) -> Void) {
        let param: [String: String] = ["email": email,
                                       "password": pass]
        
        AF.request( url, method: .post, parameters: param)
            .validate()
            .responseDecodable(of: RegistrationResponse.self) { response in
                guard let user = response.value else {
                    onFailure(response.error?.localizedDescription ?? "")
                    return
                }
                print("user token = \(user.token)")
                completion(user)
            }
    }
}
