//
//  SaveAndReadData.swift
//  TakeYourUmbrella
//
//  Created by Anna on 12.04.2024.
//

import Foundation

class SaveUserDataService {
    
    func saveData<T: Encodable>(element: T, key: String) -> Void {
        do {
            let dataToSave = try? JSONEncoder().encode(element)
            UserDefaults.standard.set(dataToSave, forKey: key)
        }
    }
    
    func readData<T: Decodable>(key: String) -> T? {
        guard let dataToRead = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        do {
            let data = try? JSONDecoder().decode(T.self, from: dataToRead)
            return data
        }
    }
}
