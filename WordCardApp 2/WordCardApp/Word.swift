//
//  Word.swift
//  WordCardApp
//
//  Created by User13 on 2019/11/24.
//  Copyright © 2019 00657254. All rights reserved.
//

import Foundation


struct Word: Identifiable, Codable {
    var id = UUID()
    var EngName: String
    var meaning: String
    var selectedType: String
    var isAdept: Int //not sure: 3 States
}
