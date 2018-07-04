//
//  ViewController.swift
//  JSONTutorial
//
//  Created by Amee Thakkar on 7/4/18.
//  Copyright © 2018 Amee Thakkar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var friendsTableView: UITableView!
    
    var tableData = [[String : AnyObject]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get the json url
        let url = Bundle.main.url(forResource: "friends", withExtension: "json")
        
        //obtain the data from the url
        if let url = url{
            let data = NSData(contentsOf: url)
            
            if let data = data {
                
                do{
                    let object = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
                    
                    if let object = object as? [String : AnyObject]{
                        
                        if let allFriends = object["friends"] as? [[String : AnyObject]]{
                            
                            tableData = allFriends
                            friendsTableView.reloadData()
                        }
                    }
                    
                }catch{
                    print("error occured")
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "JsonCell", for: indexPath)
        
        let friend = tableData[indexPath.row]
        let name = friend["fullName"] as? String
        let year = friend["dob"] as? String
        
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = year
        
        return cell
    }

}

