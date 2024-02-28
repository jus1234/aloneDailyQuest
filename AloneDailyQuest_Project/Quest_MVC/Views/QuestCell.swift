//
//  QuestCell.swift
//  AloneDailyQuest_Project
//
//  Created by 오정석 on 12/1/2024.
//

import UIKit

final class QuestCell: UITableViewCell {

    // MARK: - UI 설정 (퀘스트🍎윗부분 🍏아랫부분)
    let backView: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true
        view.image = UIImage(named: "img_quest_background")
        return view
    }()
    
    // 퀘스트 이미지
    lazy var questImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "img_quest_ing")
        return image
    }()
    
    // 퀘스트 타이틀
    lazy var questTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "DungGeunMo", size: 14)
        label.numberOfLines = 3
        return label
    }()
    
    lazy var questStckView: UIStackView =  {
        let stack = UIStackView(arrangedSubviews: [questImage, questTitle])
        stack.spacing = 10
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
    
    // 업데이트 버튼
    lazy var updateButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "btn_edit_normal"), for: .normal)
        return button
    }()
    
    // 삭제 버튼
    lazy var deleteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "btn_delete_normal"), for: .normal)
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [updateButton, deleteButton])
        stack.spacing = 10
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
    }()
    
    // 🍎(이미지, 퀘스트 내용, 업데이트 버튼, 삭제 버튼)
    lazy var firstView: UIView = {
        let view = UIView()
        view.addSubview(questStckView)
        view.addSubview(buttonStackView)
        return view
    }()
    
    
    // 요일반복 레이블
    lazy var repeatday: UILabel = {
        let label = UILabel()
        label.text = "매일 반복"
        label.font = UIFont(name: "DungGeunMo", size: 14)
        return label
    }()
    
    // 경험치량 표시
    lazy var expAmount: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "DungGeunMo", size: 14)
        label.text = "보상 : 20xp"
        return label
    }()

    // 완료하기 버튼
    lazy var completeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleFont(font: UIFont(name: "DungGeunMo", size: 14) ?? UIFont.systemFont(ofSize: 14))
        button.setTitle("완료하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(test), for: .touchUpInside)
        return button
    }()
    
    @objc func test() {
        print("눌림")
    }
    
    private lazy var secondStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [repeatday ,expAmount, completeButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    // 메인뷰랑, 서브뷰 합침
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstView, secondStackView])
        stack.spacing = 10
        stack.axis = .vertical
        return stack
    }()
    
    // QuestData를 전달받을 변수 (전달 받으면 ==> 표시하는 메서드 실행) ⭐️
    var questData: QuestDataModel? {
        didSet {
            configureUIwithData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setConstraints()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        questTitle.text = nil
        repeatday.text = nil
        completeButton.titleLabel?.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func addSubviews() {
        self.addSubview(backView)
        contentView.addSubview(mainStackView)
        contentView.addSubview(buttonStackView)
    }
    
    func setConstraints() {
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        questStckView.translatesAutoresizingMaskIntoConstraints = false
        questImage.translatesAutoresizingMaskIntoConstraints = false
        questTitle.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.widthAnchor.constraint(equalToConstant: 374).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 144).isActive = true
        
        backView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        backView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        mainStackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 24).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20).isActive = true
        mainStackView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 6).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -22).isActive = true
        
        
        buttonStackView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 15).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20).isActive = true
        
        questStckView.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 15).isActive = true
        questStckView.leadingAnchor.constraint(equalTo: firstView.leadingAnchor).isActive = true

        questImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        questImage.heightAnchor.constraint(equalToConstant: 50).isActive = true

        questTitle.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        questTitle.heightAnchor.constraint(equalToConstant: 42).isActive = true
    }
    
    var repeatLabel = ""
    
    // (퀘스트) 데이터를 가지고 적절한 UI 표시하기
    func configureUIwithData() {
        questTitle.text = questData?.quest
        mainStackView.isUserInteractionEnabled = true
        firstView.isUserInteractionEnabled = true
        secondStackView.isUserInteractionEnabled = true
        completeButton.isUserInteractionEnabled = true
        updateButton.isUserInteractionEnabled = true
        deleteButton.isUserInteractionEnabled = true
    }
    
    
    
}
