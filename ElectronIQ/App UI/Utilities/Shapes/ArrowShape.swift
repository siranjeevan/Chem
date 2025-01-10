//
//  ArrowShape.swift
//  H3'sChemistryApp
//
//  Created by shamtech07 on 10/11/24.
//
import SwiftUI
struct ArrowShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Arrow shaft
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        
        // Arrow head
        path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX - 20, y: rect.midY - 10))
        path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX - 20, y: rect.midY + 10))
        
        return path
    }
}

struct ShapeProvider:PreviewProvider{
    static var previews: some View{
        PreciseAnimatedArrow(color: .red, radius: 30, arrowWidth: 100, shellSymbol: "S")
    }
}
struct DottedArrow:View {
    var body: some View {
        ArrowShape()
        .stroke(style: StrokeStyle(lineWidth: 2, dash: [3]))
                        .foregroundColor(.gray)
                        .frame(width: 70, height: 1,alignment:.bottomTrailing)
    }
}
struct AnimatedArrow: View {
    @State private var trimAmount: CGFloat = 0.0
    @State private var showText = false
    let color:Color
    let arrowRotation:Int
    let textRotation:Int
    let arrowWidth:CGFloat
    let shellSymbol:String
    var body: some View {
            HStack(spacing: 0) {
                ArrowShape()
                    .trim(from: 0, to: trimAmount)
                    .stroke(color, lineWidth: 2)
                    .frame(width: arrowWidth)
                    .onAppear() {
                        withAnimation(Animation.easeInOut(duration: 2)) {
                            trimAmount = 1.0
                        }
                        
                        // More precise timing control
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.spring()) {
                                showText = true
                            }
                        }
                    }
                
                
                ZStack{
                    Circle().fill(color).frame(width: 35)
                    Text(shellSymbol)
                        .font(.custom(atomSymbolFont, size: 24))
                        .foregroundColor(.white)
                        .rotationEffect(Angle(degrees: Double(textRotation)),anchor: .center)
                }
//                .shadow(color:isShadow ? color:.clear,radius: 10)
                .opacity(showText ? 1:0)
                
                
            }
            .rotationEffect(Angle.degrees(Double(arrowRotation)),anchor: .leading)
        }
    }


struct PreciseAnimatedArrow: View {
    let color: Color
    let radius: CGFloat
    let arrowWidth: CGFloat
    let shellSymbol: String
    
    // Angle calculation parameters
    let totalAngle: Double = 180 // Total angle span
    let leftDivisions: Int = 5   // Number of divisions on left side
    let rightDivisions: Int = 4  // Number of divisions on right side
    
    var body: some View {
        ZStack {
            // Left side arrows (4 points out of 5 divisions)
            ForEach(1..<5) { index in
                let leftAngle = calculateLeftAngle(for: index)
                AnimatedArrow(
                    color: color,
                    arrowRotation: Int(leftAngle),
                    textRotation: Int(-leftAngle),
                    arrowWidth: arrowWidth,
                    shellSymbol: shellSymbol
                )
                .offset(
                    x: calculateXOffset(angle: leftAngle, radius: radius),
                    y: calculateYOffset(angle: leftAngle, radius: radius)
                )
            }
            
            // Right side arrows (3 points out of 4 divisions)
            ForEach(1..<4) { index in
                let rightAngle = calculateRightAngle(for: index)
                AnimatedArrow(
                    color: color,
                    arrowRotation: Int(rightAngle),
                    textRotation: Int(-rightAngle),
                    arrowWidth: arrowWidth,
                    shellSymbol: shellSymbol
                )
                .offset(
                    x: calculateXOffset(angle: rightAngle, radius: radius),
                    y: calculateYOffset(angle: rightAngle, radius: radius)
                )
            }
        }
    }
    
    // Calculate angle for left side arrows
    func calculateLeftAngle(for index: Int) -> Double {
        let segmentWidth = totalAngle / Double(leftDivisions)
        return 90 - (Double(index) * segmentWidth)
    }
    
    // Calculate angle for right side arrows
    func calculateRightAngle(for index: Int) -> Double {
        let segmentWidth = totalAngle / Double(rightDivisions)
        return 90 + (Double(index) * segmentWidth)
    }
    
    // Calculate X offset based on angle and radius
    func calculateXOffset(angle: Double, radius: CGFloat) -> CGFloat {
        return radius * CGFloat(cos(angle * .pi / 180))
    }
    
    // Calculate Y offset based on angle and radius
    func calculateYOffset(angle: Double, radius: CGFloat) -> CGFloat {
        return radius * CGFloat(sin(angle * .pi / 180))
    }
}
