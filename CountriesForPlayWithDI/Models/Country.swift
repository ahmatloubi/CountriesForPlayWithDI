//
//  Country.swift
//  CountriesForPlayWithDI
//
//  Created by AmirHossein Matloubi on 11/2/1401 AP.
//

import Foundation

struct Countries: Codable, Identifiable {
    var id = UUID()
    let string: String
}
