//
//  MovieTrailerViewController.swift
//  
//
//  Created by Kevin Thaw on 2/28/19.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController {

    @IBOutlet weak var trailerView: WKWebView!
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let movieId = movie["id"] as! Int
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let movies = dataDictionary["results"] as! [[String:Any]]
                
                let youtubeId = movies[0]
                
                let youtubeKey = youtubeId["key"] as! String//self.youtubeMovie["key"] as! String
                let baseUrl = URL(string: "https://www.youtube.com/watch?v=" + youtubeKey)
                let url1 = URLRequest(url: baseUrl!)
                
                self.trailerView.load(url1)
                
            }
            
        }
        task.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
