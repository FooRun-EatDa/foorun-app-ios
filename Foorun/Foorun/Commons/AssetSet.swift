//
//  AssetSet.swift
//  Foorun
//
//  Created by Hamlit Jason on 2022/08/28.
//

import Foundation

struct AssetSet {
    /// 탭바 아이템
    struct TabBarItem {
        private static let `default`: String = "TabbarItem"
        
        static let bookmark = "\(`default`)/bookmark"
        static let event = "\(`default`)/event"
        static let home = "\(`default`)/home"
        static let my = "\(`default`)/my"
    }
    
    struct Map {
        private static let `default`: String = "Map"
        
        /// 현재 위치 이미지 뷰
        static let current = "\(`default`)/current"
        
        /// 어노테이션
        struct Annotation {
            private static let `default`: String = "\(Map.default)/Annotation"
            
            static let red = "\(`default`)/red"
            static let yellow = "\(`default`)/yellow"
            static let redDidSelect = "\(`default`)/red.select"
            static let yellowDidSelect = "\(`default`)/yellow.select"
        }
    }
    
    /// 이벤트
    struct Event {
        private static let `default`: String = "Event"
        
        static let empty = "\(`default`)/empty"
        
        /// 스탬프
        struct Stamp {
            private static let `default`: String = "\(Event.default)/Stamp"
            
            /// 선착순이 마감한 쿠폰
            static let ended = "\(`default`)/ended"
            /// 기간이 만료된 쿠폰
            static let expired = "\(`default`)/expired"
            /// 이미 사용한 쿠폰
            static let used = "\(`default`)/used"
        }
    }
    
    /// 앱 아이콘에 관련한 부분
    struct Icon {
        private static let `default`: String = "Icon"
        
        static let heart = "\(`default`)/heart"
        static let heartFill = "\(`default`)/heart.fill"
    }
    
    /// 기타이미지 셋
    struct ETC {
        private static let `default`: String = "ETC"
        
        struct Food {
            private static let `default`: String = "\(ETC.default)/Food"
            
            static let empty = "\(`default`)/empty"
        }
    }
}

