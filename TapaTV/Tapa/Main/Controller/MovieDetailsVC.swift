//
//  MovieDetailsVC.swift
//  TapaTV
//
//  Created by SimpuMind on 4/8/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit

class MovieDetailsVC: UIViewController {
    
    var movie: Movie?

    private lazy var closeModal: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "multiply"), for: .normal)
        button.addTarget(self, action: #selector(closeModalView), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var tableView: UITableView = {
       let tv = UITableView()
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.showsHorizontalScrollIndicator = false
        tv.showsVerticalScrollIndicator = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2666666667, alpha: 1)
        [closeModal, tableView].forEach{view.addSubview($0)}
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieDetalsSectionOneCel.self, forCellReuseIdentifier: "sectionOne")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    
    @objc private func closeModalView(){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        closeModal.topAnchor.align(to: view.layoutMarginsGuide.topAnchor, offset: 20)
        closeModal.widthAnchor.equal(to: Constant.isCompact(view: self.view, yes: 24, no: 44))
        closeModal.heightAnchor.equal(to: Constant.isCompact(view: self.view, yes: 24, no: 44))
        closeModal.leftAnchor.align(to: view.layoutMarginsGuide.leftAnchor, offset: 10)
        
        tableView.topAnchor.align(to: closeModal.bottomAnchor, offset: 20)
        tableView.leftAnchor.align(to: view.layoutMarginsGuide.leftAnchor, offset: 10)
        tableView.rightAnchor.align(to: view.layoutMarginsGuide.rightAnchor, offset: -10)
        tableView.bottomAnchor.align(to: view.layoutMarginsGuide.bottomAnchor, offset: -10)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension MovieDetailsVC:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionOne", for: indexPath) as! MovieDetalsSectionOneCel
        cell.movie = movie
        cell.movieDetailsVC = self
        cell.selectionStyle = .none
        return cell
            
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var width: CGFloat = 0
        switch UIDevice.current.orientation {
        case .portrait, .portraitUpsideDown:
            width = view.layoutMarginsGuide.layoutFrame.width
        case .landscapeLeft, .landscapeRight:
            width = view.layoutMarginsGuide.layoutFrame.width
        default:
            width = view.layoutMarginsGuide.layoutFrame.width
        }

       
        let text1 = movie!.title
        let text2 = movie!.contentDescription
        return 343 + text1.height(withConstrainedWidth: (width / 2) + 20, font: UIFont.boldSystemFont(ofSize: Constant.isCompact(view: self.view, yes: 22, no: 42))) +
            text2.height(withConstrainedWidth: (width - 20), font: UIFont.systemFont(ofSize: Constant.isCompact(view: self.view, yes: 12, no: 18))) + 50 + 100
        
    }
    
}
