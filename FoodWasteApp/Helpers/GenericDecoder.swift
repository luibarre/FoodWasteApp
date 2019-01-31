//
//  GenericDecoder.swift
//  FoodWasteApp
//
//  Created by Luigi Barretta on 31/01/2019.
//  Copyright © 2019 UltraVortex. All rights reserved.
//

enum FileNames: String {
  case Levels = "Levels"
  case SaveSessions = "SaveSessions"
}

import Foundation

class GenericCoder {
  static func decodeFromFile<T: Decodable>(withName name: FileNames) throws -> T? {
    
    if let url = Bundle.main.url(forResource: name.rawValue, withExtension: "json") {
      print("JSON.url: \(url.absoluteString)")
      do {
        let data = try Data(contentsOf: url)
        
        do {
          let jsonData = try JSONDecoder().decode(T.self, from: data)
          return jsonData
          
        } catch {
          throw GenericCoderError.invalidDecode
        }
      } catch {
        throw  GenericCoderError.invalidDataCreation
      }
    }
    throw GenericCoderError.invalidURL
  }
  
  static func encodeInFile<T: Encodable>(withName name: FileNames, andCollection collection: T) throws {
    
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    
    do {
      let jsonData = try encoder.encode(collection)
      if let jsonString = String(data: jsonData, encoding: .utf8) {
        
        let filename = "\(name.rawValue).json"
        let fileURL = GenericCoder().getDocumentsDirectory().appendingPathComponent(filename)
        
        do {
          try jsonString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
          print("scritto")
        } catch {
          throw GenericCoderError.invalidWritingToFile
        }
        
      } else {
        throw GenericCoderError.invalidStringCreation
      }
      
    }
    catch {
      throw GenericCoderError.invalidEncode
    }
  }
  
  private func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
  static func encodeObjToJSON(withName fileName: FileNames, withCollection collection: Data){
    
    do {
      let jsonEncoder = JSONEncoder()
      let jsonData = try jsonEncoder.encode(collection)
      let jsonString = String(data: jsonData, encoding: .utf8)
      print(jsonString as Any)
    } catch {
      print("Unexpected error: \(error).")
    }
    
  }
  
}

extension Encodable {
  func jsonData() -> Data? {
    return try? JSONEncoder().encode(self)
  }
}

