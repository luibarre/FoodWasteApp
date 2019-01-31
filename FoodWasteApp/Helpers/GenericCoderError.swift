//
//  GenericCoderError.swift
//  FoodWasteApp
//
//  Created by Luigi Barretta on 31/01/2019.
//  Copyright © 2019 UltraVortex. All rights reserved.
//

import Foundation

enum GenericCoderError: Error {
  case invalidURL
  case invalidDataCreation
  case invalidDecode
  case invalidEncode
  case invalidStringCreation
  case invalidWritingToFile
}
