//
//  QuestViewController.swift
//  AloneDailyQuest-QuestTestUI
//
//  Created by 오정석 on 20/12/2023.
//

import UIKit

class QuestViewController: UIViewController{
    
    // MARK: - UI설정(프로필, 테이블뷰)
    
    // 테이블 뷰 생성
    private let tableView = UITableView()
    
    // 모델(저장 데이터를 관리하는 코어데이터)
    let questManager = CoreDataManager.shared
    
    // MARK: - 프로필 부분

    lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_profile_background")
        return view
    }()
    
    lazy var profileImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_profile_Lv1-10")
        return view
    }()
    
    lazy var nickNameTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.44, green: 0.22, blue: 0.04, alpha: 1.00)
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "닉네임", attributes: underlineAttribute)
        label.attributedText = underlineAttributedString
        return label
    }()
    
    lazy var nickNameText: UILabel = {
        let label = UILabel()
        label.text = "매튜"
        label.textAlignment = .center
        return label
    }()
    
//    lazy var nickNameStackView: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [nickNameTitleLabel, nickNameText])
//        stack.spacing = 10
//        stack.axis = .horizontal
//        stack.distribution = .fill
//        stack.alignment = .fill
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        return stack
//    }()
    
    lazy var levelTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.44, green: 0.22, blue: 0.04, alpha: 1.00)
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "레벨", attributes: underlineAttribute)
        label.attributedText = underlineAttributedString
        return label
    }()
    
    lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.text = "LV.1"
        return label
    }()
//    
//    lazy var levelStackView: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [levelTitleLabel, levelLabel])
//        stack.spacing = 20
//        stack.axis = .horizontal
//        stack.distribution = .fillEqually
//        stack.alignment = .fill
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        return stack
//    }()
    
    lazy var firstStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [profileImage, nickNameTitleLabel, nickNameText, levelTitleLabel, levelLabel])
        stack.spacing = 15
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 3.5
        view.layer.borderColor = CGColor(red: 0.90, green: 0.83, blue: 0.74, alpha: 1.00)
        return view
    }()
    
    lazy var experienceTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.44, green: 0.22, blue: 0.04, alpha: 1.00)
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "경험치", attributes: underlineAttribute)
        label.attributedText = underlineAttributedString
        return label
    }()
    
    lazy var experienceBar: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_level_bar")
        let attrString = NSAttributedString(
            string: "0/10",
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor.black,
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font : UIFont(name: "DungGeunMo", size: 16)
            ]
        )
        view.layer.backgroundColor = UIColor(red: 0.261, green: 0.872, blue: 0.248, alpha: 1).cgColor
        view.accessibilityAttributedLabel = attrString
        return view
    }()
    
    lazy var secondStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [experienceTitleLabel, experienceBar])
        stack.spacing = 12
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var allStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [firstStackView, secondStackView])
        stack.spacing = 16
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - UI설정

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.22, green: 0.784, blue: 0.784, alpha: 1)
        
        setupNaviBar()
        setupTableView()
        profileAutoLayout()
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
    
    var firstHeightConstraint: CGFloat = 26
    var secondHeightConstraint: CGFloat = 18
    var trailingAnchorConstraint: CGFloat = -4
    
    func profileAutoLayout() {
        view.addSubview(backgroundView)
        backgroundView.addSubview(allStackView)
        backgroundView.addSubview(separatorView)
        allStackView.addSubview(firstStackView)
        allStackView.addSubview(secondStackView)
        firstStackView.addSubview(profileImage)
        firstStackView.addSubview(nickNameTitleLabel)
        firstStackView.addSubview(levelTitleLabel)
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        nickNameTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        levelTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: trailingAnchorConstraint),
            backgroundView.heightAnchor.constraint(equalToConstant: 100),
            
            separatorView.heightAnchor.constraint(equalToConstant: 2),
            separatorView.topAnchor.constraint(equalTo: firstStackView.bottomAnchor, constant: 6),
            separatorView.leadingAnchor.constraint(equalTo: firstStackView.leadingAnchor, constant: 0),
            separatorView.trailingAnchor.constraint(equalTo: firstStackView.trailingAnchor, constant: 0),
            
            profileImage.widthAnchor.constraint(equalToConstant: firstHeightConstraint),
            profileImage.heightAnchor.constraint(equalTo: profileImage.widthAnchor),
            
            nickNameTitleLabel.widthAnchor.constraint(equalToConstant: 50),
            
            levelLabel.widthAnchor.constraint(equalToConstant: 35),
            levelTitleLabel.widthAnchor.constraint(equalTo: levelLabel.widthAnchor),
            
            
            
            firstStackView.heightAnchor.constraint(equalToConstant: firstHeightConstraint),
            secondStackView.heightAnchor.constraint(equalToConstant: secondHeightConstraint),
            
           
            allStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 20),
            allStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 30),
            allStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -30)
        ])
        
        
    }
    
    // 테이블뷰 자체의 오토레이아웃
    func setupQuestViewConstraints() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailingAnchorConstraint),
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
