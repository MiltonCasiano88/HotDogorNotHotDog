//
//  ViewController.swift
//  HotDogorNotHotDog
//
//  Created by Milton Casiano on 11/29/21.
//

import UIKit
import CoreML
import Vision


class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationController {

    
    

    // Delegation design pattern -> Text field: Properties
        
        // Steps to implement a delegate:
        // 1. Create an object
    let imagePicker = UIImagePickerController()
    let results = [VNClassificationObservation]
    
    //[0.8, 0.4, 0.3]
    
    @IBOutlet weak var imageView: UIImageView!
    
        //2. Initialize the delegate in View Did Load
    override func viewDidLoad() {
      super.viewDidLoad()
        imagePicker.delegate = self
        
        
        
        
    }
    
    
    
        //3. Implement its functions
    
    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        
        imagePicker.sourceType = .camera
        
    }
    
    func imagePickerController(_ picker:)
}

