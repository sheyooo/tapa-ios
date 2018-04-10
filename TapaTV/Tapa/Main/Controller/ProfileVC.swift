//
//  ProfileVC.swift
//  TapaTV
//
//  Created by SimpuMind on 3/16/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit
import Stripe

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.textColor = .white
        let titleSize = Constant.isCompact(view: view, yes: 18, no: 20)
        label.font = UIFont(name: "Avenir", size: CGFloat(titleSize))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        //tableView.bounces = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2666666667, alpha: 1)
        
        ApiService.shared.loadRememberedUser()
        
        self.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_fill_icon").withRenderingMode(.alwaysOriginal)
        self.tabBarItem.image = #imageLiteral(resourceName: "profile_line_icon").withRenderingMode(.alwaysOriginal)
        
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountCell.self, forCellReuseIdentifier: "accountCell")
        tableView.register(SubscriptionCell.self, forCellReuseIdentifier: "subscriptionCell")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let titleSize: CGFloat = Constant.isCompact(view: view, yes: 45, no: 65)
        titleLabel.topAnchor.align(to: view.topAnchor, offset: 35)
        titleLabel.leftAnchor.align(to: view.leftAnchor, offset: 20)
        titleLabel.heightAnchor.equal(to: titleSize)
        titleLabel.widthAnchor.equal(to: 150)
//        let orientation = UIDevice.current.orientation
//        if orientation == .landscapeLeft || orientation == .landscapeRight {
//            tableView.topAnchor.align(to: titleLabel.bottomAnchor, offset: 15)
//            tableView.widthAnchor.equal(to: view.frame.width * 0.75)
//            tableView.bottomAnchor.align(to: view.bottomAnchor)
//            tableView.centerXAnchor.align(to: view.centerXAnchor)
//            loadViewIfNeeded()
//
//        } else if UIDevice.current.orientation == .portrait || orientation == .portraitUpsideDown && !AppDelegate.isiPad(){
//            tableView.topAnchor.align(to: titleLabel.bottomAnchor, offset: 15)
//            tableView.leftAnchor.align(to: view.leftAnchor)
//            tableView.rightAnchor.align(to: view.rightAnchor)
//            tableView.bottomAnchor.align(to: view.bottomAnchor)
//            loadViewIfNeeded()
//        } else if UIDevice.current.orientation ==
//            UIDeviceOrientation.portraitUpsideDown && !AppDelegate.isiPad(){
//            tableView.topAnchor.align(to: titleLabel.bottomAnchor, offset: 15)
//            tableView.leftAnchor.align(to: view.leftAnchor)
//            tableView.rightAnchor.align(to: view.rightAnchor)
//            tableView.bottomAnchor.align(to: view.bottomAnchor)
//            loadViewIfNeeded()
//        }
        
        if AppDelegate.isiPad() {
            tableView.topAnchor.align(to: titleLabel.bottomAnchor, offset: 15)
            tableView.widthAnchor.equal(to: view.frame.width * 0.75)
            tableView.bottomAnchor.align(to: view.layoutMarginsGuide.bottomAnchor)
            tableView.centerXAnchor.align(to: view.centerXAnchor)
        }else{
            tableView.topAnchor.align(to: titleLabel.bottomAnchor, offset: 15)
            tableView.leftAnchor.align(to: view.layoutMarginsGuide.leftAnchor)
            tableView.rightAnchor.align(to: view.layoutMarginsGuide.rightAnchor)
            tableView.bottomAnchor.align(to: view.layoutMarginsGuide.bottomAnchor)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "accountCell", for: indexPath) as! AccountCell
            return cell
        }else if indexPath.item == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "subscriptionCell", for: indexPath) as! SubscriptionCell
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == 0 {
            return 330 + 20 + 120 + Constant.isCompact(view: view, yes: 40, no: 65)
        }else if indexPath.item == 1 {
            return 185 + 20 + 80 + 80
        }
        return UITableViewAutomaticDimension
    }
    
}

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
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
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
        

public class SubscriptionCell: UITableViewCell, STPPaymentCardTextFieldDelegate {
    
