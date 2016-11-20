//
//  ViewController.swift
//  Project 5
//
//  Created by Kenneth L. Graham on 11/19/16.
//  Copyright © 2016 Kenneth Graham. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()
    var wordSelectionIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        
        if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt") {
            if let startWords = try? String(contentsOfFile: startWordsPath) {
                allWords = startWords.components(separatedBy: "\n")
            } else {
                loadDefaultWords()
            }
        } else {
            loadDefaultWords()
        }
        
        allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as! [String]
        
        startGame()
        
        
    }
    
    func loadDefaultWords() {
        allWords = ["silkworm", "encyclopedia", "earth", "racemic", "chemistry", "ocelot", "development"]
    }
    
    
    func startGame() {
        if wordSelectionIndex > (allWords.count - 1) {
            wordSelectionIndex = 0
        }
        
        title = allWords[wordSelectionIndex]
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
        wordSelectionIndex += 1
    }
    
    func promptForAnswer() {
        let alertController = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, alertController] _ in
            let answer = alertController.textFields![0]
            self.submit(answer: answer.text!)
        }
        
        alertController.addAction(submitAction)
        present(alertController, animated: true)
    }
    
    func submit(answer: String) {
        let lowerAnswer = answer.lowercased()
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer, at: 0)
            
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                } else {
                    showErrorMessage(withTitle: "Word not recognized", withMessage: "No making up words!")
                }
            } else {
                showErrorMessage(withTitle: "Word was already used", withMessage: "Be more original!")
            }
        } else {
            showErrorMessage(withTitle: "Word is not possible", withMessage: "You can't spell that word from \(title!.lowercased())")
        }
    }
    
    func showErrorMessage(withTitle errorTitle: String, withMessage errorMessage: String) {
        let alertController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = title!.lowercased()
        
        for letter in word.characters {
            if let index = tempWord.range(of: String(letter)) {
                tempWord.remove(at: index.lowerBound)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word) && word != title!.lowercased()
    }
    
    func isReal(word: String) -> Bool {
        if (word.utf16.count < 3) {
            return false
        }
        
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

