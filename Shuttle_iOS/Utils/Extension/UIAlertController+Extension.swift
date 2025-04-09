import UIKit

extension UIAlertController {
    /// 오류 발생시 사용하는 Alert
    static func errorAlert(message: String) -> UIAlertController {
        let alertController = UIAlertController(
            title: "",
            message: message,
            preferredStyle: .alert
            )
        
        alertController.addAction(
            .init(title: "확인",
                  style: .default)
        )
        
        return alertController
    }
    
    static func alert(
        title: String = "",
        message: String = "",
        defaultCompletion: (() -> Void)? = nil,
        cancelCompletion: (() -> Void)? = nil
    ) -> UIAlertController {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let defaultAction = UIAlertAction(
            title: "확인",
            style: .default) { _ in
            defaultCompletion?()
        }
        
        let cancelAction = UIAlertAction(
            title: "취소",
            style: .cancel) { _ in
            cancelCompletion?()
        }
        alertController.addAction(defaultAction)
        alertController.addAction(cancelAction)
        return alertController
    }
}
