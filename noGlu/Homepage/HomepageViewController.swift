import UIKit

class HomepageViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultTableView: UITableView!

    @IBOutlet weak var noConnectionView: UIView!
    @IBOutlet weak var homeView: UIView!

    private let reachability = try? Reachability()
    private let searchBarDelegate = SearchDelegate()
    private let resultDatasource = ResultDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        dismissKeyboard()
        searchBar.delegate = searchBarDelegate
        resultTableView.dataSource = resultDatasource
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

extension HomepageViewController {

    private func dismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view,
                                                action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
       // tapGesture.cancelsTouchesInView = false
    }
}
