import UIKit
import SnapKit

final class BusCollectionViewCell: UICollectionViewCell {
    nonisolated static var identifier: String {
        return String(describing: self)
    }
    
    private let busLabel: UILabel = {
        let l = UILabel()
        l.font = .pretendardSemiBold(size: 14.0)
        l.textColor = .hsBlack
        l.textAlignment = .center
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        configureAddSubViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        attributes.frame.size.width = busLabel.intrinsicContentSize.width > 40 ? busLabel.intrinsicContentSize.width + 20 : 60
        attributes.frame.size.height = 24
        return attributes
    }
    
    override func layoutSubviews() {
        contentView.layer.cornerRadius = contentView.frame.height / 2
    }
    
    private func setup() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        
        // TODO: - 추후에 통신을 받음으로부터 바인딩 함.
        busLabel.text = ["55번", "56번", "청명역 셔틀버스", "병점역 셔틀버스", "가나다라마바사"].randomElement()
    }
    
    private func configureAddSubViews() {
        contentView.addSubview(busLabel)
    }
    
    private func configureConstraints() {
        busLabel.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(60)
            $0.center.equalToSuperview()
        }
    }
}
