//
//  Bucket List Model.swift
//  Bucket
//
//  Created by administrator on 24/12/2021.
//

import Foundation

class BucketListModel {
    
    static func getAllasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void){
        
        let url = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks")
        
        let session = URLSession.shared
        
        session.dataTask(with: url!, completionHandler: completionHandler).resume()
        
    }
    
    static func addNewTask(objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void){
        
        if let urlToRequest = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/?format=json") {
            
            var request = URLRequest(url: urlToRequest)
            
            request.httpMethod = "POST"
            
            let bodyData = "objective=\(objective)"
            request.httpBody = bodyData.data(using: .utf8)
            
            let session = URLSession.shared
            session.dataTask(with: request as URLRequest, completionHandler: completionHandler).resume()
        }        
        
    }
    
    static func updateTask(objective: String, id: Int, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void){
        
        if let urlToRequest = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/\(id)/") {
            
            var request = URLRequest(url: urlToRequest)
            
            request.httpMethod = "PUT"
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            let bodyData = "{\"objective\":\"\(objective)\"}"
            request.httpBody = bodyData.data(using: .utf8)
            
            let session = URLSession.shared
            session.dataTask(with: request as URLRequest, completionHandler: completionHandler).resume()
        }
        
    }
    
    static func deleteTask(id: Int, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void){
        
        if let urlToRequest = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/\(id)/") {
            
            var request = URLRequest(url: urlToRequest)
            
            request.httpMethod = "DELETE"
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            let bodyData = "id=\(id)"
            request.httpBody = bodyData.data(using: .utf8)
            
            let session = URLSession.shared
            session.dataTask(with: request as URLRequest, completionHandler: completionHandler).resume()
        }
        
    }
}
