import UIKit

final class CustomPaddingLabel: UILabel {
    private var topInset: CGFloat = 2
    private var bottomInset: CGFloat = 2
    private var leftInset: CGFloat = 7
    private var rightInset: CGFloat = 7
    
    override func drawText(in rect: CGRect) {
        let inset: UIEdgeInsets = UIEdgeInsets(
            top: topInset,
            left: leftInset,
            bottom: bottomInset,
            right: rightInset
        )
        super.drawText(in: rect.inset(by: inset))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        if (size.width == 0) { return size }
        return CGSize(
            width: size.width + leftInset + rightInset,
            height: size.height + topInset + bottomInset
        )
    }
}

