//
//  GetViewController.swift
//  KeychainSwift
//
//  Created by Vatsal TechArk on 25/02/2020.
//  Copyright © 2020 Vatsal TechArk. All rights reserved.
//

import UIKit
import TinyConstraints
import KeychainSwift

class GetViewController: UIViewController {
    
    let keychain = KeychainSwift(keyPrefix: Keys.prefix)
    
    let profileImageViewHeight: CGFloat = 120
    lazy var profileImageView: UIImageView = {
        var iv = UIImageView()
        iv.backgroundColor = #colorLiteral(red: 0.6980392157, green: 0.7450980392, blue: 0.7647058824, alpha: 1)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = profileImageViewHeight / 2
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name: N/A"
        return label
    }()
    
    let isPrivateLabel: UILabel = {
        let label = UILabel()
        label.text = "Private Account: N/A"
        return label
    }()
    
    lazy var getFromKeychainButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Get", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = #colorLiteral(red: 0.8392156863, green: 0.1882352941, blue: 0.1921568627, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(getFromKeychainButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func getFromKeychainButtonTapped() {
        if let imageData = keychain.getData(Keys.profileImage) {
            if keychain.lastResultCode != noErr { print("Keychain Last resultCode") }
            let image = UIImage(data: imageData)
            profileImageView.image = image
        }
        if let name = keychain.get(Keys.nameText) {
            nameLabel.text = "Name: \(name)"
        }
        
        if let isAccPrivate = keychain.getBool(Keys.isAccountPrivate) {
            if isAccPrivate {
                isPrivateLabel.text = "Private Account: true"
            }else {
                isPrivateLabel.text = "Private Account: false"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupNavBar()
        setupViews()
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "Get"
    }
    
    fileprivate func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.8745098039, green: 0.9019607843, blue: 0.9137254902, alpha: 1)
        
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(isPrivateLabel)
        view.addSubview(getFromKeychainButton)
        
        profileImageView.centerXToSuperview()
        profileImageView.topToSuperview(offset: 32, usingSafeArea: true)
        profileImageView.width(profileImageViewHeight)
        profileImageView.height(profileImageViewHeight)
        
        nameLabel.topToBottom(of: profileImageView, offset: 24)
        nameLabel.leftToSuperview(offset: 12, usingSafeArea: true)
        nameLabel.rightToSuperview(offset: 12, usingSafeArea: true)
        nameLabel.height(32)
        
        isPrivateLabel.topToBottom(of: nameLabel, offset: 0)
        isPrivateLabel.leftToSuperview(offset: 12, usingSafeArea: true)
        isPrivateLabel.rightToSuperview(offset: 12, usingSafeArea: true)
        isPrivateLabel.height(32)
        
        getFromKeychainButton.topToBottom(of: isPrivateLabel, offset: 12)
        getFromKeychainButton.leftToSuperview(offset: 12, usingSafeArea: true)
        getFromKeychainButton.rightToSuperview(offset: -12, usingSafeArea: true)
        getFromKeychainButton.height(50)
    }
}

