//
//  DetailsViewController.swift
//  ArtBook2
//
//  Created by HHK on 23.04.2019.
//  Copyright © 2019 Halil Hakan Karabay. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tabloadi: UITextField!
    @IBOutlet weak var artistadi: UITextField!
    @IBOutlet weak var tabloyili: UITextField!
    
    var chosenPainting = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Jest algılayıcılar (gesturerecognizer) herhangi bir öğeyi veya nesneyi buton gibi kullanmaya yarıyor.
        // !!!!! Önemli bilgi bunu ezberle !!!!!!!
        imageView.isUserInteractionEnabled = true
        let gestureRecogziner = UITapGestureRecognizer(target: self, action: #selector(DetailsViewController.selectImage))
        imageView.addGestureRecognizer(gestureRecogziner)
        
        print(chosenPainting)
        
       

       
    }
    
    
    @objc func selectImage() {
        
       // Picker, fotoğraf seçmeyi sağlıyor. !!!!!! info.plist ' ten izin almayı unutma !!!!!!
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker,animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //didFinishPickingMediaWithInfo fotoğraf seçme işlemi bittikten sonra ne yapılacağını söylüyor.
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newArt = NSEntityDescription.insertNewObject(forEntityName: "Boyama", into: context)
        
        //attributes
        
        newArt.setValue(artistadi.text, forKey: "artist")
        newArt.setValue(tabloadi.text, forKey: "name")
        
        if let year = Int(tabloyili.text!) {
            newArt.setValue(year, forKey: "year")
        }
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        newArt.setValue(data, forKey: "image")
        
        do {
            
            try context.save()
            print("No error")
        
        }catch {
            
            print("Error!")
            
        }
        
    }
    
    
}
