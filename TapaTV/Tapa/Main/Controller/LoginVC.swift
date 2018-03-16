//
//  LoginVC.swift
//  TapaTV
//
//  Created by SimpuMind on 3/16/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit
import PasswordTextField

class LoginVC: UIViewController {
    
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
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    private lazy var emailErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.alpha = 1
        label.text = "Error"
        label.font = UIFont(name: "Arial", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailPhoneTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.setUnderline(color: #colorLiteral(red: 0.9646652919, green: 0.9646652919, blue: 0.9646652919, alpha: 1))
        textField.borderStyle = .none
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
        label.text = "Error"
        label.font = UIFont(name: "Arial", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var passwordTextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.textColor = .white
        textField.imageTintColor = .white
        textField.borderStyle = .none
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
    
    private lazy var forgotPassword: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitle("Forgot password?", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = primaryColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var dontHaveAccount: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
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
        [logoImageView, logoTitleLabel, emailPhoneTextField,
         emailLineView, passwordTextField, passwordLineView, forgotPassword, emailErrorLabel, passwordErrorLabel, skipButton, signInButton, dontHaveAccount].forEach{coverView.addSubview($0)}
        
        let buttonTitleStr = NSMutableAttributedString(string:"New User? Create Account", attributes:attrs)
        attributedString.append(buttonTitleStr)
        dontHaveAccount.setAttributedTitle(attributedString, for: .normal)
        
        skipButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        
    }
    
    @objc fileprivate func handleSkip(button: UIButton){
        UIApplication.shared.keyWindow?.rootViewController = MainTabViewController()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupContraints()
    }
    
    func setupContraints(){
        
        coverImageView.fill(view)
        coverView.fill(view)
        
        logoImageView.topAnchor.align(to: coverView.topAnchor, offset: 40)
        logoImageView.centerXAnchor.align(to: coverView.centerXAnchor)
        logoImageView.widthAnchor.equal(to: 50)
        logoImageView.heightAnchor.equal(to: 50)
        
        logoTitleLabel.widthAnchor.equal(to: 240)
        logoTitleLabel.topAnchor.align(to: logoImageView.bottomAnchor, offset: 20)
        logoTitleLabel.centerXAnchor.align(to: view.centerXAnchor)
        logoTitleLabel.heightAnchor.equal(to: 16)
        
        emailErrorLabel.fillTopLeftRightHeightCenterX(view, topView: logoTitleLabel, topOffset: 0, offest: 80, height: 15)
        emailPhoneTextField.fillTopLeftRightHeightCenterX(view, topView: emailErrorLabel, topOffset: 0, offest: 80, height: 45)
        emailLineView.fillTopLeftRightHeightCenterX(view, topView: emailPhoneTextField, topOffset: 0, offest: 80, height: 1)
        
        passwordErrorLabel.fillTopLeftRightHeightCenterX(view, topView: emailLineView, topOffset: 10, offest: 80, height: 15)
        
        passwordTextField.fillTopLeftRightHeightCenterX(view, topView: passwordErrorLabel, topOffset: 0, offest: 80, height: 45)
        passwordLineView.fillTopLeftRightHeightCenterX(view, topView: passwordTextField, topOffset: 0, offest: 80, height: 1)
        
        forgotPassword.bottomAnchor.align(to: passwordLineView.bottomAnchor, offset: -20)
        forgotPassword.rightAnchor.align(to: view.rightAnchor, offset: -80)
        forgotPassword.heightAnchor.equal(to: 45)
        forgotPassword.widthAnchor.equal(to: 130)
        
        signInButton.topAnchor.align(to: passwordLineView.bottomAnchor, offset: 20)
        signInButton.centerXAnchor.align(to: view.centerXAnchor)
        signInButton.widthAnchor.equal(to: 150)
        signInButton.heightAnchor.equal(to: 45)
        
        dontHaveAccount.topAnchor.align(to: signInButton.bottomAnchor, offset: 0)
        dontHaveAccount.centerXAnchor.align(to: view.centerXAnchor)
        dontHaveAccount.widthAnchor.equal(to: 200)
        dontHaveAccount.heightAnchor.equal(to: 45)
        
        
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
        
        skipButton.topAnchor.align(to: coverView.topAnchor, offset: 30)
        skipButton.rightAnchor.align(to: coverView.rightAnchor, offset: -10)
        skipButton.widthAnchor.equal(to: 60)
        skipButton.heightAnchor.equal(to: 45)
    }
}


