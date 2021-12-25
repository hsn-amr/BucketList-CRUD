//
//  Json Formatter.swift
//  Bucket
//
//  Created by administrator on 24/12/2021.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let id: Int
    let objective, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, objective
        case createdAt = "created_at"
    }
}

typealias Welcome = [WelcomeElement]
