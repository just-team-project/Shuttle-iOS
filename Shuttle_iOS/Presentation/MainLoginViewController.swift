//
//  MainLoginViewController.swift
//  Shuttle_iOS
//
//  Created by 강대훈 on 3/31/25.
//

import UIKit
import SnapKit
import Combine

final class MainLoginViewController: UIViewController {
    
    private var viewModel : MainLoginViewModel
    private let input = PassthroughSubject<MainLoginViewModel.Input, Never>()
    private var cancellables : Set<AnyCancellable> = .init()
    
    private lazy var stackView : UIStackView = {
        let sv = UIStackView(arrangedSubviews:
                                [titleLabel,
                                 titleImageView,
                                 userLoginStackView])
        sv.axis = .vertical
        sv.spacing = 47
        sv.alignment = .fill
        sv.distribution = .equalSpacing
        return sv
    }()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.pretendardExtraBold(size: 30.0)
        l.text = "셔틀"
        l.textAlignment = .center
        return l
    }()
    
    private let titleImageView: UIImageView = {
        let i = UIImageView(image: UIImage(named: "loginImage") ?? UIImage())
        i.contentMode = .scaleAspectFit
        return i
    }()
    
    private lazy var userLoginStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [inputStackView,
                                                userLoginButton])
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
        t.autocapitalizationType = .none
        t.autocorrectionType = .no
        t.spellCheckingType = .no
        t.keyboardType = .emailAddress
        t.font = UIFont.pretendardMedium(size: 16.0)
        return t
    }()
    
    private let emailLabel : UILabel = {
        let l = UILabel()
        l.text = Constant.emailDomain
        l.textColor = .hsDarkGray
        l.font = UIFont.pretendardMedium(size: 16.0)
        l.layer.borderWidth = 1
        l.layer.borderColor = UIColor.hsLightGrayStroke.cgColor
        l.textAlignment = .center
        return l
    }()
    
    private let userLoginButton: UIButton = {
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
    
    init(viewModel: MainLoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("MainLoginViewController - fatalError")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        bind()
        configureAddSubViews()
        configureConstraints()
        configureAddActions()
    }
    
    private func setup() {
        view.backgroundColor = .white
        inputTextField.delegate = self
    }
    
    private func bind() {
        let output = viewModel.transform(input: input.eraseToAnyPublisher())
        
        output.sink { [weak self] event in
            switch event {
            case .userLoginSuccess:
                self?.userLoginSuccess()
            case .userLoginRequest:
                self?.userLoginRequest()
            case .failure(let errorString):
                self?.failure(errorString)
            }
        }.store(in: &cancellables)
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
        
        userLoginButton.snp.makeConstraints {
            $0.height.equalTo(54)
        }
        
        busLoginButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(24)
            $0.height.equalTo(54)
            $0.top.equalTo(userLoginStackView.snp.bottom).offset(24)
        }
    }
    
    private func configureAddActions() {
        addTappedEventToUserLoginButton()
        addTappedEventToBusLoginButton()
    }
    
    private func addTappedEventToUserLoginButton() {
        userLoginButton.addAction(
            UIAction { [weak self] _ in
                guard let self = self else { return }
                guard let text = inputTextField.text else { return }
                input.send(.userLoginTapped(email: text + Constant.emailDomain))
            }, for: .touchUpInside)
    }
    
    private func addTappedEventToBusLoginButton() {
        // TODO: - 버스 로그인
    }
}

private extension MainLoginViewController {
    // MARK: - User Login Success (User 화면으로 이동)
    private func userLoginSuccess() {
        print("UserLogin Success")
    }
    // MARK: - User Login Request (이메일에 요청을 보냄)
    private func userLoginRequest() {
        print("UserLogin Request")
    }
    // MARK: - Email이 유효하지 않음. (잘못된 입력)
    private func failure(_ errorString : String) {
        print(errorString)
    }
}

extension MainLoginViewController : UITextFieldDelegate {
    // MARK: - 영어 숫자 백스페이스만 허용
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { return true }
        let allowedCharacters = CharacterSet(charactersIn: Constant.emailAllowCharacters)
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
