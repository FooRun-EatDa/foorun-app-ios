//
//  CusterAnnotationView.swift
//  Foorun
//
//  Created by 김나희 on 11/6/22.
//

import MapKit

class ClusterAnnotationView: MKAnnotationView {
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        addSubview(countLabel)
        layer.masksToBounds = true
        layer.cornerRadius = bounds.width / 2
        backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        drawClusterCount()
    }
    
    private func drawClusterCount() {
        guard let annotation = annotation as? MKClusterAnnotation else { return }
        
        var defaultDiameter = 100.0
        let count = annotation.memberAnnotations.count
        
        switch count {
        case _ where count < 8:
            defaultDiameter *= 0.6
        case _ where count < 16:
            defaultDiameter *= 0.8
        default:
            break
        }
        
        self.frame = CGRect(origin: frame.origin, size: CGSize(width: defaultDiameter, height: defaultDiameter))
        countLabel.frame = bounds
        countLabel.text = "\(count)"
    }

}
