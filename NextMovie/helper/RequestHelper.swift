//
//  RequestHelper.swift
//  NextMovie
//
//  Created by Luís Wolf on 25/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

protocol ResponseRequestProtocol : class {
    func didFailWith(errorMessage: String)
    func didFailWithNoConnection()
}

extension ResponseRequestProtocol {
    func didFailWith(errorMessage: String) {}
    func didFailWithNoConnection() {}
}

class ResponseDTO<T> {
    let success: Bool
    let message: String
    let data: T?
    
    init (success: Bool, message: String, data: T?) {
        self.success = success
        self.message = message
        self.data = data
    }
}

protocol RequestHelperProtocol {
    func get <T> (type: T.Type, fromUrl url: String, andReturnTo callback:@escaping (ResponseDTO<T>) -> Void)->Void where T:Mappable
    func get <T> (type: T.Type, fromUrl url: String, andReturnTo callback:@escaping (ResponseDTO<[T]>) -> Void)->Void where T:Mappable
}

final class RequestHelper: RequestHelperProtocol {
    let imageTypes = ["image/png", "image/jpeg"]
    var allowedCharacters = CharacterSet.urlQueryAllowed
    
    init() {
        allowedCharacters.remove(charactersIn: "+")
    }
    
    // get single object
    func get<T>(type: T.Type, fromUrl url: String, andReturnTo callback: @escaping (ResponseDTO<T>) -> Void) where T : Mappable {
        guard let urlLocal = url.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else { return }
        
        Alamofire.request(urlLocal, method: Alamofire.HTTPMethod.get, encoding: URLEncoding.default)
            .validate()
            .responseString(encoding: String.Encoding.utf8) {  response in
                switch response.result {
                case .success(let data):
                    let dataObj = ParseHelper.parseObject(type: type, fromJSON: data)
                    let responseDTO = ResponseDTO<T>(success: true, message: "", data: dataObj)
                    DispatchQueue.main.async {
                        callback(responseDTO)
                    }
                case .failure(let error):
                    let responseDTO = ResponseDTO<T>(success: false, message: error.localizedDescription, data: nil)
                    DispatchQueue.main.async {
                        callback(responseDTO)
                    }
                }
        }
    }
    
    // get array
    func get <T> (type: T.Type, fromUrl url: String, andReturnTo callback:@escaping (ResponseDTO<[T]>) -> Void)->Void where T:Mappable {
        guard let urlLocal = url.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else { return }
        
        Alamofire.request(urlLocal, method: Alamofire.HTTPMethod.get, encoding: URLEncoding.default)
            .validate()
            .responseString(encoding: String.Encoding.utf8){ response in
                switch response.result {
                case .success(let data):
                    let dataObj = ParseHelper.parseArray(type: type, fromJSON: data)
                    let responseDTO = ResponseDTO<[T]>(success: true, message: "", data: dataObj)
                    DispatchQueue.main.async {
                        callback(responseDTO)
                    }
                case .failure(let error):
                    let responseDTO = ResponseDTO<[T]>(success: false, message: error.localizedDescription, data: nil)
                    DispatchQueue.main.async {
                        callback(responseDTO)
                    }
                }
        }
        
    }
    
    // download
    func download(fromUrl url: String, andReturnTo callback: @escaping (Data?) -> Void)->Void {
        guard let urlLocal = url.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else { return }
        
        Alamofire.request(urlLocal)
            .validate(contentType: self.imageTypes)
            .responseData { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        DispatchQueue.main.async {
                            callback(data)
                        }
                    } else {
                        DispatchQueue.main.async {
                            callback(nil)
                        }
                    }
                case .failure:
                    DispatchQueue.main.async {
                        callback(nil)
                    }
                }
        }
        
    }
}
