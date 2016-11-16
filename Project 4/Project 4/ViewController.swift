//
//  ViewController.swift
//  Project 4
//
//  Created by Kenneth L. Graham on 11/15/16.
//  Copyright © 2016 Kenneth Graham. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let websites = ["apple.com", "github.com", "google.com", "hackingwithswift.com"]
//    var selectedWebsite: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WebsiteLoadingSegue" {
            let detailView = segue.destination as! DetailViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                detailView.siteToLoad = indexPath.row
                detailView.websites = websites
            }
        }
    }
    
    // number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    // dequeue a cell and set its text
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.selectedWebsite = indexPath.row
//        self.performSegue(withIdentifier: "WebsiteLoadingSegue", sender: self)
        
//        if let detailView = storyboard?.instantiateViewController(withIdentifier: "Webview") as? DetailViewController {
//            self.selectedWebsite = indexPath.row
//            detailView.siteToLoad = indexPath.row
//            detailView.websites = websites
//            navigationController?.pushViewController(detailView, animated: true)
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
