import UIKit

final class CustomUserButton: UIButton {
    override init(frame: CGRect = CGRect(x: 0, y: 0, width: 60, height: 60)) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.backgroundColor = .hsWhite
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.hsUserStroke.cgColor
        self.layer.cornerRadius = 30
    }
}

