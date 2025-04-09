import UIKit
import SnapKit

final class CustomDetailStationView: UIView {
    private let titleView = UIView()
    
    private let mainLabel: UILabel = {
        let l = UILabel()
        l.font = .pretendardSemiBold(size: 18.0)
        l.textColor = .hsBlack
        l.addCharecterString()
        return l
    }()
    
    private let subLabel: UILabel = {
        let l = UILabel()
        l.font = .pretendardRegular(size: 12.0)
        l.textColor = .hsLightGray
        l.addCharecterString()
        return l
    }()
    
    private let dismissButton: UIButton = {
        let b = UIButton()
        b.setImage(
            .resizedImage(image: UIImage(named: "close"),
            size: CGSize(width: 29.0, height: 29.0)),
            for: .normal
        )
        return b
    }()
    
    private let busTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        configureAddSubViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
    }
    
    private func configureAddSubViews() {
        addSubview(titleView)
        addSubview(busTableView)
        titleView.addSubview(mainLabel)
        titleView.addSubview(subLabel)
        titleView.addSubview(dismissButton)
    }
    
    private func configureConstraints() {
        titleView.snp.makeConstraints {
            $0.height.equalTo(45)
            $0.leading.trailing.top.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.leading.equalToSuperview().inset(10)
        }
        
        subLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.top.equalTo(mainLabel.snp.bottom).offset(3)
        }
        
        dismissButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
        }
        
        busTableView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

