import UIKit

final class FavoritePlaceViewController: UIViewController {

    let viewModel = FavoritePlaceViewModel()
    lazy var dataSource = FavoritePlaceDataSource(viewModel: viewModel)

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
    }
}
