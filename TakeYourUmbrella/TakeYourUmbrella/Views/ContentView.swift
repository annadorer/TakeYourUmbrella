//
//  ContentView.swift
//  TakeYourUmbrella
//
//  Created by Anna on 11.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    print("button tapped")
                }) {
                    Image("notification")
                        .resizable()
                        .background(Color("Button"))
                        .frame(width: 50, height: 50)
                        .overlay(RoundedRectangle(cornerRadius: 30)
                            .stroke(Color("ButtonCircle"), lineWidth: 7))
                        .cornerRadius(30)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: -15) {
                    Text("\(dateFormatter.string(from: currentDate))")
                        .font(.custom("PalanquinDark-Regular", size: 20))
                    .foregroundColor(Color("Text"))
                    Text("\(viewModel.weather?.location.name ?? "" ), \(viewModel.weather?.location.country ?? "")")
                        .font(.custom("PalanquinDark-Regular", size: 27))
                        .foregroundColor(Color("Text"))
                }
            }
            .padding(.all)
            Spacer()
            HStack(alignment: .center) {
                Image("rain")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .background(Color("Form"))
                
                    .cornerRadius(110)
                Spacer()
                VStack(alignment: .center, spacing: -30) {
                    Text("12°C")
                        .font(.custom("PalanquinDark-Regular", size: 70))
                        .foregroundColor(Color("Text"))
                    Text("Rain")
                        .font(.custom("PalanquinDark-Regular", size: 30))
                        .foregroundColor(Color("Text"))
                }
            }
            .padding()
            Spacer()
                .padding()
            HStack {
                Spacer()
                combineTexts(text1: "Wind", text2: "7 kn/g")
                Divider()
                    .foregroundColor(.red)
                    .frame(width: 15, height: 50)
                combineTexts(text1: "Cloud", text2: "10%")
                Divider()
                    .foregroundColor(.red)
                    .frame(width: 15, height: 50)
                combineTexts(text1: "Humidity", text2: "79%")
                Spacer()
            }
            
            .background(Color("Form"))
            .cornerRadius(50)
            .padding(.all)
        }
        .background(Color("Background"))
        
        .onAppear {
            viewModel.onAppear()
        }
        
    }
    init() {
        dateFormatter.dateFormat = "EEEE, d MMMM"
    }

}

func combineTexts(text1: String, text2: String) -> some View {
    return VStack {
        Text(text1)
            .font(.custom("PalanquinDark-Regular", size: 22))
        Text(text2)
            .font(.custom("PalanquinDark-Regular", size: 20))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
