//
//  LocationSearchView.swift
//  TakeYourUmbrella
//
//  Created by Anna on 26.03.2024.
//

import SwiftUI

struct LocationSearchView: View {
    
    @StateObject var locationService = LocationViewModel()
    
    @State private var location: String = ""
    @State private var timer: Timer?
    @State var selectedLocation: String?
    
    var onChooseLocation: (_ location: LocationData) -> Void
    
    @Binding var receivedText: String
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Found your location entering city or country")
            HStack {
                Image(systemName: "magnifyingglass.circle")
                    .foregroundColor(Color.gray)
                    .padding(.leading)
                TextField("Location", text: $location)
                    .onChange(of: location) { newValue in
                        self.timer?.invalidate()
                        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                            locationService.loadData(for: newValue)
                            locationService.location = []
                        }
                    }
                if !location.isEmpty {
                    Button { location = ""
                        locationService.location = []
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
            if !location.isEmpty {
                ScrollView {
                    VStack {
                        if locationService.location.isEmpty {
                            Text("Nothing found") } else {
                                ForEach(locationService.location, id: \.id) { location in
                                    Text("\(location.city), \(location.region), \(location.country)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.all,4)
                                        .lineLimit(1)
                                        .onTapGesture(count: 1) {
                                            self.selectedLocation = "\(location)"
                                            self.onChooseLocation(location)
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                    Divider()
                                }
                            }
                    }
                }
            }
            Spacer()
            Button("Back") {
                self.receivedText = selectedLocation ?? ""
                self.presentationMode.wrappedValue.dismiss()
            }
            .foregroundColor(Color("Text"))
            .fontWeight(.medium)
            .frame(width: 80, height: 50)
            .background(Color("Form"))
            .overlay(RoundedRectangle(cornerRadius: 30)
                .stroke(Color("ButtonCircle"), lineWidth: 4))
            .cornerRadius(30)
        }
        .padding(.all)
        .background(Color("ThirdBackground"))
        .font(.custom("PalanquinDark-Regular", size: 17))
    }

}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(onChooseLocation: {city in}, receivedText: .constant(""))
    }
}
