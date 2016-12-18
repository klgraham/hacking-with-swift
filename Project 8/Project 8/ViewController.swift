//
//  ViewController.swift
//  Project 8
//
//  Created by Kenneth L. Graham on 12/18/16.
//  Copyright © 2016 Kenneth Graham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cluesLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var currentAnswer: UITextField!
    @IBOutlet weak var scoresLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitTapped(_ sender: Any) {
    }

    @IBAction func clearTapped(_ sender: Any) {
    }
}

