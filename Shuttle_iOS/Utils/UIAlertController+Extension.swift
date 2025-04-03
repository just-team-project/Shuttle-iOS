import UIKit

/// isError : true -  "확인" 버튼만 나옵니다. (default)
/// isError : false - "확인", "취소" 버튼이 나옵니다.
extension UIAlertController {
    static func make(title: String = "",
                     message: String,
                     isError: Bool = true,
                     defaultLabel: String = "확인",
                     cancelLabel: String = "취소"
    ) -> UIAlertController {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
            )
        
        alertController.addAction(.init(title: defaultLabel, style: .default))
        if !isError {
            alertController.addAction(.init(title: cancelLabel, style: .cancel))
        }
        return alertController
    }
}
