import UIKit

final class ResultTableViewCell: UITableViewCell {

    var viewModel: ResultCellViewModel! {
        didSet {
            updateView()
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

        // Configure the view for the selected state
    }

    private func updateView() {
        rating.text = viewModel.rating
        placeName.text = viewModel.placeName
        priceRange.text = viewModel.priceRange
    }
}
