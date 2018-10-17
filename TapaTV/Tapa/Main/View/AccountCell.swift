//
//  AccountCell.swift
//  TapaTV
//
//  Created by SimpuMind on 5/16/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit

public class AccountCell: UITableViewCell {
    
    private lazy var accountView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = #colorLiteral(red: 0.1367795458, green: 0.1363631674, blue: 0.184029981, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var accountLineView: UIView = {
        let view = UIView()
        view.backgroundColor =  #colorLiteral(red: 0.3716229961, green: 0.3704917175, blue: 0.5, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var accountLabel: UILabel = {
        let label = UILabel()
        label.text = "My Account"
        label.textColor = .white
        let titleSize = Constant.isCompact(view: self, yes: 22, no: 24)
        label.font = UIFont(name: "Avenir-Bold", size: CGFloat(titleSize))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var fullNameTextField: UITextField = {
        let fullNameTextField = UITextField()
        fullNameTextField.placeholder = "Full Name"
        fullNameTextField.autocorrectionType = .no
        fullNameTextField.backgroundColor = #colorLiteral(red: 0.8815236358, green: 0.8815236358, blue: 0.8815236358, alpha: 1)
        fullNameTextField.layer.cornerRadius = 5
        fullNameTextField.setPadding()
        fullNameTextField.translatesAutoresizingMaskIntoConstraints = false
        return fullNameTextField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.backgroundColor = #colorLiteral(red: 0.8815236358, green: 0.8815236358, blue: 0.8815236358, alpha: 1)
        textField.layer.cornerRadius = 5
        textField.setPadding()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var accountsaveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4823529412, blue: 1, alpha: 1)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var passwordLineView: UIView = {
        let view = UIView()
        view.backgroundColor =  #colorLiteral(red: 0.3716229961, green: 0.3704917175, blue: 0.5, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var currentPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Current Password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = #colorLiteral(red: 0.8815236358, green: 0.8815236358, blue: 0.8815236358, alpha: 1)
        textField.layer.cornerRadius = 5
        textField.setPadding()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var newPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "New Password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = #colorLiteral(red: 0.8815236358, green: 0.8815236358, blue: 0.8815236358, alpha: 1)
        textField.layer.cornerRadius = 5
        textField.setPadding()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var comfirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Comfirm New Password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = #colorLiteral(red: 0.8815236358, green: 0.8815236358, blue: 0.8815236358, alpha: 1)
        textField.layer.cornerRadius = 5
        textField.setPadding()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var saveNewPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Update", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4823529412, blue: 1, alpha: 1)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(accountView)
        [accountLabel, accountLineView, fullNameTextField, emailTextField, accountsaveButton, passwordLineView, currentPasswordTextField, newPasswordTextField, comfirmPasswordTextField, saveNewPasswordButton].forEach{accountView.addSubview($0)}
        
        backgroundColor = .clear
        selectionStyle = .none
        
        let user = ApiService.shared.user
        
        emailTextField.text = user.email
        fullNameTextField.text = user.name
        
        print(user.dictionaryRepresentation())
        print("f")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        accountView.topAnchor.align(to: topAnchor)
        accountView.leftAnchor.align(to: leftAnchor)
        accountView.rightAnchor.align(to: rightAnchor)
        accountView.bottomAnchor.align(to: bottomAnchor, offset: -10)
        
        let accountSize: CGFloat = Constant.isCompact(view: self, yes: 45, no: 65)
        accountLabel.topAnchor.align(to: accountView.topAnchor)
        accountLabel.leftAnchor.align(to: accountView.leftAnchor, offset: 20)
        accountLabel.heightAnchor.equal(to: accountSize)
        accountLabel.widthAnchor.equal(to: 160)
        
        accountLineView.topAnchor.align(to: accountLabel.bottomAnchor)
        accountLineView.rightAnchor.align(to: accountView.rightAnchor)
        accountLineView.leftAnchor.align(to: accountView.leftAnchor)
        accountLineView.heightAnchor.equal(to: 1)
        
        fullNameTextField.topAnchor.align(to: accountLineView.bottomAnchor, offset: 20)
        fullNameTextField.rightAnchor.align(to: accountView.rightAnchor, offset: -20)
        fullNameTextField.leftAnchor.align(to: accountView.leftAnchor, offset: 20)
        fullNameTextField.heightAnchor.equal(to: 40)
        
        emailTextField.topAnchor.align(to: fullNameTextField.bottomAnchor, offset: 20)
        emailTextField.rightAnchor.align(to: accountView.rightAnchor, offset: -20)
        emailTextField.leftAnchor.align(to: accountView.leftAnchor, offset: 20)
        emailTextField.heightAnchor.equal(to: 40)
        
        accountsaveButton.topAnchor.align(to: emailTextField.bottomAnchor, offset: 20)
        accountsaveButton.leftAnchor.align(to: accountView.leftAnchor, offset: 20)
        accountsaveButton.widthAnchor.equal(to: 90)
        accountsaveButton.heightAnchor.equal(to: 40)
        
        passwordLineView.topAnchor.align(to: accountsaveButton.bottomAnchor, offset: 20)
        passwordLineView.rightAnchor.align(to: accountView.rightAnchor)
        passwordLineView.leftAnchor.align(to: accountView.leftAnchor)
        passwordLineView.heightAnchor.equal(to: 0.5)
        
        currentPasswordTextField.topAnchor.align(to: passwordLineView.bottomAnchor, offset: 20)
        currentPasswordTextField.rightAnchor.align(to: accountView.rightAnchor, offset: -20)
        currentPasswordTextField.leftAnchor.align(to: accountView.leftAnchor, offset: 20)
        currentPasswordTextField.heightAnchor.equal(to: 40)
        
        newPasswordTextField.topAnchor.align(to: currentPasswordTextField.bottomAnchor, offset: 20)
        newPasswordTextField.rightAnchor.align(to: accountView.rightAnchor, offset: -20)
        newPasswordTextField.leftAnchor.align(to: accountView.leftAnchor, offset: 20)
        newPasswordTextField.heightAnchor.equal(to: 40)
        
        comfirmPasswordTextField.topAnchor.align(to: newPasswordTextField.bottomAnchor, offset: 20)
        comfirmPasswordTextField.rightAnchor.align(to: accountView.rightAnchor, offset: -20)
        comfirmPasswordTextField.leftAnchor.align(to: accountView.leftAnchor, offset: 20)
        comfirmPasswordTextField.heightAnchor.equal(to: 40)
        
        saveNewPasswordButton.topAnchor.align(to: comfirmPasswordTextField.bottomAnchor, offset: 20)
        saveNewPasswordButton.leftAnchor.align(to: accountView.leftAnchor, offset: 20)
        saveNewPasswordButton.widthAnchor.equal(to: 90)
        saveNewPasswordButton.heightAnchor.equal(to: 40)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
