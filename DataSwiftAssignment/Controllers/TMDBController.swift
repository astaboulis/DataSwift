//
//  TMDBController.swift
//  DataSwiftAssignment
//
//  Created by Angelos Staboulis on 12/7/20.
//  Copyright © 2020 Angelos Staboulis. All rights reserved.
//

import UIKit
import SDWebImage
import Network

protocol FillTableViewDelegate{
    func fillTable()
    func fillTableOffline()
    func fillTableCell(cell:TMDBCellTableViewCell,indexPath:IndexPath)
    func fillOfflineTableCell(cell:TMDBCellTableViewCell,indexPath:IndexPath)
}

class TMDBController: UITableViewController {
    
    let viewmodel = TMDBViewModel()
    
    var isConnected:Bool=false
    
    let monitor = NWPathMonitor()
    
    let queue = DispatchQueue(label: "InternetConnectionMonitor")
    
    var countMovies:Int=0
    
    var movies:[TMDBModel]=[]{
        didSet{
            self.tableView.reloadData()
        }
    }
    var moviesOffline:[RealmModel]=[]{
        didSet{
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let semaphore = DispatchSemaphore(value: 0)
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                self.fillTable()
                self.isConnected = true
            } else {
                self.fillTableOffline()
                self.isConnected = false
            }
            semaphore.signal()
        }
        
        monitor.start(queue: queue)
        
        semaphore.wait()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isConnected {
            countMovies =  viewmodel.numberOfRows(section: section)
        }
        else{
            countMovies = self.moviesOffline.count
        }
        return countMovies
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TMDBCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TMDBCellTableViewCell
        if isConnected {
            self.fillTableCell(cell: cell, indexPath: indexPath)
        }
        else{
            self.fillOfflineTableCell(cell: cell, indexPath: indexPath)
        }
        return cell
    }
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension TMDBController {
    func setupView(){
        tableView.register(UINib(nibName: "TMDBCellTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
}
extension TMDBController:FillTableViewDelegate{
    
    func fillTableOffline() {
        for countMovies in 0..<RealmDBModel.sharedInstance.getItems().count{
            let element = RealmModel()
            element.title = RealmDBModel.sharedInstance.getItems()[countMovies].title
            element.poster = RealmDBModel.sharedInstance.getItems()[countMovies].poster
            moviesOffline.append(element)
        }
    }
    func fillOfflineTableCell(cell: TMDBCellTableViewCell,indexPath:IndexPath) {
        if indexPath.row < moviesOffline.count {
            cell.lblMovie.numberOfLines = 0
            cell.lblMovie.text = moviesOffline[indexPath.row].title
            let urlMain = URL(string: moviesOffline[indexPath.row].poster)
            cell.imgMovie.sd_setImage(with: urlMain, completed: nil)
        }
    }
    func fillTableCell(cell: TMDBCellTableViewCell,indexPath:IndexPath) {
        cell.lblMovie.numberOfLines = 0
        cell.lblMovie.text = viewmodel.getMovie(indexPath: indexPath).title
        let urlMain = URL(string: viewmodel.getMovie(indexPath: indexPath).poster!)
        cell.imgMovie.sd_setImage(with: urlMain, completed: nil)
    }
    
    func fillTable() {
        self.viewmodel.loadMovies {
            self.tableView.reloadData()
        }
    }
    
}
