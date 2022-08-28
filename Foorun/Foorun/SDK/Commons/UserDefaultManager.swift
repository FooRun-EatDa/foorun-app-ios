//
//  UserDefaultManager.swift
//  Foorun
//
//  Created by 김지훈 on 2022/08/19.
//

import Foundation
import FoorunKey

class UserDefaultManager {
    static let shared = UserDefaultManager()
    
    private init() { }
    
    @UserDefault(key: FoorunKey.UserDefaultKey.bookmark, defaultValue: [])
    public var bookmarks: [RestaurantDetail]
    
    @UserDefault(key: FoorunKey.UserDefaultKey.usedCoupon, defaultValue: [])
    public var usedCoupons: Set<Int>

    @UserDefault(key: FoorunKey.UserDefaultKey.token, defaultValue: "843168213")
    public var token: String
}

@propertyWrapper
struct UserDefault<T: Codable> {
    private let key: String
    private let defaultValue: T
    public let storage: UserDefaults

    init(key: String, defaultValue: T, storage: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }

    var wrappedValue: T {
        get {
            guard let data = self.storage.object(forKey: key) as? Data else {
                return defaultValue
            }

            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)

            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
