import SwiftUI

// Example usage of the ContactInfoView with actual data
struct ContentViewdd: View {
    @State var selectedElement:Int = 102
    var body: some View {
        VStack{
            Grid(horizontalSpacing: 10){
                GridRow{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(elementCardColor[selectedElement], style: StrokeStyle(lineWidth: 3))
                        .frame(width: screenWidth * 0.275,height: screenWidth * 0.175)
                        .overlay{
                            HStack{
                                renderElementCard(selectedElement: 102)
                                ScalableImageView(imgName: "H_Img")
                            }
                            .scaleEffect(0.8)
                        }
                    RoundedRectangle(cornerRadius: 10)
                        .fill(elementCardColor[selectedElement])
                        .frame(width: screenWidth * 0.275,height: screenWidth * 0.175)
                        .overlay(alignment: .top){
                            VStack{
                                Text("Element Detail")
                                    .font(.custom(atomSymbolFont, size: 14))
                                Divider()
                                    .frame(width:screenWidth*0.27,height: 2)
                                    .overlay(.blackFont)
                                   
                                    
                                ScrollView {
                                    VStack(spacing: 10) { // Content inside ScrollView
                                        let Headings: [String] = ["Element Name", "Element Symbol", "Group","Period","Block","Electronic Configuration","Melting Point","Density","Oxidation State"]
                                        let content = [
                                            elementsNames, elementsSymbols, groups,periods,blocks,electronicConfigurationContents,meltingPoints,densities,oxidationStates
                                        ]

                                        ForEach(0..<Headings.count, id: \.self) { index in
                                            VStack {
                                                Text(Headings[index])
                                                    .font(.custom(atomSymbolFont, size: 14))
                                                    .fontWeight(.medium)
                                                    
                                                Text("\(content[index][selectedElement])")
                                                    .font(.custom(versionFont, size: 12))
                                            }
                                            .padding(.all,1)
                                            Divider()
                                                .frame(width: 200)
                                                .background(.gray)
                                        }
                                    }
                                    .padding() // Padding around the VStack
                                }
                            }
                            .padding() // Padding around the ScrollView
                        }
                }
                //second set
                GridRow{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(elementCardColor[selectedElement])
                        .frame(width: screenWidth * 0.275,height: screenWidth * 0.175)
                        .overlay(alignment: .top){
                            Text("Basic particles of an atom")
                                .font(.custom(atomSymbolFont, size: 14))
                                .padding()
                        }
                        .overlay(alignment:.trailing){
                                RoundedRectangle(cornerRadius: CGFloat(10))
                                    .fill(.atomBackground)
                                    .frame(width:isIPhone ? screenWidth*0.14:screenWidth*0.12,height: isIPhone ? screenWidth*0.14:screenWidth*0.12)
                                renderMiniatureAtomStructure(selectedElement: selectedElement)
                            
                        }
                    RoundedRectangle(cornerRadius: 10)
                        .fill(elementCardColor[selectedElement])
                        .frame(width: screenWidth * 0.275,height: screenWidth * 0.175)
                        .overlay(alignment: .top){
                            Text("Applications of an atom")
                                .font(.custom(atomSymbolFont, size: 14))
                                .padding()
                        }
                }
            }
        }
        .scaleEffect(0.9)
    }
}
#Preview {
    ContentViewdd()
}

