//
//  LocationSearchView.swift
//  TakeYourUmbrella
//
//  Created by Anna on 26.03.2024.
//

import SwiftUI

struct LocationSearchView: View {
    
    @State private var location: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    private var cities = ["Amstelveen", "Amsterdam", "Amsterdam-Zuidoost", "Amstetten"]
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Found your location entering city or country")
            HStack {
                Image(systemName: "magnifyingglass.circle")
                    .foregroundColor(Color.gray)
                    .padding(.leading)
                TextField("Location", text: $location)
                if !location.isEmpty {
                    Button { location = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(Color.gray)
                    }
                    .padding(.trailing)
                }
            }
            .frame(width: 360, height: 50)
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(Color("ButtonCircle"), lineWidth: 4))
            .background(.white)
            .cornerRadius(20)
            Spacer()
            Button("Back") {
                self.presentationMode.wrappedValue.dismiss()
            }
            .foregroundColor(Color("Text"))
            .fontWeight(.medium)
            .frame(width: 80, height: 50)
            .background(Color("Form"))
            .overlay(RoundedRectangle(cornerRadius: 30)
                .stroke(Color("ButtonCircle"), lineWidth: 4))
            .cornerRadius(30)
            //            List(cities, id: \.self) { city in
            //                ZStack {
            //                    Text(city)
            //                }
            //                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            //            }
        }
        .padding(.all)
        .background(Color("Background"))
        .font(.custom("PalanquinDark-Regular", size: 17))
        
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView()
    }
}
