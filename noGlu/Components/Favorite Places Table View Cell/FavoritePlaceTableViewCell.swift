import UIKit

final class FavoritePlaceTableViewCell: UITableViewCell {

    static let identifier = "favoritePlacesCell"
    var viewModel: FavoritePlaceCellViewModel! {
        didSet {
            updateView()
        }
    }

    @IBOutlet weak var priceRange: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var placeImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func updateView() {
        restaurantName.text = viewModel.placeName
        priceRange.text = viewModel.priceRange
        rating.text = viewModel.rating
        placeImageView.image = viewModel.image()
    }
}
