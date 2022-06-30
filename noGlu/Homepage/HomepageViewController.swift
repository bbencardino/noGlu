import UIKit

class HomepageViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultTableView: UITableView!

    private let searchBarDelegate = SearchDelegate()
    private let resultDatasource = ResultDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        dismissKeyboard()
        searchBar.delegate = searchBarDelegate
        resultTableView.dataSource = resultDatasource
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
