//
//  MarsPhotoView.swift
//  MarsRover
//
//  Created by Алена on 12.10.2021.
//

import UIKit

final class MarsPhotoView: UIView {
    
    private let photoMars = UIImageView()
    private let roverNameLabel = UILabel()
    private let roverFullNameLabel = UILabel()
    private let dateEarthLabel = UILabel()
    private let solMarsLabel = UILabel()
    
    private var model: Model?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPhotoMars()
        setupRoverNameLabel()
        setupRoverFullNameLabel()
        setupDateEarthLabel()
        setupSolMarsLabel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraintsPhotoMars() {
        photoMars.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoMars.topAnchor.constraint(equalTo: self.topAnchor, constant: boundsDevices.height / 7),
            photoMars.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            photoMars.widthAnchor.constraint(equalToConstant: boundsDevices.width - 32),
            photoMars.heightAnchor.constraint(equalToConstant: (boundsDevices.width - 32) * 1.33)
        ])
    }
    
    private func setupPhotoMars() {
        self.addSubview(photoMars)
        photoMars.contentMode = .scaleAspectFill
        makeConstraintsPhotoMars()
    }
    
    private func setupLabels(label: UILabel) {
        self.addSubview(label)
        
        label.textAlignment = .center
        label.textColor = .darkGray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            label.widthAnchor.constraint(equalToConstant: boundsDevices.width - 32)
        ])
    }
    
    private func makeConstraintsDateEarthLabel() {
        NSLayoutConstraint.activate([
            dateEarthLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: (boundsDevices.height / 7) + ((boundsDevices.width - 32) * 1.33) + 30),
            dateEarthLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupDateEarthLabel() {
        setupLabels(label: dateEarthLabel)
        makeConstraintsDateEarthLabel()
    }
    
    private func makeConstraintsSolMarsLabel() {
        NSLayoutConstraint.activate([
            solMarsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: (boundsDevices.height / 7) + ((boundsDevices.width - 32) * 1.33) + 60),
            solMarsLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupSolMarsLabel() {
        setupLabels(label: solMarsLabel)
        makeConstraintsSolMarsLabel()
    }
    
    private func makeConstraintsRoverNameLabel() {
        NSLayoutConstraint.activate([
            roverNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: (boundsDevices.height / 7) + ((boundsDevices.width - 32) * 1.33) + 90),
            roverNameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupRoverNameLabel() {
        setupLabels(label: roverNameLabel)
        makeConstraintsRoverNameLabel()
    }
    
    private func makeConstraintsRoverFullNameLabel() {
        NSLayoutConstraint.activate([
            roverFullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: (boundsDevices.height / 7) + ((boundsDevices.width - 32) * 1.33)  + 120),
            roverFullNameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupRoverFullNameLabel() {
        setupLabels(label: roverFullNameLabel)
        roverFullNameLabel.lineBreakMode = .byWordWrapping
        roverFullNameLabel.numberOfLines = 0
        makeConstraintsRoverFullNameLabel()
    }
    
    func configure(model: Model) {
        self.model = model
        dateEarthLabel.text = "Земная дата: \(model.earthDate ?? "")"
        solMarsLabel.text = "Сол на Марсе: \(model.sol ?? 0)"
        roverNameLabel.text = "Марсоход: \(model.cameraName ?? "")"
        roverFullNameLabel.text = "Полное имя марсохода:\n"
            + "\(model.cameraFullName ?? "")"
        photoMars.loadImage(imageString: model.imageMars ?? "")
    }
}
