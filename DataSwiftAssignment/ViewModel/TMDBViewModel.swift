//
//  TMDBViewModel.swift
//  DataSwiftAssignment
//
//  Created by Angelos Staboulis on 12/7/20.
//  Copyright © 2020 Angelos Staboulis. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
protocol TMDBViewModelDelegate{
    
    func fetchMovies(searchString:String,completion:@escaping (([TMDBModel])->()))

    func loadMovies(completion:@escaping ()->())

    func numberOfRows(section:Int) -> Int

    func getMovie(indexPath:IndexPath) -> TMDBModel
}
class TMDBViewModel:TMDBViewModelDelegate{
    
    func loadMovies(completion: @escaping () -> ()) {
        
        fetchMovies(searchString: "sex") { (array) in
            self.moviesModel = array
            for countMovies in 0..<self.moviesModel.count{
                RealmDBModel.sharedInstance.addItem(item:RealmModel(id:countMovies,poster: array[countMovies].poster!, title: array[countMovies].title!))
            }
            completion()
        }
    }
    
    var moviesModel:[TMDBModel]=[]
    
    
    func fetchMovies(searchString:String,completion: @escaping (([TMDBModel]) -> ())) {
        let urlMain = URL(string: mainURL + "&query=\(searchString)&page=1&include_adult=false")
        let request = URLRequest(url: urlMain!)
        Alamofire.request(request as URLRequestConvertible).responseJSON { (response) in
            let json = JSON(response.result.value!)
            for counter in 0..<json["results"].count{
                self.moviesModel.append(TMDBModel(title:json["results"][counter]["title"].stringValue, poster: "https://image.tmdb.org/t/p/w500/"+json["results"][counter]["poster_path"].stringValue))
            
            }
            completion(self.moviesModel)
        }
    }
   
    func numberOfRows(section:Int) -> Int {
        moviesModel.count
    }
    
    func getMovie(indexPath:IndexPath) -> TMDBModel {
        
        return moviesModel[indexPath.row]
    }
    
    
    
}
