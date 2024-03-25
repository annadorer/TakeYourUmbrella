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
                    imageView(imageName: "notification", width: 50, height: 50, color: "Button", cornerRadius: 30)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: -10) {
                    textView(text: "\(dateFormatter.string(from: currentDate))", size: 21)
                    textView(text: "\(viewModel.weather?.location.name ?? "" ), \(viewModel.weather?.location.country ?? "")", size: 24.5)
                }
            }
            HStack(){
                imageView(imageName: "rain", width: 180, height: 180, color: "Form", cornerRadius: 110)
                Spacer()
                VStack(alignment: .center, spacing: -30) {
                    textView(text: "\(viewModel.weather?.current.tempC ?? 0)°C", size: 75)
                    textView(text: "\(viewModel.weather?.current.condition.text ?? "")", size: 28)
                }
            }
            HStack {
                Spacer()
                combineTexts(text1: "Wind", text2: "\(viewModel.weather?.current.windMPH ?? 0) mp/h")
                Divider()
                    .overlay(.black)
                    .frame(width: 15, height: 50)
                combineTexts(text1: "Humidity", text2: "\(viewModel.weather?.current.humidity ?? 0)%")
                Divider()
                    .overlay(.black)
                    .frame(width: 15, height: 50)
                combineTexts(text1: "Cloud", text2: "\(viewModel.weather?.current.cloud ?? 0)%")
                Spacer()
            }
            .background(Color("Form"))
            .cornerRadius(50)
            Spacer()
            HStack() {
                Text("Precipitation amount \(viewModel.weather?.current.precipMM ?? 0)")
                    .font(.custom("PalanquinDark-Regular", size: 22))
            }
            HStack() {
                //GifImageView(gifName: "water")
                combineTexts(text1: "Chance of rain", text2: "\(viewModel.weather?.forecast.forecastday[0].day.dailyChanceOfRain ?? 0)%")
            }
            HStack {
                Rectangle()
                    .frame(height: 2.5)
                    .foregroundColor(.black)
                Button(action: {
                    print("button tapped")
                }) {
                    imageView(imageName: "location", width: 58, height: 58, color: "Button", cornerRadius: 30)
                }
                Rectangle()
                    .frame(height: 2.5)
                    .foregroundColor(.black)
            }
        }
        .padding(.all)
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

func textView(text: String, size: Double) -> Text {
    return Text(text)
        .font(.custom("PalanquinDark-Regular", size: size))
        .foregroundColor(Color("Text"))
}

func imageView(imageName: String, width: Double, height: Double, color: String, cornerRadius: Double) -> some View {
    return Image(imageName)
        .resizable()
        .frame(width: width, height: height)
        .background(Color(color))
        .overlay(RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(Color("ButtonCircle"), lineWidth: 7))
        .cornerRadius(cornerRadius)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
