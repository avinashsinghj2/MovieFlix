
import Foundation

let baseUrl = "https://api.themoviedb.org/"
let nowPlayingUrl = "\(baseUrl)3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
let topRatedUrl = "\(baseUrl)3/movie/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
let imgUrl = "https://image.tmdb.org/t/p/w342/"


// MARK:: GET SERVICE CALL
func getService(_ strUrl: String, compilation: @escaping (Data) -> Void) {
   guard let url = URL(string: strUrl)
    else {
     compilation(Data.init())
     return
    }
   
  let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
    if let error = error {
      print("Error with fetching product: \(error)")
      return
    }
    compilation(data ?? Data.init())
  })
  task.resume()
}

