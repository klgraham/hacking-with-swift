//
//  ViewController.swift
//  Project 7
//
//  Created by Kenneth L. Graham on 11/27/16.
//  Copyright © 2016 Kenneth Graham. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSelector(inBackground: #selector(fetchJson), with: nil)
        
//        let urlString: String
//        
//        if navigationController?.tabBarItem.tag == 0 {
//            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
//        } else {
//            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
//
//        }
        
//        DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
//            if let url = URL(string: urlString) {
//                if let data = try? Data(contentsOf: url) {
//                    let json = JSON(data: data)
//                    if json["metadata"]["responseInfo"]["status"].intValue == 200 {
//                        self.parseAndDisplay(json: json)
//                        return
//                    }
//                }
//            }
//        }
        
        
//        showError()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let petitionDetailView = DetailViewController()
        petitionDetailView.petitionDetail = petitions[indexPath.row]
        navigationController?.pushViewController(petitionDetailView, animated: true)
    }
    
    func fetchJson() {
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            
        }

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data: data)
                if json["metadata"]["responseInfo"]["status"].intValue == 200 {
                    self.parseAndDisplay(json: json)
                    return
                }
            }
        }

        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    func parseAndDisplay(json: JSON) {
        for result in json["results"].arrayValue {
            let title = result["title"].stringValue
            let body = result["body"].stringValue
            let sigs = result["signatureCount"].intValue
            let petition = Petition(title: title, body: body, signatureCount: sigs)
            petitions.append(petition)
        }
        
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        
//        DispatchQueue.main.async { [unowned self] in
//            self.tableView.reloadData()
//        }
    }
    
    func showError() {
//        DispatchQueue.main.async { [unowned self] in
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
//        }
    }
}

