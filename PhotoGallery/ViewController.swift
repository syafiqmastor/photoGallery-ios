//
//  ViewController.swift
//  PhotoGallery
//
//  Created by Syafiq Mastor on 1/17/17.
//  Copyright © 2017 Syafiq Mastor. All rights reserved.
//

import UIKit
import Photos
import Alamofire
import SwiftyJSON

class ViewController: UIViewController{

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func handleAddBarButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocalCollectionViewController") as! LocalCollectionViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func loadImage() {
        
    }
    
//    func GET(URLString : String, parameters : [String: String]?, fromViewController viewController : UIViewController, completion : @escaping (_ output : JSON?) -> Void) {
//        
//        let token = ""
////            Singleton.sharedInstance.tokenAPI
//        print(token)
//        var params = parameters
//        if params == nil {
//            params = ["token" : token]
//        } else {
//            params!["token"] = token
//        }
//        
//        let url = URL(string :"")
//        
//        Alamofire.request(.GET, url, parameters: params).responseJSON { (response) in
//            
//            switch response.result {
//            case .Success(let value) :
//                let swiftyJSON = JSON(value)
//                completion(output: swiftyJSON)
//            case .Failure( _) :
//                self.alertError(forResponse: response, delegate: viewController)
//            }
//        }
//    }

}

