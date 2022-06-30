import UIKit

class HomepageViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!

    private let searchBarDelegate = SearchDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()

        dismissKeyboard()
        searchBar.delegate = searchBarDelegate
    }
}

extension HomepageViewController {

    private func dismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view,
                                                action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
       // tapGesture.cancelsTouchesInView = false
    }
}
