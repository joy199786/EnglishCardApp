//
//  WordTset.swift
//  WordCardApp
//
//  Created by User13 on 2019/11/24.
//  Copyright © 2019 00657254. All rights reserved.
//

import SwiftUI

struct WordTset: View {

    @ObservedObject var wordsData = WordsData()
    @State var testStart = false
    @State var showMeanButton = false
    @State var showMeaning = false
    @State var showIsAdept = false
    @State var showNextButton = false
    @State var showStartButton = true
    @State var indexWord = 0
    @State var showStartAlert = false
    
    let color = UIColor(red: 175/255, green: 220/255, blue: 195/255, alpha: 0.3)
    var body: some View {
        ZStack{
            Color.init(color)
            .edgesIgnoringSafeArea(.all)
            
            if showStartButton{
                Button("開始練習"){
                    if self.wordsData.words.count == 0 {
                        self.showStartAlert = true
                    }
                    else{
                    self.testStart = true
                     self.showMeanButton = true
                    self.showStartButton = false
                    }
                }.font(.system(size: 30))
                    .padding(5)
                .background(Color.yellow)
                .foregroundColor(.black)
                    .cornerRadius(10.0)
                .position(x: 200, y: 350)
                .alert(isPresented: $showStartAlert)
                       {
                           () -> Alert in
                           return Alert(title: Text("目前列表內無項目!!"), message: Text("請至列表輸入項目"))
                }
                
            }
            
            else{
                if testStart{
                    Text(wordsData.words[indexWord].EngName)
                    .font(.system(size: 50))
                    .padding()
                    .position(x: 200, y: 300)
            
                    if  showMeanButton{
                        Button("顯示答案"){
                           self.showMeaning = true
                           self.showIsAdept = true
                            self.showMeanButton = false
                        }.padding(5).background(Color.yellow)
                            .font(.system(size: 24))
                        .position(x: 200, y: 650)
                    }
                    
                    if showMeaning{
                        
                    Text("------------------------------")
                    .position(x: 200, y: 340)
                        .padding(0)
                    Text(wordsData.words[indexWord].meaning)
                    .font(.system(size: 24))
                    .padding(25)
                    .position(x: 200, y: 370)
                        
                    }
                    
                    if showIsAdept{
                        Button("已熟練"){
                            self.wordsData.words[self.indexWord].isAdept = 1
                            self.showIsAdept = false
                            self.showNextButton = true
                            if self.indexWord + 1 == self.wordsData.words.count{
                                self.showNextButton = false
                            }
                        }.padding(5).background(Color.green)
                            .foregroundColor(.black)
                            .font(.system(size: 24))
                        .position(x: 150, y: 650)
                        Button("還需練練"){
                            self.wordsData.words[self.indexWord].isAdept = -1
                            self.showIsAdept = false
                            self.showNextButton = true
                            if self.indexWord + 1 == self.wordsData.words.count{
                                self.showNextButton = false
                            }
                        }.padding(5).background(Color.red)
                            .foregroundColor(.black)
                            .font(.system(size: 24))
                        .position(x: 250, y: 650)
                        
                        
                    }
                
                    if showNextButton
                    {
                        Button("下一個"){
                            self.indexWord = self.indexWord + 1
                            
                            self.showMeaning = false
                             self.showMeanButton = true
                            self.showNextButton = false
                        }.padding(5).background(Color.green)
                            .font(.system(size: 24))
                        .position(x: 200, y: 650)
                    }
                }
            }
            
            Button("重新開始"){
                 self.showStartButton = true
                 self.indexWord = 0
                 self.showIsAdept = false
                self.showNextButton = false
                self.showMeaning = false
            }.position(x: 200, y: 700)
                .font(.system(size: 30))
            
        }
    }
}

struct WordTset_Previews: PreviewProvider {
    static var previews: some View {
        WordTset(wordsData: WordsData())
    }
}
