import UIKit

final class ResultDelegate: NSObject, UITableViewDelegate {

    private let viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.presentPlace(at: indexPath.row)
    }
}
