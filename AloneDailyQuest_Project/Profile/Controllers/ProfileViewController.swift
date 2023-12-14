//
//  ProfileViewController.swift
//  AloneDailyQuest_Project
//
//  Created by Joy Kim on 2023/12/13.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let profileTableView = UITableView()
    var profileMenuArray: [Profile] = []
    var profileDataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNaviBar()
        setupTableView()
        setupDatas()
        setupTableViewConstraints()
    }
    
    func setupNaviBar() {
        title = "마이페이지"
        
        // (네비게이션바 설정관련) iOS버전 업데이트 되면서 바뀐 설정⭐️⭐️⭐️
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 불투명으로
        appearance.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func setupTableView() {
        // 델리게이트 패턴의 대리자 설정
        profileTableView.dataSource = self
        profileTableView.delegate = self
        // 셀의 높이 설정
        profileTableView.rowHeight = 120
        
        // 셀의 등록과정⭐️⭐️⭐️ (스토리보드 사용시에는 스토리보드에서 자동등록)
        profileTableView.register(ProfileTableCell.self, forCellReuseIdentifier: "ProfileCell")
    }
    
    func setupDatas() {
        profileDataManager.makeProfileData()
        profileMenuArray = profileDataManager.getProfileData()
    }
    
    // 테이블뷰의 오토레이아웃 설정
    func setupTableViewConstraints() {
        view.addSubview(profileTableView)
        profileTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            profileTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

extension ProfileViewController: UITableViewDataSource {
    // 1) 테이블뷰에 몇개의 데이터를 표시할 것인지(셀이 몇개인지)를 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileMenuArray.count
    }
    // 2) 셀의 구성(셀에 표시하고자 하는 데이터 표시)을 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileTableCell
        cell.mainIconView.image = profileMenuArray[indexPath.row].profileIcon
        cell.profileMenuLabel.text = profileMenuArray[indexPath.row].profileMenu
        cell.selectionStyle = .blue
        return cell

    }
    
    
    
}

extension ProfileViewController: UITableViewDelegate {
    
    // 셀이 선택이 되었을때 어떤 동작을 할 것인지 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
