import UIKit

final class ResultDataSource: NSObject, UITableViewDataSource {

    private var viewModel: HomeViewModel!
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell",
                                                       for: indexPath) as? ResultTableViewCell else {
            fatalError("Table view cell is not ResultTableViewCell")
        }

        cell.placeName.text = viewModel.places[indexPath.row].name
        return cell
    }
}
