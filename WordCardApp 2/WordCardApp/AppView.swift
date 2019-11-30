//
//  AppView.swift
//  WordCardApp
//
//  Created by User13 on 2019/11/24.
//  Copyright © 2019 00657254. All rights reserved.
//

import SwiftUI

struct AppView: View {
    @ObservedObject var wordsData = WordsData()
    var body: some View {
        
         TabView{
            WordList(wordsData: self.wordsData).tabItem {
                       Image(systemName: "text.aligncenter")
                       Text("列表")
                   }
            WordTset(wordsData: self.wordsData).tabItem {
                     Image(systemName: "circle.grid.hex.fill")
                     Text("測驗")
                  }
            AnalysisGrapic(wordsData: self.wordsData).tabItem {
                    Image(systemName: "rectangle.expand.vertical")
                    Text("分析")
                  }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
