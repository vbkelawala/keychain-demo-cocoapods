//
//  SetViewController.swift
//  KeychainSwiftTutorial
//
//  Created by Vatsal TechArk on 25/02/2020.
//  Copyright © 2020 Vatsal TechArk. All rights reserved.
//

import UIKit
import TinyConstraints
import KeychainSwift

struct Keys {
    static let profileImage = "profileImage"
    static let prefix = "vatsalbk_"
    static let nameText = "nameText"
    static let isAccountPrivate = "isAccountPrivate"
}

class SetViewController: UIViewController {
    
    let keychain = KeychainSwift(keyPrefix: Keys.prefix)
    
    let profileImageButtonHeight: CGFloat = 120
    lazy var profileImageButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.6980392157, green: 0.7450980392, blue: 0.7647058824, alpha: 1)
        button.layer.cornerRadius = profileImageButtonHeight / 2
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(profileImageButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        var textField = UITextField()
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = #colorLiteral(red: 0.6980392157, green: 0.7450980392, blue: 0.7647058824, alpha: 1)
        return textField
    }()
    
    let isPrivateLabel: UILabel = {
        let label = UILabel()
        label.text = "Account Private"
        return label
    }()
    
    let isPrivateSwitch: UISwitch = {
        let isPrivateSwitch = UISwitch()
        isPrivateSwitch.onTintColor = #colorLiteral(red: 0.9921568627, green: 0.7960784314, blue: 0.431372549, alpha: 1)
        isPrivateSwitch.layer.cornerRadius = 16
        isPrivateSwitch.backgroundColor = #colorLiteral(red: 0.6980392157, green: 0.7450980392, blue: 0.7647058824, alpha: 1)
        return isPrivateSwitch
    }()
    
    lazy var setIntoKeychainButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Set", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.7215686275, blue: 0.5803921569, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(setIntoKeychainButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var deleteNameButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Delete Name", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.7960784314, blue: 0.431372549, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(deleteNameButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var clearButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Clear Keychain", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = #colorLiteral(red: 0.8392156863, green: 0.1882352941, blue: 0.1921568627, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func profileImageButtonTapped() {
        showChooseSourceTypeAlertController()
    }
    
    @objc fileprivate func setIntoKeychainButtonTapped() {
        if profileImageButton.imageView?.image != nil {
            if let image = profileImageButton.imageView?.image?.jpegData(compressionQuality: 1.0) {
                if keychain.set(image, forKey: Keys.profileImage, withAccess: .accessibleWhenUnlocked) {
                    print("Image Set Succesfully")
                }else{
                    print("Didn't Set")
                }
            }
        }
        if nameTextField.text != "" {
            guard let name = nameTextField.text else {
                return
            }
            if keychain.set(name, forKey: Keys.nameText, withAccess: .accessibleWhenUnlocked) {
                print("done")
            }
        }
        if isPrivateSwitch.isOn == true {
            keychain.set(isPrivateSwitch.isOn, forKey: Keys.isAccountPrivate, withAccess: .accessibleWhenUnlocked)
        }else {
            keychain.set(isPrivateSwitch.isOn, forKey: Keys.isAccountPrivate, withAccess: .accessibleWhenUnlocked)
        }
    }
    
    @objc fileprivate func deleteNameButtonTapped() {
        if keychain.delete(Keys.nameText) {
            print("Name Deleted")
        }
    }
    
    @objc fileprivate func clearButtonTapped() {
        if keychain.clear() {
            print("KeyChain Cleared")
        }
    }
    
    @objc fileprivate func goToGetViewControllerBarButtonItemTapped() {
        let controller = GetViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupNavBar()
        setupViews()
        //keychain.synchronizable = true
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "Set"
        
        let goToGetViewControllerBarButtonItem = UIBarButtonItem(title: "Get", style: .done, target: self, action: #selector(goToGetViewControllerBarButtonItemTapped))
        navigationItem.setRightBarButton(goToGetViewControllerBarButtonItem, animated: true)
    }
    
    fileprivate func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.8745098039, green: 0.9019607843, blue: 0.9137254902, alpha: 1)
        
        view.addSubview(profileImageButton)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(isPrivateLabel)
        view.addSubview(isPrivateSwitch)
        view.addSubview(setIntoKeychainButton)
        view.addSubview(deleteNameButton)
        view.addSubview(clearButton)
        
        profileImageButton.centerXToSuperview()
        profileImageButton.topToSuperview(offset: 32, usingSafeArea: true)
        profileImageButton.width(profileImageButtonHeight)
        profileImageButton.height(profileImageButtonHeight)
        
        nameLabel.topToBottom(of: profileImageButton, offset: 24)
        nameLabel.leftToSuperview(offset: 12, usingSafeArea: true)
        nameLabel.width(50)
        
        nameTextField.centerY(to: nameLabel)
        nameTextField.leftToRight(of: nameLabel)
        nameTextField.rightToSuperview(offset: -12, usingSafeArea: true)
        nameTextField.height(32)
        
        isPrivateLabel.topToBottom(of: nameTextField, offset: 12)
        isPrivateLabel.leftToSuperview(offset: 12, usingSafeArea: true)
        isPrivateLabel.width(130)
        
        isPrivateSwitch.centerY(to: isPrivateLabel)
        isPrivateSwitch.leftToRight(of: isPrivateLabel)
        isPrivateSwitch.height(30)
        
        setIntoKeychainButton.topToBottom(of: isPrivateSwitch, offset: 12)
        setIntoKeychainButton.leftToSuperview(offset: 12, usingSafeArea: true)
        setIntoKeychainButton.rightToSuperview(offset: -12, usingSafeArea: true)
        setIntoKeychainButton.height(50)
        
        deleteNameButton.topToBottom(of: setIntoKeychainButton, offset: 12)
        deleteNameButton.leftToSuperview(offset: 12, usingSafeArea: true)
        deleteNameButton.rightToSuperview(offset: -12, usingSafeArea: true)
        deleteNameButton.height(50)
        
        clearButton.topToBottom(of: deleteNameButton, offset: 12)
        clearButton.leftToSuperview(offset: 12, usingSafeArea: true)
        clearButton.rightToSuperview(offset: -12, usingSafeArea: true)
        clearButton.height(50)
    }
}

extension SetViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showChooseSourceTypeAlertController() {
        let photoLibraryAction = UIAlertAction(title: "Choose a Photo", style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Take a New Photo", style: .default) { (action) in
            self.showImagePickerController(sourceType: .camera)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        Service.showAlert(style: .actionSheet, title: nil, message: nil, actions: [photoLibraryAction, cameraAction, cancelAction], completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.profileImageButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profileImageButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
}



