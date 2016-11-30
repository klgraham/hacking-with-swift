//
//  Petition.swift
//  Project 7
//
//  Created by Kenneth L. Graham on 11/29/16.
//  Copyright © 2016 Kenneth Graham. All rights reserved.
//

struct Petition: CustomStringConvertible {
    let title: String
    let body: String
    let signatureCount: Int
    
    var description: String {
        return "[title: \(title), body: \(body), signatureCount: \(signatureCount)]"
    }
}
