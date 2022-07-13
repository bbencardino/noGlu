import UIKit

final class ResultTableViewCell: UITableViewCell {

    var viewModel: ResultCellViewModel! {
        didSet {
            updateView()
            saveFavorite()
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

    private func saveFavorite() {
        let imageName = viewModel.isFavoritePlace ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName),
                                    for: .normal)
    }

    private func updateView() {
        rating.text = viewModel.rating
        placeName.text = viewModel.placeName
        priceRange.text = viewModel.priceRange
    }
}
