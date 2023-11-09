//
//  WebServiceAPI.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 09/11/23.
//

import UIKit

class WebServiceAPI {
    
    // padrao SINGLETON
    static let shared = WebServiceAPI()
    
    func creatUser(name: String, email: String, password: String, document: String, birthday: String) {
        
        let json: [String: Any] = [
            "password": password,
            "name": name,
            "email": email,
            "birthday": birthday
        ]
        
        do {
            let jsonRequest = try JSONSerialization.data(withJSONObject: json)
            
            let endpoint = "https://hades.tiagoaguiar.co/kingburguer/users"
            guard let url = URL(string: endpoint) else {
                print("ERROR: URL \(endpoint) malformed!")
                return
            }
            
            var request =  URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.httpBody = jsonRequest
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                // assincrono
                print("Response is \(String(describing: response))")
                print("--------------------\n\n")
                
                if let error = error {
                    print("Error: to call \(endpoint)")
                    print(error)
                    return
                }
                
                guard let data = data else {
                    print("No data found \(endpoint)")
                    return
                }
                
                
                if let d = String(data: data, encoding: .utf8) {
                    print("Data is \(d)")
                }
            }
            
            
            task.resume()
        }
        catch {
            print(error)
            return
        }
        
    }
}
