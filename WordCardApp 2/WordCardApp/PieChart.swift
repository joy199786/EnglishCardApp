//
//  PieChart.swift
//  WordCardApp
//
//  Created by User13 on 2019/11/29.
//  Copyright © 2019 00657254. All rights reserved.
//

import Foundation
import SwiftUI

struct PieChart: Shape
{
    var startAngle: Angle
    var endAngle: Angle
    func path(in rect: CGRect) -> Path
    {
        Path
        {
            (path) in
            let center = CGPoint(x: rect.midX, y: rect.midY)
            path.move(to: center)
            path.addArc(center: center, radius: rect.midX, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        }
    }
}
