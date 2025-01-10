//
//  LineShape.swift
//  H3'sChemistryApp
//
//  Created by shamtech07 on 15/11/24.
//
import SwiftUI
struct LineShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}

// Example Usage View
struct DottedLine: View {
    var body: some View {
            // Horizontal Line
            LineShape()
            .stroke(style: StrokeStyle(lineWidth: 2, dash: [3]))
                            .foregroundColor(.gray)
                            .frame(width: 50, height: 1)
    }
}

#Preview {
    DottedLine()
}
