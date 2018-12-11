//
//  ViewController.swift
//  UnidadEditorialTest
//
//  Created by Jorge Cordero Sanchez on 5/10/18.
//  Copyright © 2018 Informagic. All rights reserved.
//

import UIKit
import SVProgressHUD

class DetailViewController: UITableViewController {
    var artist: SearchElement!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        // set table delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        showAlbumList()
    }
    
    func showAlbumList(){
        self.hideLoading()
        tableView.isScrollEnabled = true
        tableView.reloadData()
    }
    
    func showLoading() {
        SVProgressHUD.show(withStatus: "Loading...")
    }
    
    func hideLoading() {
        
        SVProgressHUD.dismiss()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artist.albumList!.count
        //return searchList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AlbumTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! AlbumTableViewCell
        
        let result: Album = artist.albumList![indexPath.row]
        cell.setAlbum(album: result)
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // go to consultation
        //let cell : CustomTableViewCell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
    }
}

class AlbumTableViewCell: UITableViewCell{

    @IBOutlet var albumImage: UIImageView!
    @IBOutlet var albumName: UILabel!
    @IBOutlet var albumYear: UILabel!
    var album: Album!
    let dateHelper = DateHelper()
    
    func setAlbum(album: Album){
        self.album = album
        albumName.text = album.collectionName
        albumYear.text = dateHelper.getYearFromStringDate(stringDate: album.releaseDate!)
        if(album.artworkUrl60 != nil){
            albumImage.downloaded(from: album.artworkUrl60!)
        }
    }
    
}

