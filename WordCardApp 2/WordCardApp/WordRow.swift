//
//  WordRow.swift
//  WordCardApp
//
//  Created by User13 on 2019/11/24.
//  Copyright © 2019 00657254. All rights reserved.
//

import SwiftUI

struct WordRow: View {
    
    var word : Word
    
    var body: some View {
        
            HStack {
                if word.selectedType == "單字"{
                    VStack{
                       Group{
                           Image(systemName:"wonsign.circle.fill").font(.system(size: 20))
                           Text("單字").font(.system(size: 12))
                       }
                   .padding(-2)
                       .foregroundColor(.yellow)
                   }
                }
                else if word.selectedType == "片語"{
                    VStack{
                        Group{
                            Image(systemName:"book.fill").font(.system(size: 20))
                            Text("片語").font(.system(size: 12))
                        }
                    .padding(-2)
                        .foregroundColor(.purple)
                    }
                }
                else if word.selectedType == "文法"{
                    VStack{
                        Group{
                            Image(systemName:"dongsign.square.fill").font(.system(size: 20))
                            Text("文法").font(.system(size: 12))
                        }
                    .padding(-2)
                        .foregroundColor(.orange)
                    }
                }
                //Spacer()
                Text(word.EngName)
                Spacer()
                if word.isAdept == 0{
                    Image(systemName:"star.fill").foregroundColor(.gray)
                }
                else if word.isAdept == -1
                {
                    Image(systemName:"star.fill").foregroundColor(.red)
                }
                else if word.isAdept == 1
                {
                    Image(systemName:"star.fill").foregroundColor(.green)
                }
                
                //type
            }
    }
}

struct WordRow_Previews: PreviewProvider {
    static var previews: some View {
        WordRow(word: Word(EngName: "apple", meaning: "蘋果",selectedType:"單字", isAdept: 0))
    }
}
