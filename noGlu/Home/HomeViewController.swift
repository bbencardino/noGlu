import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultTableView: UITableView!

    private let viewModel = HomeViewModel()
    lazy var searchBarDelegate = SearchDelegate(viewModel: viewModel)
    lazy var resultDataSource = ResultDataSource(viewModel: viewModel)

    @IBOutlet weak var noConnectionView: UIView!
    @IBOutlet weak var homeView: UIView!
    private let reachability = try? Reachability()

    override func viewDidLoad() {
        super.viewDidLoad()

        dismissKeyboard()
        searchBar.delegate = searchBarDelegate
        resultTableView.dataSource = resultDataSource
        viewModel.reloadView = resultTableView.reloadData
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setReachability()
    }

    private func setReachability() {
        reachability?.whenReachable = { [weak self] _ in
            self?.showHomeScreen(true)
        }

        reachability?.whenUnreachable = { [weak self] _ in
            self?.showHomeScreen(false)
        }

        NotificationCenter.default
            .addObserver(self,
                      selector: #selector(reachabilityChanged),
                      name: .reachabilityChanged,
                      object: reachability)
        do {
          try reachability?.startNotifier()
        } catch {
          print("could not start reachability notifier")
        }
    }

    @objc private func reachabilityChanged(_ notification: Notification) {
        showHomeScreen(reachability?.connection != .unavailable)
    }

    private func showHomeScreen(_ hasInternet: Bool) {
        noConnectionView.isHidden = hasInternet
        homeView.isHidden = !hasInternet
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
