//
//  Network View.swift
//  H3'sChemistryApp
//
//  Created by shamtech07 on 28/11/24.
//

import SwiftUI

struct noNetwork_View: View {
    var body: some View {
        ZStack{
            AppBackground()
            HStack(){
                Image(noNetworkImage)
                  .resizable()
                 .scaledToFit()
                VStack{
                    Text("Error Occured In Connection")
                        .font(.title)
                }
                .padding()
            }
            .padding()
        }
    }
}

#Preview {
    noNetwork_View()
}
