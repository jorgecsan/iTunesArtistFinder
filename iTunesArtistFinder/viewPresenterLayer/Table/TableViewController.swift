//
//  ViewController.swift
//  UnidadEditorialTest
//
//  Created by Jorge Cordero Sanchez on 5/10/18.
//  Copyright © 2018 Informagic. All rights reserved.
//

import UIKit
import SVProgressHUD

class TableViewController: UIViewController {

    var tablePresenter: TablePresenter!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    var searchList: [SearchElement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // initialize presenter
        tablePresenter = TablePresenter(viewController: self)
        
        // set textfield delegate
        /*searchTextField.addTarget(self, action: #selector(searchFieldDidChange), for: UIControlEvents.editingChanged)
        */
        
        // set table delegate
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func onSearchClick(_ sender: Any) {
        tablePresenter.search(string: searchTextField.text!)
    }
    /*@objc func searchFieldDidChange(){
    /*    if((searchTextField.text?.count)! > 2){
            self.showLoading()
            tablePresenter.search(string: searchTextField.text!)
        }*/
    }*/
    
    func showSearchList(resultList: [SearchElement]){
        self.hideLoading()
        self.searchList = resultList
        tableView.isScrollEnabled = true
        tableView.reloadData()
    }
    
    func showLoading() {
        
        SVProgressHUD.show(withStatus: "Loading...")
    }
    
    func hideLoading() {
        
        SVProgressHUD.dismiss()
    }
}

extension TableViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ArtistTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ArtistTableViewCell
        
        let result: SearchElement = searchList[indexPath.row]
        cell.presenter = self.tablePresenter
        cell.setArtist(artist: result)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // go to consultation
        let cell : ArtistTableViewCell = tableView.cellForRow(at: indexPath) as! ArtistTableViewCell
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        controller.artist = cell.artist
        self.navigationController?.pushViewController(controller, animated: true)
        //self.present(controller, animated: true, completion: nil)
    }
}

class ArtistTableViewCell: UITableViewCell{
    
    @IBOutlet var artistName: UILabel!
    @IBOutlet var artistGendre: UILabel!
    var presenter: TablePresenter!
    
    var artist: SearchElement!
    let dateHelper = DateHelper()
    
    @IBOutlet var album0Image: UIImageView!
    @IBOutlet var album0year: UILabel!
    @IBOutlet var album0name: UILabel!
    
    @IBOutlet var album1image: UIImageView!
    @IBOutlet var album1name: UILabel!
    @IBOutlet var album1year: UILabel!
    
    
    func setArtist(artist: SearchElement){
        self.artist = artist
        artistName.text = artist.artistName
        artistGendre.text = artist.primaryGenreName
        
        presenter.searchAlbumList(artistId: artist.artistId, success: getAlbumList)
    }
    
    func getAlbumList(albumList: [Album]){
        artist.albumList = albumList
        if(albumList.count > 1) {
            let album = albumList[1]
            if(album.collectionName != nil){album1name.text = album.collectionName}
            if(album.releaseDate != nil){album1year.text = dateHelper.getYearFromStringDate(stringDate: album.releaseDate!)}
            if(album.artworkUrl60 != nil){album1image.downloaded(from: album.artworkUrl60!)}
        }
        if(albumList.count > 0){
            let album = albumList[0]
            if(album.collectionName != nil){album0name.text = album.collectionName}
            if(album.releaseDate != nil){album0year.text = dateHelper.getYearFromStringDate(stringDate: album.releaseDate!)}
            if(album.artworkUrl60 != nil){album0Image.downloaded(from: album.artworkUrl60!)}
        }
    }
}

