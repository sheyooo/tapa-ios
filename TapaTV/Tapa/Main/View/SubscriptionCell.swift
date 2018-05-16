//
//  SubscriptionCell.swift
//  TapaTV
//
//  Created by SimpuMind on 5/16/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit
import Stripe

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


