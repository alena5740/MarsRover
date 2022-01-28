//
//  Model.swift
//  MarsRover
//
//  Created by Алена on 13.10.2021.
//

import Foundation

class Model {
    let sol: Int?
    let cameraName: String?
    let cameraFullName: String?
    let earthDate: String?
    let imageMars: String?
    
    init(modelListed: ModelListed) {
        self.sol = modelListed.photos.first?.sol
        self.cameraName = modelListed.photos.first?.camera.name
        self.cameraFullName = modelListed.photos.first?.camera.fullName
        self.earthDate = modelListed.photos.first?.earthDate
        self.imageMars = modelListed.photos.first?.imgSrc
    }
}

struct ModelListed: Codable {
    let photos: [Photo]
}

struct Photo: Codable {
    let sol: Int
    let camera: Camera
    let imgSrc: String
    let earthDate: String
    
    enum CodingKeys: String, CodingKey {
        case sol
        case camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
    }
}

struct Camera: Codable {
    let name: String
    let fullName: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
    }
}
