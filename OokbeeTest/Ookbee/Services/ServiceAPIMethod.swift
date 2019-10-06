//
//  APIMethod.swift
//  U-Quest
//
//  Created by Teerapat Champati on 4/9/2562 BE.
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
let ENDPOINT_ADD_NEW_BOOK = "/user/{userId}/books"

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

class ServiceAPIParam {
    static func BookParam(book: BookModel) -> [String: Any]{
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(book)
        let json: [String:Any] = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [String : Any]
        return json
    }
}

class ServiceAPIMethod {
    
    static func OokbeeApiAddNewBook(authorization:String, userId: String,book: BookModel,completionHandler: @escaping (Any?, Error?) -> Void){
        //param
        let session = URLSession(configuration: ServiceAPI.SessionConfig(authorization:authorization))
        let api = ENDPOINT_ADD_NEW_BOOK.replacingOccurrences(of: "{userId}", with: userId)
        let param: [String: Any]  = ServiceAPIParam.BookParam(book: book)
        let task = session.dataTask(with: ServiceAPI.Request(api: api, method: .POST, params: param),completionHandler: { data, response, error -> Void in
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
