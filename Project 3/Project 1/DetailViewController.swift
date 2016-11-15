//
//  DetailViewController.swift
//  Project 3
//
//  Created by Kenneth L. Graham on 11/12/16.
//  Copyright © 2016 Kenneth Graham. All rights reserved.
//

import UIKit
import Social

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedImage
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    func shareTapped() {
//        let viewController = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: [])
//        viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
//        self.present(viewController, animated: true)
        
        // could do Twitter instead, with SLServiceTypeTwitter, instead of SLServiceTypeFacebook
        if let viewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook) {
            viewController.setInitialText("Check out this picture!")
            viewController.add(imageView.image!)
            viewController.add(URL(string: "http://www.photolib.noaa.gov/nssl"))
            self.present(viewController, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
