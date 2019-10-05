//
//  APIMethod.swift
//  U-Quest
//
//  Created by Teerapat Champati on 4/9/2562 BE.
//  Copyright © 2562 SUT Global. All rights reserved.
//

import Foundation

//HTTP Method
enum APIMethod: String {
    case GET="GET"
    case POST="POST"
    case PATCH="PATCH"
    case DELETE="DELETE"
}

let SERVICE_URL = "http://api.ookbee.com"
let ENDPOINT_BOOKS = "/user/{userId}/books"

class ServiceAPI {
    
    static func Request(serviceUrl: String = SERVICE_URL,api: String, field: String = "", method: APIMethod = APIMethod.GET,params: Dictionary<String, Any>?) -> URLRequest{
        var request = URLRequest(url: URL(string: serviceUrl + api + field)!)
        request.httpMethod = method.rawValue
        if params != nil{
            request.httpBody = try? JSONSerialization.data(withJSONObject: params!, options: [])
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    static func SessionConfig(authorization: String) -> URLSessionConfiguration{
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.httpAdditionalHeaders = ["Authorization": authorization]
        return sessionConfig
    }
}
class ServiceAPIMethod {
    
    static func OokbeeApiBooks(authorization:String, userId: String,completionHandler: @escaping (Any?, Error?) -> Void){
        //param
        let session = URLSession(configuration: ServiceAPI.SessionConfig(authorization:authorization))
        let api = ENDPOINT_BOOKS.replacingOccurrences(of: "{userId}", with: userId)
        
        let task = session.dataTask(with: ServiceAPI.Request(api: api, method: .POST, params: nil),completionHandler: { data, response, error -> Void in
            do {
                if let httpResponse = response as? HTTPURLResponse {
                    if(httpResponse.statusCode == 200){
                        let results = try! JSONDecoder().decode([BookModel].self, from: data!)
                        completionHandler(results,nil)
                    }else{
                        completionHandler(nil,error)
                    }
                }
            }
        })
        
        task.resume()
    }
}
