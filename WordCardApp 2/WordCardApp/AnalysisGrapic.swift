//
//  AnalysisGrapic.swift
//  WordCardApp
//
//  Created by User13 on 2019/11/29.
//  Copyright © 2019 00657254. All rights reserved.
//

import SwiftUI

struct AnalysisGrapic: View {
    
    @ObservedObject var wordsData = WordsData()
    @State private var selectedAnalyzeItem = "測驗結果"
    var analyzeItems = ["測驗結果", "各類型統計",]
    var isAdeptAngles: [Angle]
    //var typeWidths: [Double]
    var typeCount: [Double] = [0,0,0]
    
     let color = UIColor(red: 175/255, green: 220/255, blue: 195/255, alpha: 0.3)
    
    init(wordsData: WordsData)
    {
        self.wordsData = wordsData
        
        var totalCount: Double = 0
        
        var isAdeptCount: [Double] = [0,0,0]

        
        for data in wordsData.words
        {
            totalCount += 1
            if data.isAdept ==  0
            {
                isAdeptCount[0] += 1
            }
            else if data.isAdept == 1
            {
                isAdeptCount[1] += 1
            }
            else if data.isAdept == -1
            {
                isAdeptCount[2] += 1
            }
            
            if data.selectedType == "單字"
            {
                typeCount[0] += 1
            }
            else if data.selectedType == "片語"
            {
                typeCount[1] += 1
            }
            else if data.selectedType == "文法"
            {
                typeCount[2] += 1
            }
           
        }
        var isAdeptPercentages: [Double] = [0,0,0]
        isAdeptPercentages[0] = isAdeptCount[0] / totalCount
        isAdeptPercentages[1] = isAdeptCount[1] / totalCount
        isAdeptPercentages[2] = isAdeptCount[2] / totalCount
        isAdeptAngles = [Angle]()
        var isAdeptStartDegree: Double = 0
        for isAdeptPercentages in isAdeptPercentages
        {
            isAdeptAngles.append(.degrees(isAdeptStartDegree))
            isAdeptStartDegree += 360 * isAdeptPercentages
        }
        if isAdeptPercentages[2] == 1.0
        {
            isAdeptAngles[0] = .degrees(360)
        }
    
    
    }
    var body: some View {
        ZStack{
                   Color.init(color)
                   .edgesIgnoringSafeArea(.all)
         GeometryReader
               {
                   geometry in
                   ZStack
                   {
                       Image("analyzeBackground")
                       .resizable()
                       .scaledToFill()
                       .opacity(0.3)
                       .frame(width: geometry.size.width, height: geometry.size.height)
                       .edgesIgnoringSafeArea(.all)
                       VStack
                       {
                           Text("請選擇分析項目：")
                           .padding(EdgeInsets(top: 50, leading: 10, bottom: 0, trailing: 10))
                           Picker(selection: self.$selectedAnalyzeItem, label: Text("請選擇分析項目："))
                           {
                               ForEach(self.analyzeItems, id: \.self)
                               {
                                   (analyzeItem) in
                                   Text(analyzeItem)
                               }
                           }
                           .labelsHidden()
                           .pickerStyle(SegmentedPickerStyle())
                           .padding(20)
                           if self.wordsData.words.count != 0
                           {
                               if self.selectedAnalyzeItem == "測驗結果"
                               {
                                isAdeptPieChart(isAdeptAngles: self.isAdeptAngles)
                               }
                               else if self.selectedAnalyzeItem == "各類型統計"
                               {
                                   typeBarChart(typeWidths: self.typeCount)
                                
                               }
                           }
                           else
                           {
                               Text("暫無資料")
                               .font(Font.system(size:30))
                               .fontWeight(.bold)
                               .foregroundColor(Color.white)
                               .multilineTextAlignment(.center)
                               .frame(width:250, height:250)
                                .background(Color.yellow)
                                .cornerRadius(150)
                                 .shadow(radius: 30)
                               //.overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black))
                           }
                       }
                   }
               }
        }
    }
}

struct AnalysisGrapic_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisGrapic(wordsData: WordsData())
    }
}