    private lazy var subscriptionView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = #colorLiteral(red: 0.1367795458, green: 0.1363631674, blue: 0.184029981, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var subscriptionLineView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.3716229961, green: 0.3704917175, blue: 0.5, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var subscriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Subscription"
        label.textColor = .white
        let titleSize = Constant.isCompact(view: self, yes: 22, no: 24)
        label.font = UIFont(name: "Avenir-Bold", size: CGFloat(titleSize))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var recurringView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderWidth = 0.7
        view.layer.borderColor = #colorLiteral(red: 0.3716229961, green: 0.3704917175, blue: 0.5, alpha: 0.5).cgColor
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var recuringSubscriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "RECURRING SUBSCRIPTION"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        let titleSize = Constant.isCompact(view: self, yes: 12, no: 14)
        label.font = UIFont(name: "Avenir", size: CGFloat(titleSize))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var recuringActiveLabel: UILabel = {
        let label = UILabel()
        label.text = "INACTIVE"
        label.textColor = .white
        label.backgroundColor = #colorLiteral(red: 0.5254901961, green: 0.5568627451, blue: 0.5882352941, alpha: 1)
        label.textAlignment = .center
        label.layer.cornerRadius = 3
        label.clipsToBounds = true
        let titleSize = Constant.isCompact(view: self, yes: 12, no: 14)
        label.font = UIFont(name: "Avenir", size: CGFloat(titleSize))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var accessToWatchView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderWidth = 0.7
        view.layer.borderColor = #colorLiteral(red: 0.3716229961, green: 0.3704917175, blue: 0.5, alpha: 0.5).cgColor
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var accessToWatchLabel: UILabel = {
        let label = UILabel()
        label.text = "ACCESS TO WATCH"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        let titleSize = Constant.isCompact(view: self, yes: 12, no: 14)
        label.font = UIFont(name: "Avenir", size: CGFloat(titleSize))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var accessActiveLabel: UILabel = {
        let label = UILabel()
        label.text = "INACTIVE"
        label.textColor = .white
        label.backgroundColor = #colorLiteral(red: 0.5254901961, green: 0.5568627451, blue: 0.5882352941, alpha: 1)
        label.textAlignment = .center
        label.layer.cornerRadius = 3
        label.clipsToBounds = true
        let titleSize = Constant.isCompact(view: self, yes: 12, no: 14)
        label.font = UIFont(name: "Avenir", size: CGFloat(titleSize))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let paymentTextField: STPPaymentCardTextField = {
        let ptf = STPPaymentCardTextField()
        ptf.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        ptf.layer.cornerRadius = 5
        ptf.textColor = .white
        ptf.translatesAutoresizingMaskIntoConstraints = false
        return ptf
    }()
    
    private lazy var makePaymentButton: UIButton = {
        let button = UIButton()
        button.setTitle("Make Payment", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4823529412, blue: 1, alpha: 1)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.alpha = 0.5
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        if textField.isValid {
            makePaymentButton.alpha = 1
            makePaymentButton.isEnabled = true
        }
    }
    
    @objc private func makePayment(){
        let card = paymentTextField.cardParams
        STPAPIClient.shared().createToken(withCard: card) { (token, error) in
            if let error = error {
                print(error)
            }
            else if let token = token {
                print(token)
                self.chargeUsingToken(token: token)
            }
        }
    }
    
    private func chargeUsingToken(token: STPToken) {
        
    }

    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(subscriptionView)
        [subscriptionLabel, subscriptionLineView,
         recurringView, accessToWatchView, paymentTextField, makePaymentButton].forEach {subscriptionView.addSubview($0)}
        [recuringSubscriptionLabel, recuringActiveLabel].forEach {recurringView.addSubview($0)}
        [accessToWatchLabel, accessActiveLabel].forEach {accessToWatchView.addSubview($0)}
        
        backgroundColor = .clear
        selectionStyle = .none
        paymentTextField.delegate = self
        makePaymentButton.addTarget(self, action: #selector(makePayment), for: .touchUpInside)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        subscriptionView.topAnchor.align(to: topAnchor)
        subscriptionView.leftAnchor.align(to: leftAnchor)
        subscriptionView.rightAnchor.align(to: rightAnchor)
        subscriptionView.bottomAnchor.align(to: bottomAnchor, offset: -20)
        
        subscriptionLabel.topAnchor.align(to: subscriptionView.topAnchor)
        subscriptionLabel.leftAnchor.align(to: subscriptionView.leftAnchor, offset: 20)
        subscriptionLabel.heightAnchor.equal(to: Constant.isCompact(view: self, yes: 45, no: 65))
        subscriptionLabel.widthAnchor.equal(to: 160)
        
        subscriptionLineView.topAnchor.align(to: subscriptionLabel.bottomAnchor)
        subscriptionLineView.rightAnchor.align(to: subscriptionView.rightAnchor)
        subscriptionLineView.leftAnchor.align(to: subscriptionView.leftAnchor)
        subscriptionLineView.heightAnchor.equal(to: 1)
        
        recurringView.topAnchor.align(to: subscriptionLineView.bottomAnchor, offset: 10)
        recurringView.leftAnchor.align(to: subscriptionView.leftAnchor, offset: 10)
        recurringView.widthAnchor.equal(to: ((frame.width - 40) / 2) - 15)
        recurringView.heightAnchor.equal(to: ((frame.width - 40) / 2) - 15)
        
        recuringSubscriptionLabel.topAnchor.align(to: recurringView.topAnchor, offset: 20)
        recuringSubscriptionLabel.rightAnchor.align(to: recurringView.rightAnchor, offset: -20)
        recuringSubscriptionLabel.leftAnchor.align(to: recurringView.leftAnchor, offset: 20)
        recuringSubscriptionLabel.heightAnchor.equal(to: 35)
        
        recuringActiveLabel.topAnchor.align(to: recuringSubscriptionLabel.bottomAnchor, offset: 20)
        recuringActiveLabel.centerXAnchor.align(to: recurringView.centerXAnchor)
        recuringActiveLabel.widthAnchor.equal(to: 90)
        recuringActiveLabel.heightAnchor.equal(to: 20)
        
        accessToWatchView.topAnchor.align(to: subscriptionLineView.bottomAnchor, offset: 10)
        accessToWatchView.rightAnchor.align(to: subscriptionView.rightAnchor, offset: -10)
        accessToWatchView.widthAnchor.equal(to: ((frame.width - 40) / 2) - 15)
        accessToWatchView.heightAnchor.equal(to: ((frame.width - 40) / 2) - 15)
        
        accessToWatchLabel.topAnchor.align(to: accessToWatchView.topAnchor, offset: 20)
        accessToWatchLabel.rightAnchor.align(to: accessToWatchView.rightAnchor, offset: -40)
        accessToWatchLabel.leftAnchor.align(to: accessToWatchView.leftAnchor, offset: 40)
        accessToWatchLabel.heightAnchor.equal(to: 35)
        
        accessActiveLabel.topAnchor.align(to: accessToWatchLabel.bottomAnchor, offset: 20)
        accessActiveLabel.centerXAnchor.align(to: accessToWatchView.centerXAnchor)
        accessActiveLabel.widthAnchor.equal(to: 90)
        accessActiveLabel.heightAnchor.equal(to: 20)
        
        makePaymentButton.bottomAnchor.align(to: subscriptionView.bottomAnchor, offset: -10)
        makePaymentButton.rightAnchor.align(to: subscriptionView.rightAnchor, offset: -10)
        makePaymentButton.leftAnchor.align(to: subscriptionView.leftAnchor, offset: 10)
        makePaymentButton.heightAnchor.equal(to: 40)
        
        paymentTextField.bottomAnchor.align(to: makePaymentButton.topAnchor, offset: -20)
        paymentTextField.rightAnchor.align(to: subscriptionView.rightAnchor, offset: -10)
        paymentTextField.leftAnchor.align(to: subscriptionView.leftAnchor, offset: 10)
        paymentTextField.heightAnchor.equal(to: 50)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

