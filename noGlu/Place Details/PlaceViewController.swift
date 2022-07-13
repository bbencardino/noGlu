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
        saveFavorite()
    }

    @IBAction func markFavorite(_ sender: UIButton) {

        let heartFill = UIImage(systemName: "heart.fill")
        let heart = UIImage(systemName: "heart")

        if sender.currentImage == heart {
            sender.setImage(heartFill, for: .normal)
            viewModel.markFavoritePlace(true)
        } else {
            sender.setImage(heart, for: .normal)
            viewModel.markFavoritePlace(false)
        }
    }

    private func configurePlaceDetails() {
        name.text = viewModel.placeName
        address.text = viewModel.placeAddress
    }

    private func saveFavorite() {
        let imageName = viewModel.isFavoritePlace ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName),
                                    for: .normal)
    }
}