struct isAdeptPieChart: View
{
    var isAdeptAngles: [Angle]
    var body: some View
    {
        VStack//(totalHeight:270)
        {
            ZStack//(height:200)
            {
               
                PieChart(startAngle: isAdeptAngles[0], endAngle: isAdeptAngles[1])
                .fill(Color.gray)
                VStack{
                    Rectangle()
                    .fill(Color.gray)
                    .frame(width: 10, height: 10)
                    Text("未測驗")
                }.offset(x:0, y: 150)

                PieChart(startAngle: isAdeptAngles[1], endAngle: isAdeptAngles[2])
                .fill(Color.green)
                
                VStack{
                    Rectangle()
                    .fill(Color.green)
                    .frame(width: 10, height: 10)
                    Text("已熟悉")
                }.offset(x:-150, y: 0)
                
                PieChart(startAngle: isAdeptAngles[2], endAngle: isAdeptAngles[0])
                .fill(Color.red)
                VStack{
                   Rectangle()
                   .fill(Color.red)
                   .frame(width: 10, height: 10)
                   Text("還需練練")
               }.offset(x:150, y: 0)
            }
            .frame(width: 200, height: 200)
            Spacer()//(height:40)
            .frame(height:40)
           // genderIcons()//(height:30)

            /*Form
            {
                boyIcon()
                girlIcon()
                otherIcon()
            }*/
        }
        //.animation(.default)
    }
}

struct typeBarChart: View
{
   
    var typeWidths: [Double]
    var body: some View
    {
        HStack//(totalHeight:270)
        {
            VStack
                {
                    typeText()
                }
                .frame(width: 60, height: 270)
                .padding(EdgeInsets(top: 0, leading: -50, bottom: 0, trailing: 0))
                ZStack(alignment: .leading)
                {
                    Path
                    {
                        (path) in
                        path.move(to: CGPoint(x: 0, y: 20))
                        path.addLine(to: CGPoint(x: 0, y: 270))
                        path.addLine(to: CGPoint(x: 300, y: 270))
                    }
                    .stroke(Color.black, lineWidth: 2)
                    typeBarGroup(typeWidths: typeWidths)
                }
            }
            .frame(width: 300, height: 270)
    }
}
struct typeText: View
{
    var body: some View
    {
        Group
        {
            Text("單字")
           .padding(EdgeInsets(top: 40, leading: -10, bottom: 0, trailing: -40))
            Text("片語")
            .padding(EdgeInsets(top: 40, leading: -10, bottom: 0, trailing: -40))
            Text("文法")
           .padding(EdgeInsets(top: 40, leading: -10, bottom: 0, trailing: -40))
            
        }
    }
}

struct typeBarGroup: View
{
    var typeWidths: [Double]
    var body: some View
    {
        ScrollView(.horizontal){
           VStack(alignment: .leading)
            {
                Group
                {
                        typeBar(finalWidth: typeWidths[0], r: 1, g: 0, b: 0).padding(EdgeInsets(top: 100, leading: 0.5, bottom: 0, trailing: 0))
                        typeBar(finalWidth: typeWidths[1], r: 0, g: 1, b: 0).padding(EdgeInsets(top: 40, leading: 0.5, bottom: 10, trailing: 0))
                        typeBar(finalWidth: typeWidths[2], r: 1, g: 0, b: 1).padding(EdgeInsets(top: 20, leading: 0.5, bottom: 30, trailing: 0))
                            HStack{
                                Group{
                                    ForEach(0..<50){(index) in
                                        Text("\(index)")
                                    }
                                }
                            }
                        }
                    }
         }
    }
        
    
}

struct typeBar: View
{
    var finalWidth: Double
    var r: Double
    var g: Double
    var b: Double
    @State private var width: CGFloat = 0
    var body: some View
    {
       
            Rectangle()
            .fill(Color(red: r, green: g, blue: b))
            .frame(width: width, height: 20)
            .animation(.linear(duration: 1))
            .onAppear
            {
                self.width = CGFloat(self.finalWidth)*20
            }
        
    }
}


struct isAdeptIcon: View{
   var body: some View{
    Text("")
    
    }
}
