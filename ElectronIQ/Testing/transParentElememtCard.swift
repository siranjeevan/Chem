//
//  transParentElememtCard.swift
//  ElectronIQ
//
//  Created by Jeevith  on 05/06/25.
//

import Foundation
import SwiftUI

func transparentElementCard()->some View{
    ZStack{
        RoundedRectangle(cornerRadius: 4)
            .fill(.clear)
            .frame(width:isIPhone ? screenWidth * 0.045:screenWidth * 0.055,height:isIPhone ? screenWidth * 0.045:screenWidth * 0.055)
    }
}
