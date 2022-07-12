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

    @IBAction func markFavorite(_ sender: UIButton) {

        let heartFill = UIImage(systemName: "heart.fill")
        let heart = UIImage(systemName: "heart")

        if sender.imageView?.image == heart {
            sender.setImage(heartFill, for: .normal)
        } else {
            sender.setImage(heart, for: .normal)
        }
    }

    private func configurePlaceDetails() {
        name.text = viewModel.placeName
        address.text = viewModel.placeAddress
    }
}
