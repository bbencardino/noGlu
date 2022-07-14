import UIKit

final class Alert {

    class func basicAlert(title: String,
                          message: String,
                          viewController: UIViewController) {

        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default))
        viewController.present(alert, animated: true)
    }
}
