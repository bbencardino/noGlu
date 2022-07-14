import UIKit

final class ResultTableViewCell: UITableViewCell {

    var viewModel: ResultCellViewModel! {
        didSet {
            updateView()
            updateImage()
            changeButtonImage()
        }
    }

    @IBOutlet weak var placeView: UIView!
    @IBOutlet weak var placeImageView: UIImageView!

    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var priceRange: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Mark Favorite

    @IBAction func markFavoritePlace(_ sender: UIButton) {
        let isFavorite = !viewModel.isFavoritePlace
        viewModel.markFavoritePlace(isFavorite)
        changeButtonImage()
    }

    private func changeButtonImage() {
        let imageName = viewModel.isFavoritePlace ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName),
                                    for: .normal)
    }

    private func updateView() {
        rating.text = viewModel.rating
        placeName.text = viewModel.placeName
        priceRange.text = viewModel.priceRange
    }

    private func updateImage() {
        DispatchQueue.global().async { [weak self] in
            self?.viewModel.image { image in
                DispatchQueue.main.async {
                    self?.placeImageView.image = image
                }
            }
        }
    }
}
