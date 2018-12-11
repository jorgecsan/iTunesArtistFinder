//
//  TablePresenter.swift
//  UnidadEditorialTest
//
//  Created by Jorge Cordero Sanchez on 5/10/18.
//  Copyright © 2018 Informagic. All rights reserved.
//



class TablePresenter{
    
    let viewController: TableViewController
    let dataManager = DataManager()
    
    init(viewController: TableViewController){
        self.viewController = viewController
    }
    
    func search(string: String){
        dataManager.search(string: string, success: searchResponseSuccess, failure: responseFailure)
    }
    
    func searchResponseSuccess(resultList: [SearchElement]){
        viewController.showSearchList(resultList: resultList)
    }
    
    func searchAlbumList(artistId: Int, success: (_:([Album]) -> Void)){
        dataManager.searchAlbumList(artistId: artistId, success: {
            albumList in
            if(albumList != nil && albumList.count > 0){
                success(albumList)
            }
        }, failure: responseFailure)
    }
    
    func responseFailure(error: Error?){
        
    }
}
