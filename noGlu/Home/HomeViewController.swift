import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultTableView: UITableView!

    private let viewModel = HomeViewModel()
    lazy var searchBarDelegate = SearchDelegate(viewModel: viewModel)
    lazy var resultDataSource = ResultDataSource(viewModel: viewModel)

    override func viewDidLoad() {
        super.viewDidLoad()

        dismissKeyboard()
        searchBar.delegate = searchBarDelegate
        resultTableView.dataSource = resultDataSource
        viewModel.reloadView = resultTableView.reloadData
    }
}

extension HomeViewController {

    /// Dismiss keyboard when tapping outside search bar
    private func dismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view,
                                                action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
}
