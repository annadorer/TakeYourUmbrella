//
//  ContentView.swift
//  TakeYourUmbrella
//
//  Created by Anna on 11.03.2024.
//

import SwiftUI
import UserNotifications
//import Combine

struct WeatherView: View {
    
    @StateObject var viewModel = WeatherViewModel()
    @State var showingLocationSearchView = false
    
    private let currentDate = Date()
    private let dateFormatter = DateFormatter()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    viewModel.notifications.requestNotificationAuthorization(dailyChanceOfRain: viewModel.weather?.dailyChanceOfRain ?? 0)
                    viewModel.notifications.scheduleRainNotification(dailyChanceOfRain: viewModel.weather?.dailyChanceOfRain ?? 0)
                    
                }) {
                        imageView(imageName: "notification", width: 50, height: 50, color: "Button", cornerRadius: 30)
                    }
                Spacer()
                VStack(alignment: .trailing, spacing: -10) {
                    textView(text: "\(dateFormatter.string(from: currentDate))", size: 21)
                    textView(text: "\(viewModel.weather?.city ?? ""), \(viewModel.weather?.country ?? "")", size: 22)
                        .lineLimit(1)
                }
            }
            
            HStack(alignment: .center, spacing: 40) {
                imageView(imageName: "\(viewModel.weather?.condition.image ?? "default")", width: 180, height: 180, color: "Form", cornerRadius: 110)
                    .shadow(radius: 15)
                VStack(alignment: .center, spacing: -30) {
                    textView(text: "\(viewModel.weather?.temperature ?? 0)°C", size: 75)
                    textView(text: "\(viewModel.weather?.condition ?? WeatherData.WeatherCondition.sunny)", size: 28)
                }
            }
            .padding(.top, 10)
            HStack {
                Spacer()
                combineTexts(text1: "Humidity", text2: "\(viewModel.weather?.humidity ?? 0)%")
                Divider()
                    .overlay(.black)
                    .frame(width: 15, height: 50)
                combineTexts(text1: "Cloud", text2: "\(viewModel.weather?.cloudness ?? 0)%")
                Divider()
                    .overlay(.black)
                    .frame(width: 15, height: 50)
                combineTexts(text1: "Wind", text2: "\(viewModel.weather?.windSpeed ?? 0) mp/h")
                Spacer()
            }
            .background(Color("Form"))
            .overlay(RoundedRectangle(cornerRadius: 50)
                .stroke(Color("ButtonCircle"), lineWidth: 7))
            .cornerRadius(50)
            .shadow(radius: 15)
            HStack {
                Text("Precipitation amount: \(viewModel.weather?.precipitation ?? 0)")
                    .font(.custom("PalanquinDark-Regular", size: 22))
            }
            .padding(.bottom, 10)
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    combineTexts(text1: "Chance of rain", text2: "\(viewModel.weather?.dailyChanceOfRain ?? 0)%")
                }
                .padding(.all, 10)
                Image("umbrella")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(1)
                    .padding(.all,9)
            } .frame(width: 360, height: 100)
                .overlay(RoundedRectangle(cornerRadius: 50)
                    .stroke(Color("ButtonCircle"), lineWidth: 7))
                .background(Color("Form"))
                .cornerRadius(50)
                .shadow(radius: 15)
                .padding(.all,10)
            Spacer()
            HStack {
                Rectangle()
                    .frame(height: 2.5)
                    .foregroundColor(Color("Text"))
                Button(action: {
                    self.showingLocationSearchView.toggle()
                }) {
                    imageView(imageName: "location", width: 58, height: 58, color: "Button", cornerRadius: 30)
                } .sheet(isPresented: $showingLocationSearchView) {
                    LocationSearchView(onChooseLocation: {location in
                        viewModel.fetchWeather(weatherSearchParameters: WeatherSerachParameters(city: location.city, country: location.country))
                    }, receivedText: $viewModel.chooseLocation)
                }
                Rectangle()
                    .frame(height: 2.5)
                    .foregroundColor(Color("Text"))
            }
        }
        .padding(.all)
        .background(Color("Background"))
        .onAppear {
            viewModel.fetchWeather(weatherSearchParameters: WeatherSerachParameters(city: "Moscow", country: "Russia"))
        }
    }
    
    init() {
        dateFormatter.dateFormat = "EEEE, d MMMM"
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
