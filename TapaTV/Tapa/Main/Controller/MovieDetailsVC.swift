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

        let text1 = "Spider-man: Homecomming"
        let text2 = "Based on my experiences with hundreds of Europeans, many of them close friends, they believe Americans are hard right, as stated above they feel Obama was a Centrist or right winger. They see Republicans as semi-fascist and Trump as even more to the right of that."
        return 343 + text1.height(withConstrainedWidth: (width / 2) + 20, font: UIFont.boldSystemFont(ofSize: Constant.isCompact(view: self.view, yes: 22, no: 32))) +
            text2.height(withConstrainedWidth: (width - 20), font: UIFont.systemFont(ofSize: Constant.isCompact(view: self.view, yes: 12, no: 14))) + 50 + 100
        
    }
    
}



class MovieDetalsSectionOneCel: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    
    var movieDetailsVC: MovieDetailsVC?
    
    var movie: Movie?{
        didSet{
            guard let movie = movie else {return}
            movieTitleLabel.text = movie.title
            descriptionLabel.text = movie.contentDescription
            videoThumbNail.af_setImage(
                withURL: URL(string: movie.posterImageUrl)!,
                placeholderImage: nil
            )
        }
    }
    
    
    lazy var videoThumbNail: DesignableImageView = {
        let iv = DesignableImageView()
        iv.contentMode = .scaleAspectFill
        iv.cornerRadius = 10
        iv.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2666666667, alpha: 0.5)
        iv.elevate(elevation: 2.0, shadowColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), cornerRadius: 10)
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Action, Adventure, Sci-Fi"
        label.textColor = UIColor(white: 1, alpha: 0.5)
        label.font = UIFont.boldSystemFont(ofSize: Constant.isCompact(view: self, yes: 14, no: 16))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: Constant.isCompact(view: self, yes: 22, no: 32))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.text = "2h 13m"
        label.textColor = UIColor(white: 1, alpha: 0.5)
        label.font = UIFont.boldSystemFont(ofSize: Constant.isCompact(view: self, yes: 12, no: 14))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var parentalGuardLabel: UILabel = {
        let label = UILabel()
        label.text = "12 +"
        label.textColor = UIColor(white: 1, alpha: 0.5)
        label.font = UIFont.boldSystemFont(ofSize: Constant.isCompact(view: self, yes: 12, no: 14))
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(white: 1, alpha: 0.3).cgColor
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "6 July 2017"
        label.textColor = UIColor(white: 1, alpha: 0.5)
        //        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: Constant.isCompact(view: self, yes: 12, no: 14))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "Rating: "
        label.textColor = UIColor(white: 1, alpha: 0.5)
        let stringFormatting = NSMutableAttributedString()
        stringFormatting
            .normal("Rating: ", font: UIFont.boldSystemFont(ofSize: Constant.isCompact(view: self, yes: 14, no: 18)), textColor: UIColor(white: 1, alpha: 0.5))
            .bold("9.7", font: UIFont.boldSystemFont(ofSize: Constant.isCompact(view: self, yes: 16, no: 22)), textColor: UIColor(white: 1, alpha: 0.5))
        
        label.attributedText = stringFormatting
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(white: 1, alpha: 0.8)
        //        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: Constant.isCompact(view: self, yes: 12, no: 14))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var castLabel: UILabel = {
        let label = UILabel()
        label.text = "Casts"
        label.textColor = UIColor(white: 1, alpha: 1)
        //        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: Constant.isCompact(view: self, yes: 16, no: 18))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    fileprivate lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "pc_play"), for: .normal)
        button.addTarget(self, action: #selector(handlePlayVideo), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    @objc private func handlePlayVideo(){
        guard let movie = movie else {return}
        let vc = StreamTvVC()
        print(movie.video?.title)
        vc.video = movie.video
        movieDetailsVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [videoThumbNail, categoryLabel, movieTitleLabel,
         parentalGuardLabel, durationLabel, releaseDateLabel,
         ratingLabel, descriptionLabel, castLabel, collectionView, playButton].forEach{contentView.addSubview($0)}
        backgroundColor = .clear
//        descriptionLabel.backgroundColor = .red
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        var width: CGFloat = 0
        switch UIDevice.current.orientation {
        case .portrait, .portraitUpsideDown:
            width = frame.width
        case .landscapeLeft, .landscapeRight:
            width = frame.height
        default:
            width = frame.width
        }
        
        videoThumbNail.topAnchor.align(to: topAnchor, offset: 20)
        videoThumbNail.leftAnchor.align(to: leftAnchor, offset: 10)
        videoThumbNail.rightAnchor.align(to: rightAnchor, offset: -10)
        videoThumbNail.heightAnchor.equal(to: Constant.isCompact(view: self, yes: 150, no: 250))
        
        categoryLabel.leftAnchor.align(to: leftAnchor, offset: 10)
        categoryLabel.topAnchor.align(to: videoThumbNail.bottomAnchor, offset: 15)
        categoryLabel.rightAnchor.align(to: rightAnchor, offset: -10)
        categoryLabel.heightAnchor.equal(to: 20)
        
        movieTitleLabel.leftAnchor.align(to: leftAnchor, offset: 10)
        movieTitleLabel.topAnchor.align(to: categoryLabel.bottomAnchor, offset: 10)
        movieTitleLabel.widthAnchor.equal(to: (width / 2) + 20)
        let text = movieTitleLabel.text
        let titleHeight = (text!.height(withConstrainedWidth: (width / 2) + 20, font: UIFont.boldSystemFont(ofSize: Constant.isCompact(view: self, yes: 22, no: 32))))
        movieTitleLabel.heightAnchor.equal(to: titleHeight)
        
        durationLabel.leftAnchor.align(to: leftAnchor, offset: 10)
        durationLabel.topAnchor.align(to: movieTitleLabel.bottomAnchor, offset: 10)
        durationLabel.widthAnchor.equal(to: Constant.isCompact(view: self, yes: 50, no: 70))
        durationLabel.heightAnchor.equal(to: Constant.isCompact(view: self, yes: 20, no: 40))
        
        parentalGuardLabel.leftAnchor.align(to: durationLabel.rightAnchor, offset: 10)
        parentalGuardLabel.topAnchor.align(to: movieTitleLabel.bottomAnchor, offset: 10)
        parentalGuardLabel.widthAnchor.equal(to: Constant.isCompact(view: self, yes: 40, no: 60))
        parentalGuardLabel.heightAnchor.equal(to: Constant.isCompact(view: self, yes: 20, no: 40))
        
        releaseDateLabel.leftAnchor.align(to: parentalGuardLabel.rightAnchor, offset: 10)
        releaseDateLabel.topAnchor.align(to: movieTitleLabel.bottomAnchor, offset: 10)
        releaseDateLabel.widthAnchor.equal(to: Constant.isCompact(view: self, yes: 85, no: 105))
        releaseDateLabel.heightAnchor.equal(to: Constant.isCompact(view: self, yes: 20, no: 40))
        
        ratingLabel.leftAnchor.align(to: leftAnchor, offset: 10)
        ratingLabel.topAnchor.align(to: durationLabel.bottomAnchor, offset: 10)
        ratingLabel.widthAnchor.equal(to: 140)
        ratingLabel.heightAnchor.equal(to: Constant.isCompact(view: self, yes: 18, no: 38))
        
        descriptionLabel.leftAnchor.align(to: leftAnchor, offset: 10)
        descriptionLabel.topAnchor.align(to: ratingLabel.bottomAnchor, offset: 10)
        descriptionLabel.rightAnchor.align(to: rightAnchor, offset: -10)
        let descriptionText = descriptionLabel.text
        print(width)
        let descriptionHeight = descriptionText!.height(withConstrainedWidth: (width) - 20, font: UIFont.systemFont(ofSize: Constant.isCompact(view: self, yes: 12, no: 14)))
        descriptionLabel.heightAnchor.equal(to: descriptionHeight)
        
        castLabel.leftAnchor.align(to: leftAnchor, offset: 10)
        castLabel.topAnchor.align(to: descriptionLabel.bottomAnchor, offset: 30)
        castLabel.widthAnchor.equal(to: 140)
        castLabel.heightAnchor.equal(to: Constant.isCompact(view: self, yes: 20, no: 24))
        
        collectionView.topAnchor.align(to: castLabel.bottomAnchor, offset: 20)
        collectionView.leftAnchor.align(to: leftAnchor, offset: 10)
        collectionView.rightAnchor.align(to: rightAnchor, offset: -10)
        collectionView.heightAnchor.equal(to: 100)
        
        playButton.centerXAnchor.align(to: videoThumbNail.centerXAnchor)
        playButton.centerYAnchor.align(to: videoThumbNail.centerYAnchor)
        playButton.widthAnchor.equal(to: frame.height - 100)
        playButton.heightAnchor.equal(to: frame.height - 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.height - 20, height: collectionView.frame.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.right
    }
}
