//
//  TestViewController.swift
//  OokbeeTest
//
//  Created by Teerapat on 10/5/19.
//  Copyright © 2019 OokbeeTest. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                // Show Loading or something to let user know here
            }
            
            // Start call api
            self.callApiLoadBooks()
            
            DispatchQueue.main.async {
                // Do update UI here
            }
        }
    }
    
    func callApiLoadBooks() {
        let authorization = "YOUR TOKEN OR ANY AUTHEN KEY"
        let userId = "YOUR USER ID"
        ServiceAPIMethod.OokbeeApiBooks(authorization: authorization, userId: userId, completionHandler: { result,error -> Void in
            if (result != nil) {
                let results = result as! [BookModel]
                print("\(results)")
                // Now you get your book list and keep in results
            } else {
                DispatchQueue.main.async {
                    // Show error message
                }
            }
        })
    }
}
