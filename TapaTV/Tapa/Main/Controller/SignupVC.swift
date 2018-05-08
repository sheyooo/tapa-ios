//
//  SignupVC.swift
//  TapaTV
//
//  Created by SimpuMind on 3/28/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit
import PasswordTextField
import EGFormValidator
import KVNProgress

class SignupVC: ValidatorViewController {
    
    private lazy var coverImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "movie")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "logo")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var logoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "TRAILER"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Black", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var coverView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var facebookButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.3490196078, blue: 0.5960784314, alpha: 1)
        button.setTitle("Facebook", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "Avenir", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var googleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Google", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8666666667, green: 0.2941176471, blue: 0.2235294118, alpha: 1), for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "Avenir", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var twitterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0, green: 0.6745098039, blue: 0.9294117647, alpha: 1)
        button.setTitle("Twitter", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "Avenir", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nameErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.alpha = 1
        label.font = UIFont(name: "Arial", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var fullNameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.borderStyle = .none
        textField.attributedPlaceholder = NSAttributedString(string: "Full Name",
                                                             attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var fullnameLineView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9646652919, green: 0.9646652919, blue: 0.9646652919, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emailErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.alpha = 1
        label.font = UIFont(name: "Arial", size: Constant.isCompact(view: view, yes: 12, no: 15))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailPhoneTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.setUnderline(color: #colorLiteral(red: 0.9646652919, green: 0.9646652919, blue: 0.9646652919, alpha: 1))
        textField.borderStyle = .none
        textField.keyboardType = .emailAddress
        textField.text = "sheyiadekoya@gmail.com"
        textField.autocapitalizationType = .none
        textField.attributedPlaceholder = NSAttributedString(string: "Email or Phone Number",
                                                             attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5863923373)])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var emailLineView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9646652919, green: 0.9646652919, blue: 0.9646652919, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var passwordErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.alpha = 1
        label.font = UIFont(name: "Arial", size: Constant.isCompact(view: view, yes: 12, no: 15))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var passwordTextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.textColor = .white
        textField.imageTintColor = .white
        textField.borderStyle = .none
        textField.text = "password"
        textField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                             attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5863923373)])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordLineView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9646652919, green: 0.9646652919, blue: 0.9646652919, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = primaryColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    var attrs = [
        NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16.0),
        NSAttributedStringKey.foregroundColor : UIColor.white,
        NSAttributedStringKey.underlineStyle : 1] as [NSAttributedStringKey : Any]
    
    var attributedString = NSMutableAttributedString(string:"")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
        [coverImageView, coverView].forEach {view.addSubview($0)}
        coverView.addSubview(mainView)
        [logoImageView, logoTitleLabel, nameErrorLabel, fullNameTextField, fullnameLineView, emailPhoneTextField,
         emailLineView, passwordTextField, passwordLineView, emailErrorLabel, passwordErrorLabel, signInButton].forEach{mainView.addSubview($0)}
        
        self.addValidatorMandatory(toControl: self.fullNameTextField, errorPlaceholder: self.nameErrorLabel, errorMessage: "This field is required")
        self.addValidatorMandatory(toControl: self.emailPhoneTextField, errorPlaceholder: self.emailErrorLabel, errorMessage: "This field is required")
        self.addValidatorMandatory(toControl: self.passwordTextField, errorPlaceholder: self.passwordErrorLabel, errorMessage: "This field is required")
        self.addValidatorEmail(toControl: self.emailPhoneTextField, errorPlaceholder: emailErrorLabel, errorMessage: "Email is invalid")
        self.addValidatorMinLength(toControl: passwordTextField, errorPlaceholder: passwordErrorLabel, errorMessage: "Enter at least %d characters", minLength: 6)
        let usernameValidator = Validator(control: self.fullNameTextField,
                                          predicate: validateUsername,
                                          predicateParameters: [],
                                          errorPlaceholder: self.nameErrorLabel,
                                          errorMessage: "Must be First Name and Lastname")
        self.add(validator: usernameValidator)

        
        signInButton.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        
    }
    
    @objc fileprivate func handleSignIn(button: UIButton){
        if self.validate() {
            KVNProgress.show()
            guard let fullname = fullNameTextField.text, let email = emailPhoneTextField.text, let password = passwordTextField.text else {
                return
            }
            let params = ["name": fullname, "email": email, "password": password]
            ApiService.shared.signUpUser(with: params, completion: { (completed, message) in
                KVNProgress.dismiss(completion: {
                    if completed {
                        KVNProgress.showSuccess(withStatus: message, completion: {
                             Constant.keychain["password"] = password
                            self.handleSkip(button: UIButton())
                        })
                    }else{
                        KVNProgress.showError(withStatus: message)
                    }
                })
            })
        }
    }
    
    @objc fileprivate func handleSkip(button: UIButton){
        UIApplication.shared.keyWindow?.rootViewController = MainTabViewController()
    }
    
    private func validateUsername(value: Any?, params: [Any?]) -> Bool{
        let badCharacters = NSCharacterSet.alphanumerics.inverted
        if let myString = value as? String, myString.rangeOfCharacter(from: badCharacters) == nil {
            let trimmedString = myString.trimmingCharacters(in: .whitespacesAndNewlines)
            let fullNameArr : [String] = trimmedString.components(separatedBy: " ")
            if fullNameArr.count != 0 {
                return false
            }
        }
        return true
    }
    
    override var shouldAutorotate: Bool{
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupContraints()
    }
    
    func setupContraints(){
        
        coverImageView.fill(view)
        coverView.fill(view)
        
        mainView.heightAnchor.equal(to: view.frame.height * 0.7)
        mainView.widthAnchor.equal(to: view.frame.width * 0.9)
        mainView.centerXAnchor.align(to: coverView.centerXAnchor)
        mainView.centerYAnchor.align(to: coverView.centerYAnchor)
        
        logoImageView.topAnchor.align(to: mainView.topAnchor, offset: 40)
        logoImageView.centerXAnchor.align(to: mainView.centerXAnchor)
        logoImageView.widthAnchor.equal(to: Constant.isCompact(view: view, yes: 50, no: 100))
        logoImageView.heightAnchor.equal(to: Constant.isCompact(view: view, yes: 50, no: 100))
        
        logoTitleLabel.widthAnchor.equal(to: 240)
        logoTitleLabel.topAnchor.align(to: logoImageView.bottomAnchor, offset: 20)
        logoTitleLabel.centerXAnchor.align(to: mainView.centerXAnchor)
        logoTitleLabel.heightAnchor.equal(to: 16)
        
        nameErrorLabel.fillTopLeftRightHeightCenterX(mainView, topView: logoTitleLabel, topOffset: 60, offest: 40, height: Constant.isCompact(view: view, yes: 15, no: 20))
        fullNameTextField.fillTopLeftRightHeightCenterX(mainView, topView: nameErrorLabel, topOffset: 0, offest: 40, height: 45)
        fullnameLineView.fillTopLeftRightHeightCenterX(mainView, topView: fullNameTextField, topOffset: 0, offest: 40, height: 1)
        
        emailErrorLabel.fillTopLeftRightHeightCenterX(mainView, topView: fullnameLineView, topOffset: 40, offest: 40, height: Constant.isCompact(view: view, yes: 15, no: 20))
        emailPhoneTextField.fillTopLeftRightHeightCenterX(mainView, topView: emailErrorLabel, topOffset: 0, offest: 40, height: 45)
        emailLineView.fillTopLeftRightHeightCenterX(mainView, topView: emailPhoneTextField, topOffset: 0, offest: 40, height: 1)
        
        passwordErrorLabel.fillTopLeftRightHeightCenterX(mainView, topView: emailLineView, topOffset: 40, offest: 40, height: Constant.isCompact(view: view, yes: 15, no: 20))
        
        passwordTextField.fillTopLeftRightHeightCenterX(mainView, topView: passwordErrorLabel, topOffset: 0, offest: 40, height: 45)
        passwordLineView.fillTopLeftRightHeightCenterX(mainView, topView: passwordTextField, topOffset: 0, offest: 40, height: 1)
        
        signInButton.topAnchor.align(to: passwordLineView.bottomAnchor, offset: 50)
        signInButton.centerXAnchor.align(to: mainView.centerXAnchor)
        signInButton.widthAnchor.equal(to: 150)
        signInButton.heightAnchor.equal(to: 45)
        
        
        
        //        emailErrorLabel.topAnchor.align(to: logoTitleLabel.bottomAnchor, offset: 50)
        //        emailErrorLabel.widthAnchor.equal(to: 200)
        //        emailErrorLabel.centerXAnchor.align(to: view.centerXAnchor)
        //        emailErrorLabel.heightAnchor.equal(to: 15)
        //
        //        emailPhoneTextField.topAnchor.align(to: emailErrorLabel.bottomAnchor, offset: 0)
        //        emailPhoneTextField.widthAnchor.equal(to: 250)
        //        emailPhoneTextField.heightAnchor.equal(to: 55)
        //        emailPhoneTextField.centerXAnchor.align(to: view.centerXAnchor)
        //
        //        emailLineView.topAnchor.align(to: emailPhoneTextField.bottomAnchor)
        //        emailLineView.widthAnchor.equal(to: 200)
        //        emailLineView.heightAnchor.equal(to: 1)
        //        emailLineView.centerXAnchor.align(to: view.centerXAnchor)
        
        //        twitterButton.bottomAnchor.align(to: coverView.bottomAnchor, offset: -40)
        //        twitterButton.heightAnchor.equal(to: 45)
        //        twitterButton.leftAnchor.align(to: coverView.leftAnchor, offset: 20)
        //        twitterButton.widthAnchor.equal(to: (view.frame.width / 2) - 30)
        //
        //        googleButton.bottomAnchor.align(to: coverView.bottomAnchor, offset: -40)
        //        googleButton.heightAnchor.equal(to: 45)
        //        googleButton.rightAnchor.align(to: coverView.rightAnchor, offset: -20)
        //        googleButton.widthAnchor.equal(to: (view.frame.width / 2) - 30)
        //
        //        facebookButton.bottomAnchor.align(to: twitterButton.topAnchor, offset: -20)
        //        facebookButton.leftAnchor.align(to: coverView.leftAnchor, offset: 20)
        //        facebookButton.rightAnchor.align(to: coverView.rightAnchor, offset: -20)
        //        facebookButton.heightAnchor.equal(to: 45)
        
    }
}



 
