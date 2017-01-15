//
//  Person.swift
//  Project 10
//
//  Created by Kenneth L. Graham on 1/15/17.
//  Copyright © 2017 Lauren Gaines LLC. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    let image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
