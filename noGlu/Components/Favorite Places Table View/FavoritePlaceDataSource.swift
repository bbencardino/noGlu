import UIKit

final class FavoritePlaceDataSource: NSObject, UITableViewDataSource {

    private var viewModel: FavoritePlaceViewModel!
    init(viewModel: FavoritePlaceViewModel) {
        self.viewModel = viewModel
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritePlaceTableViewCell.identifier,
                                                       for: indexPath) as? FavoritePlaceTableViewCell else {
            fatalError("Table view cell is not FavoritePlaceTableViewCell")
        }
        let index = indexPath.row
        cell.viewModel = viewModel.makeFavoritePlaceCellViewModel(for: index)
        return cell
    }
}
