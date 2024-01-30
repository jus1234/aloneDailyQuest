//
//  DetailViewController.swift
//  AloneDailyQuest_Project
//
//  Created by 오정석 on 12/1/2024.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private let detailView = DetailView()
    
    override func loadView() {
        self.view = detailView
    }
    
    let questManager = CoreDataManager.shared
    
    var questData: QuestData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setup() {
        detailView.questTextView.delegate = self
        //        detailView.buttons.forEach{ button in button.addTarget(self, action: #selector(repeatButtonTapped), for: .touchUpInside)
        //        }
        navigationController?.navigationBar.prefersLargeTitles = false
        
        //        detailView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
            }
    
    func configureUI() {
        if let questData = self.questData {
            self.title = "퀘스트 수정하기"
            guard let text = questData.quest else { return }
            detailView.questTextView.text = text
            
            detailView.questTextView.textColor = .black
            detailView.saveButton.setTitle("UPDATE", for: .normal)
            detailView.questTextView.becomeFirstResponder()
            
            
        } else {
            self.title = "새로운 퀘스트 생성하기"
            
            detailView.questTextView.text = "퀘스트를 입력하세요."
            detailView.questTextView.textColor = .lightGray
            
        }
    }
    
    // 요일 반복 버튼 기능구현
    @objc func repeatButtonTapped(_ sender: UIButton){
        
    }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        // 기존 데이터가 있을때 ===> 기존 데이터 업데이트
        if let questData = self.questData {
            // 텍스트뷰에 저장되어 있는 메시지
            questData.quest = detailView.questTextView.text
            questManager.updateQuest(newQuestData: questData) {
                print("업데이트 완료")
                // 다시 전화면으로 돌아가기
                self.navigationController?.popViewController(animated: true)
            }
            
            // 기존데이터가 없을때 ===> 새로운 데이터 생성
        } else {
            let questText = detailView.questTextView.text
            questManager.saveQuestData(questText: questText, sunday: false, monday: false, tuesday: false, wednesday: false, thursday: false, friday: false, saturday: false) {
                print("저장완료")
                // 다시 전화면으로 돌아가기
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    // 다른곳을 터치하면 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension DetailViewController: UITextViewDelegate {
    // 입력을 시작할때
    // (텍스트뷰는 플레이스홀더가 따로 있지 않아서, 플레이스 홀더처럼 동작하도록 직접 구현)
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "퀘스트를 여기에 입력하세요." {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // 입력이 끝났을때
    func textViewDidEndEditing(_ textView: UITextView) {
        // 비어있으면 다시 플레이스 홀더처럼 입력하기 위해서 조건 확인
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "퀘스트를 여기에 입력하세요."
            textView.textColor = .lightGray
        }
    }
}
