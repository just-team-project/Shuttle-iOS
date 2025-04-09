import UIKit

extension UILabel {
    /// 자간을 설정합니다. (기본 값 -2.5%)
    func addCharecterString(_ value: Double = -0.025) {
        let kernValue = font.pointSize * CGFloat(value)
        guard let text = text, !text.isEmpty else { return }
        let string = NSMutableAttributedString(string: text)
        string.addAttribute(
            NSAttributedString.Key.kern,
            value: kernValue,
            range: NSRange(location: 0, length: string.length - 1)
        )
        
        self.attributedText = string
    }
}
