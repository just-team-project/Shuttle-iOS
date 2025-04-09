import UIKit

final class CustomUserButton: UIButton {
    init(frame: CGRect = .zero, image: UIImage?) {
        super.init(frame: frame)
        setup(image: image)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(image: UIImage?) {
        self.backgroundColor = .white
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.hsUserStroke.cgColor
        self.layer.cornerRadius = 30
        self.setImage(
            .resizedImage(image: image, size: CGSize(width: 28.0, height: 28.0)),
            for: .normal
        )
    }
}

