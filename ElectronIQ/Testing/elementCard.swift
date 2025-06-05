//
//  elementCard.swift
//  ElectronIQ
//
//  Created by Jeevith  on 05/06/25.
//

import Foundation
import SwiftUI

@ViewBuilder
func elementCard(index:Int)->some View{
    ZStack{
        RoundedRectangle(cornerRadius: 5)
            .fill(elementCardColor[index])
            .frame(width:isIPhone ? screenWidth * 0.045:screenWidth * 0.055,height:isIPhone ? screenWidth * 0.045:screenWidth * 0.055)
        Text(elementsSymbols[index])
            .font(.system(size:isIPhone ? 14:18))
            .foregroundColor(.white).bold()

    }
    .overlay(alignment:.topLeading){
        Text("\(elementsNumber[index])")
            .font(.system(size:isIPhone ? 7:10))
            .padding([.leading,.top],3)
            .foregroundColor(.white)
    }
    .overlay(alignment:.topTrailing){
        Text(String(format: "%.1f", elementsMassNo[index]))
            .font(.system(size:isIPhone ? 7:10))
            .padding([.trailing,.top],3)
            .foregroundColor(.white)
            
    }
    .overlay(alignment: .bottom){
        Text(elementsNames[index])
            .font(.system(size:isIPhone ? 7:11))
            .foregroundColor(.white)
            .lineLimit(1)
    }
}
