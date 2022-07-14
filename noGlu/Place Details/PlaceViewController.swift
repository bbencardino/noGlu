import UIKit

final class PlaceViewController: UIViewController {

    var viewModel: PlaceViewModel!

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurePlaceDetails()
        changeButtonImage()
    }

    @IBAction func markFavorite(_ sender: UIButton) {
        let isFavorite = !viewModel.isFavoritePlace
        viewModel.markFavoritePlace(isFavorite)
        changeButtonImage()
    }

    private func configurePlaceDetails() {
        name.text = viewModel.placeName
        address.text = viewModel.placeAddress
        imageView.image = viewModel.image()
    }

    private func changeButtonImage() {
        let imageName = viewModel.isFavoritePlace ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName),
                                    for: .normal)
    }
}
