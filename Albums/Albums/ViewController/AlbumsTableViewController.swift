//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Enzo Jimenez-Soto on 5/7/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    // MARK: - Properties
    var albumController = AlbumController()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        albumController.fetchAlbums { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumController.albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath)
        let album = albumController.albums[indexPath.row]
        
        cell.textLabel?.text = album.name
        cell.detailTextLabel?.text = album.artist

        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "albumDetailSegue" {
            guard let destinationVC = segue.destination as? AlbumDetailTableViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            let album = albumController.albums[indexPath.row]
            
            destinationVC.albumController = albumController
            destinationVC.album = album
        } else if segue.identifier == "addAlbumSegue" {
            let destinationVC = segue.destination as! AlbumDetailTableViewController
            
            destinationVC.albumController = albumController
        }
    }

}
