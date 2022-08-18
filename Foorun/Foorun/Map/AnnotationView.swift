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
            updateAnnotation()
        }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AnnotationView {
    func updateAnnotation() {
        guard let annotation = annotation as? Annotation else { return }
        annotation.isSelected = !annotation.isSelected
        self.canShowCallout = false
    
        switch annotation.type {
        case .red:
            self.image = annotation.isSelected ? UIImage(named: "selectRedAnnotation")! : UIImage(named: "redAnnotation")!
        case .yellow:
            self.image = annotation.isSelected ? UIImage(named: "selectYellowAnnotation")! : UIImage(named: "yellowAnnotation")!
        }
    }
}