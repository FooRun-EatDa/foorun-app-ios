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

struct RestaurantDetail: Codable {
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

struct Food: Codable {
    let id: Int
    let name: String
    let price: Int
//    let content: String
    let sequence: Int
    let files: [FoodImageModel]
}

struct FoodImageModel: Codable {
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
