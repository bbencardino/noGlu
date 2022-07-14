import UIKit

final class SearchDelegate: NSObject, UISearchBarDelegate {

    private let viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchForPlaces(location: searchBar.text!) { [weak self] result in

            if let startAnimating = self?.viewModel.startAnimatingActivityView { startAnimating(true) }

            DispatchQueue.main.async {
                switch result {
                case.success:
                    searchBar.resignFirstResponder()
                case .failure(let error):
                    searchBar.resignFirstResponder()
                    if let presentAlert = self?.viewModel.presentAlert {
                        presentAlert(error.localizedDescription)
                    }
                }
            }
        }
    }
}
