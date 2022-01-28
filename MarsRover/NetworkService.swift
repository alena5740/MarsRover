//
//  NetworkService.swift
//  MarsRover
//
//  Created by Алена on 13.10.2021.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func updateInterface( _: NetworkService, with model: Model)
}

class NetworkService {
    
    var delegatNetworkService: NetworkServiceProtocol?
    
    // переделать completion в Result
    func getData(earthDate: String, camera: String, completion: @escaping (Model) -> Void) {
        let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=\(earthDate)&camera=\(camera)&api_key=ekczuyLpr5KFjvI9kwWa8pygVo0I5XNciULp82eY"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let model = self.parseJSON(data: data) {
                    self.delegatNetworkService?.updateInterface(self, with: model)
                    DispatchQueue.main.async {
                        completion(model)
                    }
                }
            }
        }.resume()
    }
    
    func parseJSON(data: Data) -> Model? {
        let decoder = JSONDecoder()
        do {
            let resultData = try decoder.decode(ModelListed.self, from: data)
            let model = Model(modelListed: resultData)
            return model
        } catch {
            print("Ошибочка в парсинге данных")
        }
        return nil
    }
}
