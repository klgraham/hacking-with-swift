//
//  ViewController.swift
//  Project 10
//
//  Created by Kenneth L. Graham on 1/15/17.
//  Copyright © 2017 Lauren Gaines LLC. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var people = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // UICollectionViewController functions
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as! PersonCell
        
        let person = people[indexPath.item]
        cell.name.text = person.name
        let imagePath = getDocumentsDirectory().appendingPathComponent(person.image).path
        cell.imageView.image = UIImage(contentsOfFile: imagePath)
        cell.imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Change name or delete photo?", message: nil, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        alertController.addAction(UIAlertAction(title: "Delete", style: .destructive) { [unowned self] _ in
            self.people.remove(at: indexPath.item)
            self.collectionView?.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Change", style: .default) { [unowned self] _ in
            let person = self.people[indexPath.item]
            
            let innerAlertController = UIAlertController(title: "Enter new name", message: nil, preferredStyle: .alert)
            innerAlertController.addTextField()
            
            innerAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            innerAlertController.addAction(UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
                person.name = innerAlertController.textFields![0].text!
                self.collectionView?.reloadData()
            })
            
            self.present(innerAlertController, animated: true)
            
            
        })
        
        
        
        present(alertController, animated: true)
    }
    
    func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    // UIImagePickerControllerDelegate functions
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage]
            as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = UIImageJPEGRepresentation(image, 80) {
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView?.reloadData()
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}

