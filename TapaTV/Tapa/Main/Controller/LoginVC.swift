//
//  LoginVC.swift
//  TapaTV
//
//  Created by SimpuMind on 3/16/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit
import PasswordTextField
import EGFormValidator
import KVNProgress

class LoginVC: ValidatorViewController {
    
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
        coverView.addSubview(mainView)
        [logoImageView, logoTitleLabel, emailPhoneTextField,
         emailLineView, passwordTextField, passwordLineView, forgotPassword, emailErrorLabel, passwordErrorLabel, skipButton, signInButton, dontHaveAccount].forEach{mainView.addSubview($0)}
        
        let buttonTitleStr = NSMutableAttributedString(string:"New User? Create Account", attributes:attrs)
        attributedString.append(buttonTitleStr)
        dontHaveAccount.setAttributedTitle(attributedString, for: .normal)

        self.addValidatorMandatory(toControl: self.emailPhoneTextField, errorPlaceholder: self.emailErrorLabel, errorMessage: "This field is required")
        self.addValidatorMandatory(toControl: self.passwordTextField, errorPlaceholder: self.passwordErrorLabel, errorMessage: "This field is required")
        self.addValidatorEmail(toControl: self.emailPhoneTextField, errorPlaceholder: emailErrorLabel, errorMessage: "Email is invalid")
        self.addValidatorMinLength(toControl: passwordTextField, errorPlaceholder: passwordErrorLabel, errorMessage: "Enter at least %d characters", minLength: 6)
        
        skipButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        dontHaveAccount.addTarget(self, action: #selector(pushToSignUp), for: .touchUpInside)
        
    }
    
    @objc fileprivate func pushToSignUp(){
        let vc = SignupVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc fileprivate func handleSignIn(button: UIButton){
        if self.validate() {
            KVNProgress.show()
            guard let email = emailPhoneTextField.text, let password = passwordTextField.text else {
                return
            }
            let params = ["email": email, "password": password]
            ApiService.shared.loginUser(with: params, completion: { (completed, message) in
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
    
    override var shouldAutorotate: Bool{
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
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
        
        emailErrorLabel.fillTopLeftRightHeightCenterX(mainView, topView: logoTitleLabel, topOffset: 60, offest: 40, height: Constant.isCompact(view: view, yes: 15, no: 20))
        emailPhoneTextField.fillTopLeftRightHeightCenterX(mainView, topView: emailErrorLabel, topOffset: 0, offest: 40, height: 45)
        emailLineView.fillTopLeftRightHeightCenterX(mainView, topView: emailPhoneTextField, topOffset: 0, offest: 40, height: 1)
        
        passwordErrorLabel.fillTopLeftRightHeightCenterX(mainView, topView: emailLineView, topOffset: 40, offest: 40, height: Constant.isCompact(view: view, yes: 15, no: 20))
        
        passwordTextField.fillTopLeftRightHeightCenterX(mainView, topView: passwordErrorLabel, topOffset: 0, offest: 40, height: 45)
        passwordLineView.fillTopLeftRightHeightCenterX(mainView, topView: passwordTextField, topOffset: 0, offest: 40, height: 1)
        
        forgotPassword.bottomAnchor.align(to: passwordLineView.bottomAnchor, offset: -40)
        forgotPassword.rightAnchor.align(to: mainView.rightAnchor, offset: -40)
        forgotPassword.heightAnchor.equal(to: 45)
        forgotPassword.widthAnchor.equal(to: 130)
        
        signInButton.topAnchor.align(to: passwordLineView.bottomAnchor, offset: 50)
        signInButton.centerXAnchor.align(to: mainView.centerXAnchor)
        signInButton.widthAnchor.equal(to: 150)
        signInButton.heightAnchor.equal(to: 45)
        
        dontHaveAccount.topAnchor.align(to: signInButton.bottomAnchor, offset: 0)
        dontHaveAccount.centerXAnchor.align(to: mainView.centerXAnchor)
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


