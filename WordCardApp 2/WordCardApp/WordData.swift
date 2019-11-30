//
//  WordData.swift
//  WordCardApp
//
//  Created by User13 on 2019/11/24.
//  Copyright © 2019 00657254. All rights reserved.
//

import Foundation

class WordsData: ObservableObject{
    
    @Published var words = [Word](){
        didSet{
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(words){
                UserDefaults.standard.set(data, forKey:"words")
            }
        }
    }
    
    init(){
        if let data =
            UserDefaults.standard.data(forKey:"words"){
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([Word].self, from:data){
                words = decodedData
            }
        }
    }
    
}
