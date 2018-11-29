//
//  ParseHelper.swift
//  NextMovie
//
//  Created by Luís Wolf on 25/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import Foundation
import ObjectMapper

final class ParseHelper {
    
    static func getJSON(fromData data: Any?) -> String {
        if let data = data {
            var jsonObject: Any!
            if let dataArray = data as? [Any?] {
                jsonObject = dataArray.filter { $0 != nil }
            } else {
                jsonObject = data
            }
            
            if let theJSONData = try? JSONSerialization.data(withJSONObject: jsonObject, options: []) {
                let theJSONText = String(data: theJSONData, encoding: .utf8)
                return theJSONText ?? ""
            } else {
                return ""
            }
        } else {
            return ""
        }
    }
    
    static func parseObject<T>(type: T.Type, fromJSON JSONText: String?) -> T? where T: Mappable {
        if let jsonText = JSONText, jsonText != "" {
            let mapper = Mapper<T>()
            
            var JSON = Mapper<T>.parseJSONString(JSONString: jsonText)
            
            if let JSONArray = JSON as? [Any?] { // encapsula o valor em um objeto padrão caso seja array
                JSON = ["rootArray": JSONArray]
            }
            
            var obj: T?
            
            if let objJSON = JSON as? [String: Any] {
                obj = mapper.map(JSON: objJSON)
            } else {
                obj = mapper.map(JSONString: jsonText)
            }
            
            return obj
            
        } else {
            return nil
        }
    }
    
    static func parseArray<T>(type: T.Type, fromJSON JSONText: String?) -> [T]? where T: Mappable {
        if let jsonText = JSONText, jsonText != "" {
            let arr: [T]? = Mapper<T>().mapArray(JSONString: jsonText)
            return arr
        } else {
            return nil
        }
    }
    
    static func parseDictIgnoreKeysArray<T>(type: T.Type, mapJSON: Any?) -> [T]? where T: Mappable {
        if let mapJSON = mapJSON, let JSON = mapJSON as? [String: [String: Any]] {
            var arrAux: [[String:Any]] = []
            
            JSON.forEach({ key, value in
                arrAux.append(value)
            })
            
            let arr: [T]? = Mapper<T>().mapArray(JSONArray: arrAux)
            return arr
        } else {
            return nil
        }
    }
    
}
