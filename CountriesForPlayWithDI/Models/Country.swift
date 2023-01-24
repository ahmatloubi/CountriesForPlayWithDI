//
//  Country.swift
//  CountriesForPlayWithDI
//
//  Created by AmirHossein Matloubi on 11/2/1401 AP.
//

import Foundation

public struct Country: Codable, Identifiable {
    public var id = UUID()
    let name: String
    let capital: String
    let flag: String
}
