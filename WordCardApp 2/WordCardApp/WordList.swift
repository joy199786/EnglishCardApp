//
//  WordList.swift
//  WordCardApp
//
//  Created by User13 on 2019/11/24.
//  Copyright © 2019 00657254. All rights reserved.
//

import SwiftUI

struct WordList: View {
    
    @ObservedObject var wordsData = WordsData()
    @State private var showEditWord = false
    let color = UIColor(red: 102/255, green: 255/255, blue: 230/255, alpha: 0.3)
    var body: some View {
        print("update WordList")
        return NavigationView{
           
            List{
                ForEach(wordsData.words){ (word) in
                    NavigationLink(destination: WordEditor(wordsData: self.wordsData, editWord: word)){
                        WordRow(word: word)
                    }
                }
                .onMove { (indexSet, index) in
                        self.wordsData.words.move(fromOffsets: indexSet,
                                        toOffset: index)
                    }
                .onDelete{(IndexSet) in
                    self.wordsData.words.remove(atOffsets: IndexSet)
                    
                }
                .listRowBackground(Color.init(color))
            
            }
            .navigationBarTitle("單字列表")
            .navigationBarItems(leading: EditButton(), trailing: Button(action:{
                
                self.showEditWord = true
                
            }, label: {
                Image(systemName: "plus.circle.fill")
                
            })).sheet(isPresented: $showEditWord){
                NavigationView{
                    WordEditor(wordsData:self.wordsData)
                }
            }
        }

    }
}

struct WordList_Previews: PreviewProvider {
    static var previews: some View {
        WordList(wordsData: WordsData())
    }
}
