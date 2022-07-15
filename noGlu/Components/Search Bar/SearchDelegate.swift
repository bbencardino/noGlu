import UIKit

final class SearchDelegate: NSObject, UISearchBarDelegate {

    private let viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.startAnimatingActivityView?(true)

        viewModel.searchForPlaces(location: searchBar.text!) { [weak self] result in
            switch result {
            case.success:
                DispatchQueue.main.async {
                    searchBar.resignFirstResponder()
                    self?.viewModel.stopAnimatingActivityView?()
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    searchBar.resignFirstResponder()
                    self?.viewModel.stopAnimatingActivityView?()
                    self?.viewModel.presentAlert?(error.localizedDescription)
                }
            }
        }
    }
}
