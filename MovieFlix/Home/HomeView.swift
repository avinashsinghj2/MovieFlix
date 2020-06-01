
import UIKit

class HomeView: UIViewController {

    @IBOutlet weak var menuTabbar: UITabBar!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collMovie: UICollectionView!
    
    var arrayFilter = [Product]()
    var arrayProduct = [Product]()
    var booleanSearch = false
    var booleanNowPlaying = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        collMovie.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        menuTabbar.selectedItem = menuTabbar.items![0] as UITabBarItem
       
        DispatchQueue.global().async {
            self.getData(nowPlayingUrl)
        }
    }
}

//MARK:: Delegate and DataSource metod call
extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if booleanSearch {
            return arrayFilter.count
        }
        return arrayProduct.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        
        if booleanSearch {
            cell.lblTitle.text = arrayFilter[indexPath.row].title
            cell.lblDetail.text = arrayFilter[indexPath.row].overview
            let strOfUrl = "\(imgUrl + arrayFilter[indexPath.row].poster_path)"
            guard  let url = URL(string: strOfUrl) else {
                return cell
            }
            cell.imgMovie.downloaded(from: url, contentMode: .scaleToFill)
        }else {
            cell.lblTitle.text = arrayProduct[indexPath.row].title
            cell.lblDetail.text = arrayProduct[indexPath.row].overview
            
            cell.delegate = self
            cell.index = indexPath
            
            let strOfUrl = "\(imgUrl + arrayProduct[indexPath.row].poster_path)"
            guard  let url = URL(string: strOfUrl) else {
                return cell
            }
            cell.imgMovie.downloaded(from: url, contentMode: .scaleToFill)
        }
        return cell
     }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailView(nibName: "MovieDetailView", bundle: nil)
        vc.movieData = arrayProduct[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:: Service Call
extension HomeView {
   fileprivate func getData(_ url: String) {
    
    self.arrayProduct.removeAll()
        getService(url) { (data) in
            if data.isEmpty {
            }
            else {
                  do {
                    let obj = try JSONSerialization.jsonObject(with: data, options: [])
                    if let items = (obj as? NSDictionary)?.value(forKey: "results") {
                        for item in (items as? Array<Any>)!{
                            let productModel = Product.init(item as! [String : Any])
                            self.arrayProduct.append(productModel)
                        }
                        DispatchQueue.main.async {
                            self.collMovie.reloadData()
                        }
                    }
                    }catch(let err) {
                        print(err.localizedDescription)
                    }
            }
        }
    }
}

// MARK:: Search Functionality
extension HomeView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        arrayFilter = arrayProduct.filter({$0.title.lowercased().prefix(searchText.count) == searchText.lowercased() })
        booleanSearch = true
        self.collMovie.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        booleanSearch = false
        
        searchBar.text = ""
        self.collMovie.reloadData()
    }

}

//MARK:: Tab func call
extension HomeView: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        
        if(item.tag == 1) && !booleanNowPlaying {
           // Code for item 1
            print("item 1")
            booleanNowPlaying = true
            booleanSearch = false
            DispatchQueue.global().async {
                self.getData(nowPlayingUrl)
                
            }
        }
        else if(item.tag == 2) && booleanNowPlaying {
           // Code for item 2
            print("item 2")
            booleanNowPlaying = false
            booleanSearch = false
            DispatchQueue.global().async {
                self.getData(topRatedUrl)
            }
        }
    }

}

//MARK:: delegate call
extension HomeView: MovieFlixDelgate {
    func deleteCell(_ index: Int) {
        if booleanSearch {
            arrayFilter.remove(at: index)
        }else {
            arrayProduct.remove(at: index)
        }
        self.collMovie.reloadData()
    }
}
