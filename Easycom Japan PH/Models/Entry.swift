//
//  Entry.swift
//  Easycom Japan PH
//
//  Created by Michael Angelo Zafra on 1/16/23.
//

import Foundation

struct Entry: Identifiable, Codable {
    var albumId: Int?
    var id: Int?
    var title: String?
    var url: String?
    var thumbnailUrl: String?
}
