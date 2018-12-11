//
//  DataManager.swift
//  UnidadEditorialTest
//
//  Created by Jorge Cordero Sanchez on 5/10/18.
//  Copyright © 2018 Informagic. All rights reserved.
//

import Foundation


class DataManager{
    
    let serverManager = ServerManager()
    
    func search(string: String, success: (_:([SearchElement]) -> Void), failure: (_:(Error?) -> Void)){
        serverManager.getSearchResultList(search: string, success: success, failure: failure as! (Error?) -> Void)
    }
    
    func searchAlbumList(artistId: Int, success: (_:([Album]) -> Void), failure: (_:(Error?) -> Void)){
        serverManager.getSearchAlbumList(artistId: artistId, success: success, failure: failure as! (Error?) -> Void)
    }
}
