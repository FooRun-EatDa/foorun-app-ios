//
//  BirthDayViewController.swift
//  Foorun
//
//  Created by Hamlit Jason on 2022/09/03.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class EntryViewController: UIViewController {
    let disposeBag = DisposeBag()
    let password: String = "0904"
    
    // MARK: - 입장뷰
    let entryLabel = UILabel()
    let entryTextField = UITextField()
    let entryButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        entryView()
        bind()
    }
    
    // MARK: - 입장뷰
    func entryView() {
        [entryLabel, entryTextField, entryButton].forEach { view.addSubview($0) }
        
        entryLabel.textAlignment = .center
        entryLabel.numberOfLines = 0
        entryLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        entryLabel.text = """
            이 페이지는 스페셜 페이지입니다.
            해당 페이지를 열람하기 위해서는
            올바른 비밀번호를 입력해주세요.
        
            기회는 무제한입니다.
        """
        entryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(100)
        }
        
        entryTextField.borderStyle = .roundedRect
        
        entryTextField.snp.makeConstraints {
            $0.top.equalTo(entryLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(50)
        }
        
        entryButton.setTitle("✨버튼✨", for: .normal)
        entryButton.setTitleColor(.green, for: .normal)
        entryButton.snp.makeConstraints {
            $0.top.equalTo(entryTextField.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview()
        }
        
    }
    
    func bind() {
        entryButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.isCorretPassword(owner)
            }
            .disposed(by: disposeBag)
    }
    
    func isCorretPassword(_ owner: EntryViewController) {
        if owner.entryTextField.text == owner.password {
            // TRUE!
            let viewController = BirthDayViewController()
            viewController.modalTransitionStyle = .flipHorizontal
            viewController.modalPresentationStyle = .fullScreen
            
            owner.present(viewController, animated: true)
        } else {
            // FALSE!
            
            let alertController = UIAlertController(
                title: nil,
                message: "💡 HINT: 푸런 팀 멤버 💡",
                preferredStyle: .alert
            )
            
            let confirmAction = UIAlertAction(title: "confirm", style: .default)
            alertController.addAction(confirmAction)
            owner.present(alertController, animated: true)
        }
    }
}

final class BirthDayViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    // MARK: - 일반뷰
    let contentLabel = UILabel()
    let 복지Label = UILabel()
    let x버튼 = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCommonView()
    }
    
    func setupCommonView() {
        view.addSubview(x버튼)
        x버튼.setTitle("🔙", for: .normal)
        x버튼.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).offset(25)
        }
        x버튼.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        view.addSubview(contentLabel)
        
        contentLabel.textAlignment = .center
        contentLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        contentLabel.textColor = .darkGray
        contentLabel.numberOfLines = 0
        contentLabel.text = """
            
            여러분 다들 이게 뭔ㄱ ㅏ 싶으시죠?
            
            오늘은 저희 푸런팀 iOS 개발짱
            
            나희
            
            의 생일입니다!
        
            ☺️ 행복한 생일 보내시길 바랍니다!
        """
        
        contentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-150)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(복지Label)
        복지Label.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(50)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        복지Label.textAlignment = .center
        복지Label.font = UIFont.preferredFont(forTextStyle: .caption1)
        복지Label.textColor = .darkGray
        복지Label.numberOfLines = 0
        복지Label.text = """
        [우아한 푸런복지]
        관심과 애정으로 구성원을 챙깁니다.
        
        자세한 사항은
        💡 푸런 복지팀에 문의해주세요.
        
        """
        
    }
    
    
}
