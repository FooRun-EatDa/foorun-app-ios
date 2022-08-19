//
//  RestaurantList.swift
//  Foorun
//
//  Created by 김희진 on 2022/07/31.
//
import Foundation

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
    let url: String
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
