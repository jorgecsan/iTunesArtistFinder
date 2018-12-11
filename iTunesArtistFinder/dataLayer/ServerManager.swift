//
//  ServerManager.swift
//  UnidadEditorialTest
//
//  Created by Jorge Cordero Sanchez on 5/10/18.
//  Copyright © 2018 Informagic. All rights reserved.
//


import Foundation
import Alamofire

class ServerManager{
    static let sharedInstance = ServerManager()
    
    var manager: SessionManager
    
    //Get baseURL from plist configuration File
    var baseURL = "https://itunes.apple.com"
    //https://itunes.apple.com/lookup
    let ALBUM_ENDPOINT: String = "/lookup"
    let SEARCH_ENDPOINT: String = "/search"
    
    init() {
        manager = Alamofire.SessionManager.default
    }
    
    //MARK: - Requests
    func baseRequest( _ name: String, method: HTTPMethod, parameters: [String : AnyObject], success: @escaping (_ results: AnyObject) -> Void, failure: @escaping (_ results: Error?) -> Void) {
        
        let completeRequest = baseURL + name
        
        let encoding: ParameterEncoding = method == .get ? URLEncoding.default : JSONEncoding.default
        
        manager.request(completeRequest, method: method, parameters: parameters, encoding: encoding)
            .responseJSON { (response: DataResponse<Any>) in
                
                if response.result.isSuccess {
                    print(String.init(describing: response.result.value))
                    let json = response.result.value as? AnyObject//[String:AnyObject]
                    let responseCode = response.response?.statusCode
                    if responseCode == 200 {
                        print("[RESPONSE][SUCCESS] "+completeRequest+":\n\(String(describing: json))")
                        
                        success(json!)
                    }
                    else {
                        // Show error code∫
                        let userInfo = [NSLocalizedFailureReasonErrorKey: "No response content error"]
                        let parsingError = NSError(domain: "com.template.sample", code: 9999, userInfo: userInfo)
                        failure(parsingError)
                    }
                    //}
                }
                else {
                    
                    print("[RESPONSE][ERROR] "+completeRequest+":\n" + response.result.error.debugDescription)
                    failure(response.result.error)
                }
        }
    }
    
    func getSearchResultList(search: String, success: @escaping (_: [SearchElement]) -> Void, failure: (_: Error?) -> Void){
        
        let params: [String: AnyObject] = [
            "term" : search as AnyObject,
            "entity" : "allArtist" as AnyObject,
            "attribute" : "allArtistTerm" as AnyObject
        ]
        self.baseRequest(self.SEARCH_ENDPOINT, method: HTTPMethod.get, parameters: params, success:
            {response in
                let data = try! JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                let response = try! JSONDecoder().decode(SearchResponse.self, from: data)
                if(response.results != nil){
                    success(response.results!)
                }
                else{
                    print("SearchError")
                }
                
        }, failure: {error in
            // Failure
            print("SearchError")
        })
    }
    
    func getSearchAlbumList(artistId: Int, success: @escaping (_: [Album]) -> Void, failure: (_: Error?) -> Void){
        //https://itunes.apple.com/lookup?id=909253&entity=album.
        let params: [String: AnyObject] = [
            "id" : artistId as AnyObject,
            "entity" : "album" as AnyObject
        ]
        self.baseRequest(self.ALBUM_ENDPOINT, method: HTTPMethod.get, parameters: params, success:
            {response in
                let data = try! JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                var response = try! JSONDecoder().decode(AlbumResponse.self, from: data)
                if(response.results != nil){
                    if((response.results?.count)! > 0){
                        response.results?.remove(at: 0)
                    }
                    success(response.results!)
                }
                else{
                    print("SearchError")
                }
                
        }, failure: {error in
            // Failure
            print("SearchError")
        })
    }
}
