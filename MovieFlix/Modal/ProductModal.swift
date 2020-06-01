
import Foundation

struct  Product {
    var popularity              : Double
    var vote_count              : Int
    var video                   : Bool
    var poster_path             : String
    var id                      : Int
    var adult                   : Bool
    var backdrop_path           : String
    var original_language       : String
    var original_title          : String
    var title                   : String
    var vote_average            : Double
    var overview                : String
    var release_date            : String
    
    init(_ responseData: [String : Any]) {
        self.popularity = responseData["popularity"] as? Double  ?? 0.0
        self.vote_count = responseData["vote_count"] as? Int ?? 0
        self.video = responseData["video"] as? Bool ?? false
        self.poster_path = responseData["poster_path"] as? String ?? ""
        self.id = responseData["id"] as? Int  ?? 0
        self.adult = responseData["adult"] as? Bool ?? false
        self.backdrop_path = responseData["backdrop_path"] as? String ?? ""
        self.original_language = responseData["original_language"] as? String ?? ""
        self.original_title = responseData["original_title"] as? String ?? ""
        self.title = responseData["title"] as? String ?? ""
        self.vote_average = responseData["vote_average"] as? Double ?? 0.0
        self.overview = responseData["overview"] as? String ?? ""
        self.release_date = responseData["release_date"] as? String ?? ""
    }
}
