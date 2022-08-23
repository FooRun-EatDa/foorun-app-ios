//
//  Restaurant.swift
//  Foorun
//
//  Created by 김희진 on 2022/07/31.
//
import Foundation

struct Restaurant: Codable {
    let id: Int?
    let name: String?
    let explanation: String?
    let imgUrl: String?
    let distance: Double?
    let hashTags: [String]
    let liked: Bool

    init(
            id: Int?,
            name: String?,
            explanation: String?,
            imgUrl: String?,
            distance: Double?,
            hashTags: [String],
            liked: Bool
        ) {
            self.id = id
            self.name = name
            self.explanation = explanation
            self.imgUrl = imgUrl
            self.distance = distance
            self.hashTags = hashTags
            self.liked = liked
        }
}




// 여기서부터
struct RestaurantList: Codable {
    let id: Int?
    let name: String?
    let explanation: String?
    let imgUrl: String?
    let distance: Double?
    let hashTags: [String]
    let liked: Bool
}

struct RestaurantDetail: Decodable {
    let id: Int
    let name: String
    let explanation: String?
    let imgUrl: String?
    let content: String?
    let address: String?
    let phoneNumber: String?
    let operationTime: String?
    let price: Int
    let district: String?
//    let coordinate: [Coordinate]
    let categories: [String]?
    let foods: [Food]
    let liked: Bool
}

struct Food: Decodable {
    let id: Int
    let name: String
    let price: Int
    let content: String
    let sequence: Int
    let files: [FoodImageModel]
}

struct FoodImageModel: Decodable {
    let url: String?
}

//struct Coordinate: Decodable {
//    let longitude: String
//    let latitude: String
//}

struct RestaurantDetailClientModel: Decodable {
    var name: String?
    var imgUrl: String?
    var price: Int?
    var content: String?
    var address: String?
    var phoneNumber: String?
    var operationTime: String?
    var district: String?
    var liked: Bool?
}


#if DEBUG
extension Restaurant {

    static let bookmarkDummyModel = [
        Restaurant(id: 0, name: "1", explanation: "1", imgUrl: "https://product.cdn.cevaws.com/var/storage/images/_aliases/reference/media/feliway-2017/images/kor-kr/1_gnetb-7sfmbx49emluey4a/6341829-1-kor-KR/1_gNETb-7SfMBX49EMLUeY4A.jpg", distance: 1, hashTags: ["1"], liked: true),
        Restaurant(id: 1, name: "2", explanation: "2", imgUrl: "https://src.hidoc.co.kr/image/lib/2022/5/4/1651651323632_0.jpg", distance: 1, hashTags: ["2"], liked: true),
        Restaurant(id: 2, name: "3", explanation: "3", imgUrl:"https://src.hidoc.co.kr/image/lib/2022/5/12/1652337370806_0.jpg", distance: 1, hashTags: ["3"], liked: true),
        Restaurant(id: 3, name: "4", explanation: "4", imgUrl: "https://dimg.donga.com/ugc/CDB/WEEKLY/Article/5b/b3/22/85/5bb32285000ed2738de6.jpg", distance: 1, hashTags: ["4"], liked: true),
        Restaurant(id: 4, name: "5", explanation: "5", imgUrl: "https://dimg.donga.com/ugc/CDB/WEEKLY/Article/5b/02/77/fa/5b0277fa109dd2738de6.jpg", distance: 1, hashTags: ["5"], liked: true),
        Restaurant(id: 5, name: "6", explanation: "6", imgUrl:"", distance: 1, hashTags: ["6"], liked: true),
        Restaurant(id: 6, name: "7", explanation: "7", imgUrl: "https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/202204/07/ec091f75-0961-49f8-bd9e-f8f2e64674f5.jpg", distance: 1, hashTags: ["7"], liked: true),
        Restaurant(id: 7, name: "8", explanation: "8", imgUrl: "https://thumbnail.10x10.co.kr/webimage/image/basic600/450/B004502565.jpg?cmd=thumb&w=400&h=400&fit=true&ws=false", distance: 1, hashTags: ["8"], liked: true),
        Restaurant(id: 8, name: "9", explanation: "9", imgUrl:"", distance: 1, hashTags: ["9"], liked: true),]

}
#endif
