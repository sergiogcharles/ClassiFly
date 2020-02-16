//
//  ClassificationViewController.swift
//  ClassiFly
//
//  Created by Sergio Charles on 15-02-2020.
//  Copyright © 2020 Sergio Charles. All rights reserved.
//

import UIKit

class ClassificationViewController: UIViewController {

    let selectedImage: UIImageView = {
       let image = UIImageView(image: UIImage())
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let outcomeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let accuracyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = UIColor(red: 52/255, green: 199/255, blue: 89/255, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dissmissButton: BtnPleinLarge = {
        let button = BtnPleinLarge()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonToDissmiss(_:)), for: .touchUpInside)
        button.setTitle("Done", for: .normal)
       return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupLayout()
    }
    
    func addSubviews() {
        view.addSubview(dissmissButton)
        view.addSubview(outcomeLabel)
        view.addSubview(accuracyLabel)
        view.addSubview(selectedImage)
    }
    
    func setupLayout() {
        
        dissmissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dissmissButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        dissmissButton.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
        //dissmissButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        
        // outcome label
        outcomeLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingBottom: 0, paddingRight: 20)
        
        // accurancy label
        accuracyLabel.anchor(top: outcomeLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 20, paddingBottom: 0, paddingRight: 20)
        
                        
        selectedImage.anchor(top: accuracyLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 350)
        
        selectedImage.image?.resizeImageToSize(targetSize: CGSize(width: view.frame.width - 20, height: 350))
        
        dissmissButton.anchor(top: selectedImage.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
        
        
        //selectedImage.anchor(top: accuracyLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 5)
        //selectedImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
  
    }
    
    @objc func buttonToDissmiss(_ sender: BtnPleinLarge) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
