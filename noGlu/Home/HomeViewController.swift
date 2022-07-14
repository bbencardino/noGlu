import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultTableView: UITableView!

    private let viewModel = HomeViewModel()
    lazy var searchBarDelegate = SearchDelegate(viewModel: viewModel)
    lazy var resultDataSource = ResultDataSource(viewModel: viewModel)
    lazy var resultDelegate = ResultDelegate(viewModel: viewModel)

    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var noConnectionView: UIView!
    @IBOutlet weak var homeView: UIView!
    private let reachability = try? Reachability()

    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboard()
        configureView()
    }

    // MARK: - Reachability
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setReachability()
        resultTableView.reloadData()
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

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTheDetails" {
            guard let destination = segue.destination as? PlaceViewController
            else { return }

            guard let sender = sender as? Int else { return }
            destination.viewModel = viewModel.makePlaceDetailsViewModel(at: sender)
        }
    }

    private func performNavigation(index: Int) {
        performSegue(withIdentifier: "toTheDetails", sender: index)
    }

    // MARK: Helper methods
    private func configureView() {
        searchBar.delegate = searchBarDelegate
        resultTableView.dataSource = resultDataSource
        resultTableView.delegate = resultDelegate
        viewModel.reloadView = resultTableView.reloadData
        viewModel.performNavigation = performNavigation
        viewModel.presentAlert = self.presentAlert
        viewModel.startAnimatingActivityView = self.startAnimatingActivityView
        viewModel.stopAnimatingActivityView = activityView.stopAnimating

        let nib = UINib(nibName: "ResultTableViewCell", bundle: nil)
        resultTableView.register(nib, forCellReuseIdentifier: ResultTableViewCell.identifier)
    }

    private func presentAlert(with message: String) {
        Alert.basicAlert(title: "", message: message, viewController: self)
    }

    private func startAnimatingActivityView(_ visibility: Bool) {
        activityView.isHidden = !visibility
        activityView.startAnimating()
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
