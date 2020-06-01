
import UIKit

protocol MovieFlixDelgate {
    func deleteCell(_ index: Int)
}

class HomeCell: UICollectionViewCell {
    @IBOutlet weak var imgWidth: NSLayoutConstraint!
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    var index: IndexPath?
    var delegate: MovieFlixDelgate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let screenWidth = UIScreen.main.bounds.size.width / 2
        imgWidth.constant = screenWidth - 30
    }
    @IBAction func btnDelete(_ sender: Any) {
        delegate?.deleteCell(index!.row)
    }
}
