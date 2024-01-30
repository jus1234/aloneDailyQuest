//
//  QuestViewController.swift
//  AloneDailyQuest-QuestTestUI
//
//  Created by 오정석 on 20/12/2023.
//

import UIKit

class QuestViewController: UIViewController{
    
    // MARK: - UI설정(프로필, 테이블뷰)

    // 모델(저장 데이터를 관리하는 코어데이터)
    let questManager = CoreDataManager.shared
    
    // 테이블 뷰 생성
    private let tableView = UITableView()
    
//    // 프로필 베이스 뷰(제일 뒤에 있을 뷰)
//    let backView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    // 프로필 베이스 스택뷰⭐️
//    private lazy var baseStackView: UIStackView = {
//        let stview = UIStackView(arrangedSubviews: [profileView, expView])
//        stview.spacing = 20
//        stview.axis = .vertical
//        stview.distribution = .fill
//        stview.alignment = .fill
//        stview.translatesAutoresizingMaskIntoConstraints = false
//        return stview
//    }()
//    
    // MARK: - 프로필 윗부분 UI설정1️⃣
//
//    // 프로필뷰 생성
//    let profileView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    // 프로필 이미지 표시
//    let profileImage: UIImageView = {
//        let image = UIImageView()
//        image.translatesAutoresizingMaskIntoConstraints = false
//        return image
//    }()
//    
//    let nameLabel: UILabel = {
//        let name = UILabel()
//        name.textColor = UIColor(red: 0.627, green: 0.282, blue: 0.008, alpha:1)
//        name.font = UIFont(name: "DungGeunMo-Regular", size: 16)
//        name.translatesAutoresizingMaskIntoConstraints = false
//        name.text = "닉네임"
//        return name
//    }()
//    
//    // 사용자 이름 표시
//    let profileName: UILabel = {
//        let name = UILabel()
//        name.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
//        name.font = UIFont(name: "DungGeunMo-Regular", size: 16)
//        name.translatesAutoresizingMaskIntoConstraints = false
//        return name
//    }()
//    
//    let levelLabel: UILabel = {
//        let level = UILabel()
//        level.textColor = UIColor(red: 0.627, green: 0.282, blue: 0.008, alpha: 1)
//        level.font = UIFont(name: "DungGeunMo-Regular", size: 16)
//        level.translatesAutoresizingMaskIntoConstraints = false
//        level.text = "레벨"
//        return level
//    }()
//    
//    // 프로필 레벨 표시
//    let profileLevel: UILabel = {
//        let level = UILabel()
//        level.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
//        level.font = UIFont(name: "DungGeunMo-Regular", size: 16)
//        return level
//    }()
//    
//    // 프로필 윗부분 스택뷰
//    private lazy var profileStackView: UIStackView = {
//        let stview = UIStackView(arrangedSubviews: [profileImage, nameLabel, profileName, levelLabel, profileLevel])
//        stview.spacing = 20
//        stview.axis = .horizontal
//        stview.distribution = .fill
//        stview.alignment = .fill
//        stview.translatesAutoresizingMaskIntoConstraints = false
//        return stview
//    }()
//    
//    // MARK: - 프로필 아랫부분 UI설정2️⃣
//    
//    // 경험치 부분 뷰 생성
//    let expView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    let expLabel: UILabel = {
//        let label = UILabel()
//        label.text = "경험치 : "
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    // 경험치 표시 ( 아직 미정 ) 임시로 이미지로 설정
//    let expImage: UIImageView = {
//        let image = UIImageView()
//        image.translatesAutoresizingMaskIntoConstraints = false
//        // 임시 이미지 삽입 해야함 ⭐️
//        
//        return image
//    }()
//    
//    // 경험치 부분 스택뷰 생성
//    private lazy var expStackView: UIStackView = {
//        let stview = UIStackView(arrangedSubviews: [expImage, expLabel])
//        stview.spacing = 12
//        stview.axis = .horizontal
//        stview.distribution = .fill
//        stview.alignment = .fill
//        stview.translatesAutoresizingMaskIntoConstraints = false
//        return stview
//    }()
    
    // MARK: - UI설정

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.22, green: 0.784, blue: 0.784, alpha: 1)
        
        setupNaviBar()
        setupTableView()
        setupQuestViewConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // 네비게이션바 설정
    func setupNaviBar() {
        title = "일일 퀘스트"
        
        // (네비게이션바 설정관련)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() //불투명으로
        appearance.backgroundColor = UIColor(red: 0.22, green: 0.784, blue: 0.784, alpha: 1)
        appearance.configureWithTransparentBackground() //네비게이션 바 경계선 지우기
        
        //제목 색상 변경
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
        //제목 폰트 변경
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DungGeunMo", size: 30)!]
        
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        //네비게이션바 우측 Plus 버튼 만들기
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        plusButton.tintColor = .black
        navigationItem.rightBarButtonItem = plusButton
        
    }
   
    func setupTableView() {
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        // 셀의 등록과정 ⭐️ (코드로 구현)
        tableView.register(QuestCell.self, forCellReuseIdentifier: "QuestCell")
    }
    
    // 테이블뷰 자체의 오토레이아웃
    func setupQuestViewConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),// 프로필 만들면 프로필부터 거리 조절 해야함
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    // 네비바 상단 플러스 버튼 눌렀을때
    @objc func plusButtonTapped() {
        let detailVC = DetailViewController()
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension QuestViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questManager.getQuestListFromCoreData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestCell", for: indexPath) as! QuestCell
        
        // (테이블뷰 그리기 위한) 셀에 모델(QuestData) 전달
        let questData = questManager.getQuestListFromCoreData()
        cell.questData = questData[indexPath.row]
        
        
        // 셀 위에 있는 버튼이 눌렸을때 (뷰컨트롤러에서) 어떤 행동을 하기 위해서 클로저 전달
        // 세그웨이 대신 직접 push
        cell.updateButtonPressed = { [weak self] (senderCell) in
            let detailVC = DetailViewController()
            let selectedQuest = self?.questManager.getQuestListFromCoreData()[indexPath.row]
            detailVC.questData = selectedQuest
            
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        cell.selectionStyle = .none
        return cell
    }
}
