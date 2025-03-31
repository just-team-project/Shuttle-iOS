//
//  MainLoginViewController.swift
//  Shuttle_iOS
//
//  Created by 강대훈 on 3/31/25.
//

import UIKit
import SnapKit

final class MainLoginViewController: UIViewController {
    
    private lazy var stackView : UIStackView = {
        let sv = UIStackView(arrangedSubviews:
                                [titleLabel,
                                 titleImageView,
                                 loginStackView])
        sv.axis = .vertical
        sv.spacing = 47
        sv.alignment = .fill
        sv.distribution = .equalSpacing
        return sv
    }()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.pretendardExtraBold(size: 30.0)
        l.text = "한신셔틀"
        l.textAlignment = .center
        return l
    }()
    
    private let titleImageView: UIImageView = {
        let i = UIImageView(image: UIImage(named: "loginImage") ?? UIImage())
        i.contentMode = .scaleAspectFit
        return i
    }()
    
    private lazy var loginStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [inputStackView,
                                                loginButton])
        sv.axis = .vertical
        sv.spacing = 12
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()
    
    private lazy var inputStackView : UIStackView = {
        let sv = UIStackView(arrangedSubviews: [inputEmailView,
                                                emailLabel])
        sv.axis = .horizontal
        sv.spacing = 0
        sv.alignment = .fill
        sv.distribution = .fill
        sv.clipsToBounds = true
        sv.backgroundColor = .hsLightGray
        sv.layer.cornerRadius = 8
        sv.layer.borderWidth = 1
        sv.layer.borderColor = UIColor.hsLightGrayStroke.cgColor
        return sv
    }()
    
    private let inputEmailView: UIView = UIView()
    
    private let inputTextField: UITextField = {
        let t = UITextField()
        t.placeholder = "이메일을 입력해주세요."
        t.textColor = .hsDarkGray
        t.font = UIFont.pretendardMedium(size: 16.0)
        t.spellCheckingType = .no
        return t
    }()
    
    private let emailLabel : UILabel = {
        let l = UILabel()
        l.text = "@hs.ac.kr"
        l.textColor = .hsDarkGray
        l.font = UIFont.pretendardMedium(size: 16.0)
        l.layer.borderWidth = 1
        l.layer.borderColor = UIColor.hsLightGrayStroke.cgColor
        l.textAlignment = .center
        return l
    }()
    
    private let loginButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = .login
        b.setTitleColor(.hsWhite, for: .normal)
        b.titleLabel?.font = UIFont.pretendardMedium(size: 16.0)
        b.setTitle("로그인 하기", for: .normal)
        b.clipsToBounds = true
        b.layer.cornerRadius = 8
        return b
    }()
    
    private let busLoginButton : UIButton = {
        let b = UIButton()
        b.setTitle("버스 로그인", for: .normal)
        b.clipsToBounds = true
        b.titleLabel?.font = UIFont.pretendardMedium(size: 16)
        b.setTitleColor(.hsBlack, for: .normal)
        b.layer.cornerRadius = 8
        b.layer.borderWidth = 1
        b.layer.borderColor = UIColor.hsLightGrayStroke.cgColor
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        configureAddSubViews()
        configureConstraints()
    }
    
    private func setup() {
        view.backgroundColor = .white
    }
    
    private func configureAddSubViews() {
        view.addSubview(stackView)
        view.addSubview(busLoginButton)
        
        inputEmailView.addSubview(inputTextField)
    }
    
    private func configureConstraints() {
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(24)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(130)
        }
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        titleImageView.snp.makeConstraints {
            $0.height.equalTo(180)
        }
        
        inputStackView.snp.makeConstraints {
            $0.height.equalTo(54)
        }
        
        inputEmailView.snp.makeConstraints {
            $0.width.equalTo(270)
        }
        
        inputTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints {
            $0.height.equalTo(54)
        }
        
        busLoginButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(24)
            $0.height.equalTo(54)
            $0.top.equalTo(loginStackView.snp.bottom).offset(24)
        }
    }
}
