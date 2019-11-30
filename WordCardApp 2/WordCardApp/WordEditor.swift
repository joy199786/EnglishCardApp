//
//  WordEditor.swift
//  WordCardApp
//
//  Created by User13 on 2019/11/24.
//  Copyright © 2019 00657254. All rights reserved.
//

import SwiftUI

struct WordEditor: View {
    @Environment(\.presentationMode) var presentationMode
       var wordsData: WordsData
       @State private var EngName = ""
       @State private var meaning = ""
        @State private var selectedType = ""
        @State private var isAdept = 0
       
        @State private var showNameAlert = false
       var editWord: Word?
       
       var body: some View {
           Form {
               TextField("單字", text: $EngName)
               TextField("定義", text: $meaning)
                profileType(selectedType: self.$selectedType)
               //Toggle("真心", isOn: $trueHeart)
           }
           .navigationBarTitle(editWord == nil ? "Add new word" : "Edit word")
               .navigationBarItems(trailing: Button("Save") {
                
                if (self.EngName == "") || (self.meaning=="") || (self.selectedType == "")
                {
                    self.showNameAlert = true
                }
                else{
                    let word = Word(EngName: self.EngName, meaning: self.meaning,selectedType: self.selectedType, isAdept: self.isAdept)
                       if let editWord = self.editWord {
                           let index = self.wordsData.words.firstIndex {
                               $0.id == editWord.id
                               }!
                           self.wordsData.words[index] = word
                       } else {
                           self.wordsData.words.insert(word, at: 0)
                       }
                       self.presentationMode.wrappedValue.dismiss()
                }
                   
           }
           .alert(isPresented: $showNameAlert)
                  {
                      () -> Alert in
                      return Alert(title: Text("無法儲存!!"), message: Text("輸入不得為空白"))
                  })
               .onAppear {
                   if let editWord = self.editWord {
                       self.EngName = editWord.EngName
                       self.meaning = editWord.meaning
                       self.selectedType = editWord.selectedType
                       self.isAdept = 0
                       
                   }
           }
           
       }
}

struct WordEditor_Previews: PreviewProvider {
    static var previews: some View {
        WordEditor(wordsData: WordsData())
    }
}


struct profileType: View
{
    @Binding var selectedType: String
    var types = ["單字", "片語", "文法"]
    var body: some View
    {
        Picker(selection: $selectedType, label: Text("類型"))
        {
            ForEach(types, id: \.self)
            {
                (type) in
                Text(type)
            }
        }
        //.frame(width: 180)
        .pickerStyle(SegmentedPickerStyle())
    }
}
