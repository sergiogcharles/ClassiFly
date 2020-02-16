//
//  ViewController.swift
//  CouscousOrNotCouscous
//
//  Created by Sergio Charles on 15-02-2020.
//  Copyright © 2020 Sergio Charles. All rights reserved.
//

import UIKit
import CoreML
import Vision
import Photos

let screenWidth = UIScreen.main.bounds.width

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    
//    let logo: UIImageView = {
//        let image = UIImageView(image: #imageLiteral(resourceName: "couscous").resized(newSize: CGSize(width: screenWidth - 40, height: (screenWidth - 40)/1.6 )))
//        image.translatesAutoresizingMaskIntoConstraints = false
//       return image
//    }()
    
    let classifyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 60)
        label.textColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
        label.numberOfLines = 0
        label.text = "ClassiFly"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let upload: BtnPleinLarge = {
        let button = BtnPleinLarge()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonToUpload(_:)), for: .touchUpInside)
        button.setTitle("Upload an image", for: .normal)
        let icon = UIImage(named: "upload")?.resized(newSize: CGSize(width: 50, height: 50))
        button.addRightImage(image: icon!, offset: 30)
        button.backgroundColor = #colorLiteral(red: 0.7098039216, green: 0.5137254902, blue: 0.5529411765, alpha: 1)
        button.layer.borderColor = #colorLiteral(red: 0.7098039216, green: 0.5137254902, blue: 0.5529411765, alpha: 1).cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 5)
        button.layer.cornerRadius = 10
        button.layer.shadowRadius = 8
        button.layer.masksToBounds = true
        button.clipsToBounds = false
        button.contentHorizontalAlignment = .left
        button.layoutIfNeeded()
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        button.titleEdgeInsets.left = 0
        
        return button
    }()
    
    let openCamera: BtnPleinLarge = {
        let button = BtnPleinLarge()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loadInDroneImage), for: .touchUpInside)
        button.setTitle("Use drone picture", for: .normal)
        let icon = UIImage(named: "camera")?.resized(newSize: CGSize(width: 50, height: 50))
        button.addRightImage(image: icon!, offset: 30)
        button.backgroundColor = #colorLiteral(red: 0.4274509804, green: 0.4078431373, blue: 0.4588235294, alpha: 1)
        button.layer.borderColor = #colorLiteral(red: 0.4274509804, green: 0.4078431373, blue: 0.4588235294, alpha: 1).cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 5)
        button.layer.cornerRadius = 10
        button.layer.shadowRadius = 8
        button.layer.masksToBounds = true
        button.clipsToBounds = false
        button.contentHorizontalAlignment = .left
        button.layoutIfNeeded()
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        button.titleEdgeInsets.left = 0
        
        return button
    }()
    
    var images: [UIImage]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addSubviews()
        setupLayout()
        
    }
    
    func addSubviews() {
        //view.addSubview(logo)
        view.addSubview(classifyLabel)
        view.addSubview(upload)
        view.addSubview(openCamera)
    }
    
    func setupLayout() {
        
        //logo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        //logo.topAnchor.constraint(equalTo: self.view.safeTopAnchor, constant: 60).isActive = true
        
        classifyLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        classifyLabel.topAnchor.constraint(equalTo: self.view.safeTopAnchor, constant: 120).isActive = true
        
        upload.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        upload.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        upload.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
        upload.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        openCamera.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        openCamera.topAnchor.constraint(equalTo: upload.bottomAnchor, constant: 30).isActive = true
        openCamera.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
        openCamera.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            guard let model = try? VNCoreMLModel(for: ImageClassifier().model) else {
                fatalError("Unable to load model")
            }
            let request = VNCoreMLRequest(model: model) {[weak self] request, error in
                guard let results = request.results as? [VNClassificationObservation],
                    let topResult = results.first
                    else {
                        fatalError("Unexpected results")
                }
                
                // depending on classification
                
                // Update the main UI thread with our result
                DispatchQueue.main.async {[weak self] in
                    let controller = CouscousImageViewController()
                    controller.couscousImage.image = pickedImage
                    if topResult.identifier == "couscous" {
                        controller.isOrNotCouscous.image = #imageLiteral(resourceName: "isCouscous")
                        self?.present(controller, animated: true)
                        //self?.navigationController?.pushViewController(controller, animated: true)
                    } else {
                        controller.isOrNotCouscous.image = #imageLiteral(resourceName: "isNotCouscous")
                        self?.present(controller, animated: true)
                        //self?.navigationController?.pushViewController(controller, animated: true)
                    }
                }
            }
            
            guard let ciImage = CIImage(image: pickedImage)
                else { fatalError("Cannot read picked image")}
            
            // Run the classifier
            let handler = VNImageRequestHandler(ciImage: ciImage)
            DispatchQueue.global().async {
                do {
                    try handler.perform([request])
                } catch {
                    print(error)
                }
            }
        }
        
    }
    
    @objc func buttonToUpload(_ sender: BtnPleinLarge) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func buttonToOpenCamera(_ sender: BtnPleinLarge) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func loadInDroneImage() {
        
        queryLastPhoto(resizeTo: nil) { (image) in
            
            print("image is: \(image)")
            
            guard let model = try? VNCoreMLModel(for: ImageClassifier().model) else {
                    fatalError("Unable to load model")
                }
                let request = VNCoreMLRequest(model: model) {[weak self] request, error in
                    guard let results = request.results as? [VNClassificationObservation],
                        let topResult = results.first
                        else {
                            fatalError("Unexpected results")
                    }
                    
                    // depending on classification
                    
                    // Update the main UI thread with our result
                    DispatchQueue.main.async {[weak self] in
                        print("identifier: \(topResult.identifier)")
                        let controller = CouscousImageViewController()
                        controller.couscousImage.image = image
                        if topResult.identifier == "couscous" {
                            controller.isOrNotCouscous.image = #imageLiteral(resourceName: "isCouscous")
                            self?.present(controller, animated: true)
                            //self?.navigationController?.pushViewController(controller, animated: true)
                        } else {
                            controller.isOrNotCouscous.image = #imageLiteral(resourceName: "isNotCouscous")
                            self?.present(controller, animated: true)
                            print("will push: \(controller)")
                            //self?.navigationController?.pushViewController(controller, animated: true)
                        }
                    }
                }
            
            guard let ciImage = CIImage(image: image!)
                    else { fatalError("Cannot read picked image")}
                
                // Run the classifier
                let handler = VNImageRequestHandler(ciImage: ciImage)
                DispatchQueue.global().async {
                    do {
                        try handler.perform([request])
                    } catch {
                        print(error)
                    }
                }
            
            
        }
        
    }
    
    func queryLastPhoto(resizeTo size: CGSize?, queryCallback: @escaping ((UIImage?) -> Void)) {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true

        let fetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
        if let asset = fetchResult.firstObject {
            let manager = PHImageManager.default()

            let targetSize = size == nil ? CGSize(width: asset.pixelWidth, height: asset.pixelHeight) : size!

            manager.requestImage(for: asset,
                                 targetSize: targetSize,
                                 contentMode: .aspectFit,
                                 options: requestOptions,
                                 resultHandler: { image, info in
                                    queryCallback(image)
            })
        }

    }
  
    
    }


    
    

