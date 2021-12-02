//
//  ViewController.swift
//  HotDogorNotHotDog
//
//  Created by Milton Casiano on 11/29/21.
//

import UIKit
import CoreML
import Vision


class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    

    // Delegation design pattern -> Text field: Properties
        
        // Steps to implement a delegate:
        // 1. Create an object
    let imagePicker = UIImagePickerController()
    
    var result: [VNClassificationObservation] = []
    
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
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
                               [UIImagePickerController.InfoKey : Any]) {


        if let image = info[.originalImage] as? UIImage {
            
            imageView.image = image
            
            imagePicker.dismiss(animated: true , completion : nil)
            
            guard let ciImage = CIImage(image : image) else {return}
            
            detect(image: ciImage)
    }


        func detect(image : CIImage) {


            if let model = try? VNCoreMLModel(for : Inceptionv3().model) {
                
                // request the result
                
                let request = VNCoreMLRequest(model: model, completionHandler: { (request, error) in
                            

                        // Results -> (0.8, 0.7, 0.3) -> 0.8: Hot Dog
                        guard let results = request.results as? [VNClassificationObservation], let topResult = results.first   else {return}
                        
                        
                        if topResult.identifier.contains("hotdog") {
                            //Main Thread   -   | | | |  | | |
                            DispatchQueue.main.async {
                                self.navigationItem.title = "Hotdog"
                                
                            }
                        }
                        
                        else {
                            
                            
                            DispatchQueue.main.async {
                                self.navigationItem.title = " Not Hotdog"
                                
                            }
                        }
                    
                    
                })
        
        // handler
        let handler = VNImageRequestHandler(ciImage : image)
                    do {
                        try handler.perform([request])
                    }
                    
                    catch {
                        
                        print(error)
                    }
    }
}
}
}
