import UIKit

final class SearchDelegate: NSObject, UISearchBarDelegate {

    private let viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchForPlaces(location: searchBar.text!) { _ in }
        searchBar.resignFirstResponder()
    }
}
