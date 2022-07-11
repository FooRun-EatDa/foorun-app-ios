//
//  AnnotationView.swift
//  Foorun
//
//  Created by 김나희 on 7/11/22.
//

import MapKit

class AnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        didSet {
            setupLayout()
        }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        guard let annotation = annotation as? Annotation else {
            return
        }
        
        switch annotation.type {
        case .red:
            self.image = UIImage(named: "redAnnotation")!
        case .yellow:
            self.image = UIImage(named: "yellowAnnotation")!
        }
    }
}
