//
//  RestaurantAnnotationView.swift
//  Foorun
//
//  Created by 김나희 on 7/11/22.
//

import MapKit

class RestaurantAnnotationView: MKAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = "restaurant"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        canShowCallout = false
        
        guard let annotation = annotation as? DisplayedAnnotation else { return }
        
        switch annotation.type {
        case .yellow:
            image = UIImage(named: AssetSet.Map.Annotation.yellow)
        case .red:
            image = UIImage(named: AssetSet.Map.Annotation.red)
        }
    }
    
    func updateAnnotation() {
        guard let annotation = annotation as? DisplayedAnnotation else { return }
        annotation.isSelected = !annotation.isSelected

        switch annotation.type {
        case .yellow:
            image = annotation.isSelected
            ? UIImage(named: AssetSet.Map.Annotation.yellowDidSelect)
            : UIImage(named: AssetSet.Map.Annotation.yellow)
        case .red:
            image = annotation.isSelected
            ? UIImage(named: AssetSet.Map.Annotation.redDidSelect)
            : UIImage(named: AssetSet.Map.Annotation.red)
        }
    }
}
