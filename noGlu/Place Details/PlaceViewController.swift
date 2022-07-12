import UIKit

final class PlaceViewController: UIViewController {

    var viewModel: PlaceViewModel!

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!

    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurePlaceDetails()
    }

    private func configurePlaceDetails() {
        name.text = viewModel.placeName
        address.text = viewModel.placeAddress
    }
}
