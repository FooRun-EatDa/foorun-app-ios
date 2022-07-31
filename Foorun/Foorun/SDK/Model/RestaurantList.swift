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
