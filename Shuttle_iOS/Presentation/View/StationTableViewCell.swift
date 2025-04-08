import UIKit
import SnapKit

final class StationTableViewCell: UITableViewCell {
    nonisolated static var identifier: String {
        return String(describing: self)
    }
    
    private let stationLabel: UILabel = {
        let l = UILabel()
        l.font = .pretendardSemiBold(size: 18.0)
        l.textColor = .hsBlack
        l.addCharecterString()
        return l
    }()
    
    private let additionLabel: UILabel = {
        let l = UILabel()
        l.clipsToBounds = true
        l.font = .pretendardSemiBold(size: 12.0)
        l.textAlignment = .center
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        configureAddSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        selectionStyle = .none
    }
    
    private func configureAddSubViews() {
        contentView.addSubview(stationLabel)
        contentView.addSubview(additionLabel)
        
        stationLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        }
        
        additionLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(stationLabel).offset(10)
        }
    }
}
