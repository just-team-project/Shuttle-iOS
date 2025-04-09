import UIKit
import SnapKit

final class DetailStationTableViewCell: UITableViewCell {
    nonisolated static var identifier: String {
        return String(describing: self)
    }
    
    private let busImageView: UIImageView = {
        let iv = UIImageView(
            image: .resizedImage(image: UIImage(named: "bus"),
            size: CGSize(width: 24, height: 24))
        )
        return iv
    }()
    
    private let busLabel: UILabel = {
        let l = UILabel()
        l.addCharecterString()
        l.font = .pretendardMedium(size: 14.0)
        l.textColor = .hsBlack
        return l
    }()
    
    private lazy var remainingTimeStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [firstRemainingTimeLabel, secondRemainingTimeLabel])
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 2
        return sv
    }()
    
    private let firstRemainingTimeLabel: UILabel = {
        let l = UILabel()
        l.font = .pretendardMedium(size: 12.0)
        l.textColor = .hsRed
        l.addCharecterString()
        return l
    }()
    
    private let secondRemainingTimeLabel: UILabel = {
        let l = UILabel()
        l.font = .pretendardMedium(size: 12.0)
        l.textColor = .hsRed
        l.addCharecterString()
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        configureAddSubViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        selectionStyle = .none
    }
    
    private func configureAddSubViews() {
        contentView.addSubview(busImageView)
        contentView.addSubview(busLabel)
        contentView.addSubview(remainingTimeStackView)
    }
    
    private func configureConstraints() {
        busImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        }
        
        busLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(busImageView.snp.trailing).offset(2)
        }
        
        remainingTimeStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(5)
        }
    }
}
