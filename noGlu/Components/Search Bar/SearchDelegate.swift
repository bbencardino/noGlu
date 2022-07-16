import UIKit

final class SearchDelegate: NSObject, UISearchBarDelegate {

    private let viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let lastSearch = viewModel.getLastSearch() {
            searchBar.text = lastSearch
        }
    }

   

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.saveLastSearch(searchBar.text ?? "")

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
        searchBar.text?.removeAll()
    }
}
