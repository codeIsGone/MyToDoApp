//
//  ProfileDesignViewController.swift
//  myTodoList
//
//  Created by 홍희곤 on 2/1/24.
//

import UIKit

class ProfileDesignViewController: UIViewController {
    
    let galleryCollectionView: UICollectionView = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                              heightDimension: .fractionalWidth(1/3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 2)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(1/3))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 2
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setUI()
    }
    
    @objc func buttonTapped() {
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
}

//MARK: collectionView Delegate
extension ProfileDesignViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
        
        return cell
    }
}

//MARK: UI
extension ProfileDesignViewController {
    func setUI() {
        
        //MARK: 컴포넌트 생성
        //userName
        let userNameLabel = UILabel()
        userNameLabel.text = "nabaecamp"
        userNameLabel.font = UIFont(name: "Pretendard-Bold", size: 18)
        view.addSubview(userNameLabel)
        
        //menu
        let menuButton = UIButton(type: .system)
        menuButton.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        menuButton.tintColor = .systemGray
        menuButton.imageView?.contentMode = .scaleAspectFill
        menuButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(menuButton)
        
        //userPic
        let userPic = UIImageView(image: UIImage(named: "userPic"))
        view.addSubview(userPic)
        
        //userFollowInfo
        let userFollowInfo = UIView()
        view.addSubview(userFollowInfo)
        
        //post
        let post = UIView()
        userFollowInfo.addSubview(post)
        
        //postNumber
        let postNumber = UILabel()
        postNumber.text = "10"
        post.addSubview(postNumber)
        
        //postTitle
        let postTitle = UILabel()
        postTitle.text = "게시물"
        post.addSubview(postTitle)
        
        //follower
        let follower = UIView()
        userFollowInfo.addSubview(follower)
        
        //followerNumber
        let followerNumber = UILabel()
        followerNumber.text = "100"
        follower.addSubview(followerNumber)
        
        //followerTitle
        let followerTitle = UILabel()
        followerTitle.text = "팔로워"
        follower.addSubview(followerTitle)
        
        //following
        let following = UIView()
        userFollowInfo.addSubview(following)
        
        //followingNumber
        let followingNumber = UILabel()
        followingNumber.text = "0"
        following.addSubview(followingNumber)
        
        //followingTitle
        let followingTitle = UILabel()
        followingTitle.text = "팔로잉"
        following.addSubview(followingTitle)
        
        //userInfo
        let userInfo = UIStackView()
        userInfo.axis = .vertical
        view.addSubview(userInfo)
        
        let userName = UILabel()
        userName.text = "르탄이"
        userInfo.addArrangedSubview(userName)
        
        let userBio = UILabel()
        userBio.text = "iOS 개발자"
        userInfo.addArrangedSubview(userBio)
        
        let userLink = UILabel()
        userLink.text = "https://nbcamp.spartacodingclub.kr/"
        userInfo.addArrangedSubview(userLink)
        
        userInfo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userInfo.topAnchor.constraint(equalTo: userPic.bottomAnchor, constant: 8),
            userInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16)
        ])
        
        let NavView = UIStackView()
        NavView.axis = .vertical
        NavView.distribution = .fill
        NavView.spacing = 8
        view.addSubview(NavView)
        
        let divider = UIView()
        divider.backgroundColor = .systemGray6
        NavView.addArrangedSubview(divider)
        
        let categoryStack = UIStackView()
        categoryStack.distribution = .fillEqually
        categoryStack.axis = .horizontal
        NavView.addArrangedSubview(categoryStack)
        
        let grid = UIButton()
        grid.setImage(UIImage(systemName: "squareshape.split.3x3"), for: .normal)
        grid.setTitleColor(.black, for: .normal)
        categoryStack.addArrangedSubview(grid)
        
        let blankOne = UIButton()
        blankOne.setTitle("", for: .normal)
        categoryStack.addArrangedSubview(blankOne)
        
        let blankTwo = UIButton()
        blankTwo.setTitle("", for: .normal)
        categoryStack.addArrangedSubview(blankTwo)
        
        NavView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NavView.topAnchor.constraint(equalTo: userInfo.bottomAnchor, constant: 8),
            NavView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            NavView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        let sectionDividerStack = UIStackView()
        sectionDividerStack.axis = .horizontal
        sectionDividerStack.distribution = .fillEqually
        NavView.addArrangedSubview(sectionDividerStack)
        
        let sectionOne = UIView()
        sectionOne.backgroundColor = .black
        sectionDividerStack.addArrangedSubview(sectionOne)
        
        let sectionTwo = UIView()
        sectionDividerStack.addArrangedSubview(sectionTwo)
        
        let sectionThree = UIView()
        sectionDividerStack.addArrangedSubview(sectionThree)
        
        sectionOne.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sectionOne.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        view.addSubview(galleryCollectionView)
        galleryCollectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: "GalleryCollectionViewCell")
        
        galleryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            galleryCollectionView.topAnchor.constraint(equalTo: NavView.bottomAnchor),
            galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            galleryCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        //MARK: 오토레이아웃
        //userName
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        ])
        
        //menu layout
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuButton.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor),
            menuButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
        
        //userPic layout
        userPic.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userPic.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 14),
            userPic.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 14),
            userPic.widthAnchor.constraint(equalToConstant: 88),
            userPic.heightAnchor.constraint(equalToConstant: 88)
        ])
        
        //userInfo layout
        userFollowInfo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userFollowInfo.centerYAnchor.constraint(equalTo: userPic.centerYAnchor),
            userFollowInfo.leadingAnchor.constraint(equalTo: userPic.trailingAnchor, constant: 41),
            userFollowInfo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            userFollowInfo.heightAnchor.constraint(equalTo: post.heightAnchor)
        ])
        
        //post layout
        post.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            post.topAnchor.constraint(equalTo: postNumber.topAnchor),
            post.bottomAnchor.constraint(equalTo: postTitle.bottomAnchor),
            post.widthAnchor.constraint(equalTo: postTitle.widthAnchor),
            post.leadingAnchor.constraint(equalTo: userFollowInfo.leadingAnchor)
        ])
        
        //postNumber layout
        postNumber.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postNumber.centerXAnchor.constraint(equalTo: post.centerXAnchor),
            postNumber.topAnchor.constraint(equalTo: post.topAnchor)
        ])
        
        //postTitle layout
        postTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postTitle.topAnchor.constraint(equalTo: postNumber.bottomAnchor),
            postTitle.centerXAnchor.constraint(equalTo: post.centerXAnchor)
        ])
        
        //follower
        follower.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            follower.centerXAnchor.constraint(equalTo: userFollowInfo.centerXAnchor),
            follower.topAnchor.constraint(equalTo: followerNumber.topAnchor),
            follower.bottomAnchor.constraint(equalTo: followerTitle.bottomAnchor),
            follower.widthAnchor.constraint(equalTo: followerTitle.widthAnchor)
        ])
        
        //followerNumber
        followerNumber.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            followerNumber.centerXAnchor.constraint(equalTo: follower.centerXAnchor),
            followerNumber.topAnchor.constraint(equalTo: follower.topAnchor)
        ])
        
        //followerTitle
        followerTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            followerTitle.topAnchor.constraint(equalTo: followerNumber.bottomAnchor),
            followerTitle.centerXAnchor.constraint(equalTo: follower.centerXAnchor)
        ])
        
        //following
        following.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            following.trailingAnchor.constraint(equalTo: userFollowInfo.trailingAnchor),
            following.centerYAnchor.constraint(equalTo: userFollowInfo.centerYAnchor),
            following.topAnchor.constraint(equalTo: followingNumber.topAnchor),
            following.bottomAnchor.constraint(equalTo: followingTitle.bottomAnchor),
            following.widthAnchor.constraint(equalTo: followingTitle.widthAnchor)
        ])
        
        //followingNumber
        followingNumber.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            followingNumber.centerXAnchor.constraint(equalTo: following.centerXAnchor),
            followingNumber.topAnchor.constraint(equalTo: following.topAnchor)
        ])
        
        //followingTitle
        followingTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            followingTitle.topAnchor.constraint(equalTo: followingNumber.bottomAnchor),
            followingTitle.centerXAnchor.constraint(equalTo: following.centerXAnchor)
        ])
    }
}
