//
//  MapWorker.swift
//  Foorun
//
//  Created by 김나희 on 9/28/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

import Alamofire
import FoorunKey

final class MapWorker {
    func fetchAnnotations(latitude: Double,
                          longitude: Double,
                          completion: @escaping ([Annotation]) -> Void) {
        
        let body: Parameters = ["latitude": latitude,
                                "longitude": longitude]
        
        API<[Annotation]>(requestString: FoorunRequest.Restaurant.top,
                          method: .post,
                          parameters: body).fetch { result in
            guard let data = result.data else { return }
            completion(data)
        }
    }
}
