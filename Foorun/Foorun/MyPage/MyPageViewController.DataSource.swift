//
//  MyPageViewController.DataSource.swift
//  Foorun
//
//  Created by 김지훈 on 2022/09/14.
//

import UIKit

extension MyPageViewController {
    enum MyPageSection: Hashable {
        case main, menu
    }
    enum MyPageItem: Hashable {
        case main(MyPageMainViewModel)
        case menu(MyPageMenuViewModel)
    }
    
}
