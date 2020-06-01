
import UIKit

class MovieDetailView: UIViewController {
    
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    
    var movieData : Product? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        dataSet()
    }
    fileprivate func dataSet() {
        lblTitle.text = movieData!.title
        lblDate.text = movieData!.release_date
        lblRating.text = String(describing: movieData!.vote_average)
        lblDetail.text = movieData?.overview
        
        let strOfUrl = "\(imgUrl + movieData!.poster_path)"
        guard  let url = URL(string: strOfUrl) else {
            return
        }
        imgMovie.downloaded(from: url, contentMode: .scaleToFill)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
