//
//  Testing.swift
//  ElectronIQ
//
//  Created by Jeevith  on 05/06/25.
//

import SwiftUI

@ViewBuilder
func enderElementCard(selectedElement:Int)->some View{
    
    ZStack{
        RoundedRectangle(cornerRadius: 10)
            .fill(elementCardColor[selectedElement])
            .frame(width: screenWidth * 0.15,height: screenWidth * 0.15)
        Text(elementsSymbols[selectedElement])
            .font(.custom(atomSymbolFont, size: 32))
            .foregroundColor(contentFontColor)
    }
    .overlay(alignment: .bottom){
        Text(elementsNames[selectedElement])
            .font(.custom(atomSymbolFont, size: 18))
            .foregroundColor(contentFontColor)
            .padding(.bottom,10)
    }
    .overlay(alignment: .topLeading){
        Text("\(elementsNumber[selectedElement])")
            .font(.custom(atomSymbolFont, size: 18))
            .foregroundColor(contentFontColor)
            .padding([.top,.leading],5)
    }
    .overlay(alignment: .topTrailing){
        Text("\(elementsMassNo[selectedElement], specifier: "%.1f")")
            .font(.custom(atomSymbolFont, size: 18))
            .foregroundColor(contentFontColor)
            .padding([.top,.trailing],5 )
    }
}


struct Testing : View {
    @State private var isDrawerOpen = false
    var body: some View {
        NavigationStack{
            ZStack
            {
                enderElementCard(selectedElement: 2)
            }
        }
    }
}
#Preview {
    Testing()
}
