//
//  ContentView.swift
//  TakeYourUmbrella
//
//  Created by Anna on 11.03.2024.
//

import SwiftUI
import Foundation

struct WeatherView: View {
    
    @StateObject var weatherViewModel = WeatherViewModel()
    
    @State private var username: String = ""
    @State private var saveUserDataService: SaveUserDataService = SaveUserDataService()
    @State var showingLocationSearchView = false
    
    private let currentDate = Date()
    private let dateFormatter = DateFormatter()
    
    let saveData = UserDefaults.standard
    
    func getBody() -> some View {
       return Text("")
        }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button(action: {
                        weatherViewModel.notifications.requestNotificationAuthorization(dailyChanceOfRain: weatherViewModel.weather?.dailyChanceOfRain ?? 0)
                        weatherViewModel.notifications.scheduleRainNotification(dailyChanceOfRain: weatherViewModel.weather?.dailyChanceOfRain ?? 0) }) {
                            imageView(imageName: "notification", width: 58, height: 58, color: "Button", cornerRadius: 30)
                        }
                        .padding(.leading, 7)
                    Spacer()
                    VStack(alignment: .trailing, spacing: -10) {
                        textView(text: "\(dateFormatter.string(from: currentDate))", size: 21)
                        textView(text: "\(weatherViewModel.weather?.city ?? ""), \(weatherViewModel.weather?.country ?? "")", size: 22)
                            .lineLimit(1)
                    }
                }
                .padding(.all, 10)
                HStack(alignment: .top, spacing: 35) {
                    imageView(imageName: "\(weatherViewModel.weather?.condition.image ?? "default")", width: 170, height: 170, color: "Form", cornerRadius: 110)
                    VStack(alignment: .center, spacing: -20) {
                        textView(text: "\(weatherViewModel.weather?.temperature ?? 0)°C", size: 75)
                        textView(text: "\(weatherViewModel.weather?.condition.rawValue ?? "")", size: 24)
                    }
                }
                .padding(.top, 5)
                HStack {
                    Spacer()
                    combineTexts(text1: "Humidity", text2: "\(weatherViewModel.weather?.humidity ?? 0)%")
                    Divider()
                        .overlay(.black)
                        .frame(width: 15, height: 50)
                    combineTexts(text1: "Cloud", text2: "\(weatherViewModel.weather?.cloudness ?? 0)%")
                    Divider()
                        .overlay(.black)
                        .frame(width: 15, height: 50)
                    combineTexts(text1: "Wind", text2: "\(weatherViewModel.weather?.windSpeed ?? 0) mp/h")
                    Spacer()
                }
                .background(Color("Form"))
                .overlay(RoundedRectangle(cornerRadius: 50)
                    .stroke(Color("ButtonCircle"), lineWidth: 7))
                .cornerRadius(50)
                .padding(.all, 10)
                HStack {
                    Text("Precipitation amount: \(weatherViewModel.weather?.precipitation ?? "")")
                        .font(.custom("PalanquinDark-Regular", size: 22))
                        .foregroundColor(Color("Text"))
                }
                .padding(.bottom, 25)
            }
            .padding(.top, 65)
            .background(
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 45, style: .continuous)
                        .fill(Color("FirstBackground"))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .shadow(radius: 10)
                }
            )
            .edgesIgnoringSafeArea(.all)
                HStack {
                    VStack(alignment: .center, spacing: 0) {
                        combineTexts(text1: "Daily chance of rain", text2: "\(weatherViewModel.weather?.dailyChanceOfRain ?? 0)%")
                    }
                    Image("umbrella")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(1)
                        .padding(.all, 15)
                } .frame(width: 360, height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 50)
                        .stroke(Color("ButtonCircle"), lineWidth: 7))
                    .background(Color("Form"))
                    .cornerRadius(50)
                    .padding(.all, 5)
                HStack {
                    Rectangle()
                        .frame(height: 2.5)
                        .foregroundColor(Color("Text"))
                    Button(action: {
                        self.showingLocationSearchView.toggle()
                    }) {
                        imageView(imageName: "location", width: 65, height: 65, color: "Button", cornerRadius: 35)
                    } .sheet(isPresented: $showingLocationSearchView) {
                        LocationSearchView(onChooseLocation: { location in
                            saveUserDataService.saveData(element: location, key: "saveLocation")
                            weatherViewModel.fetchWeather(weatherSearchParameters: WeatherSerachParameters(city: location.city, country: location.country))
                        }, receivedText: $weatherViewModel.chooseLocation)
                    }
                    Rectangle()
                        .frame(height: 2.5)
                        .foregroundColor(Color("Text"))
                }
                .padding(.all, 20)
        }
        .background(LinearGradient(colors: [Color(.white), Color("SecondBackground")], startPoint: .topTrailing, endPoint: .bottomTrailing))
        .onAppear {
            let saveLocation: LocationData? = saveUserDataService.readData(key: "saveLocation")
            weatherViewModel.fetchWeather(weatherSearchParameters: WeatherSerachParameters(city: saveLocation?.city ?? "Moscow", country: saveLocation?.country ?? "Russia"))
        }
    }
    
    init() {
        dateFormatter.dateFormat = "EEEE, d MMMM"
        dateFormatter.locale = Locale(identifier: "en_US")
    }
    
    private func combineTexts(text1: String, text2: String) -> some View {
        return VStack {
            Text(text1)
                .font(.custom("PalanquinDark-Regular", size: 22))
                .foregroundColor(Color("Text"))
            Text(text2)
                .font(.custom("PalanquinDark-Regular", size: 20))
                .foregroundColor(Color("Text"))
        }
    }
    
    private func textView(text: String, size: Double) -> Text {
        return Text(text)
            .font(.custom("PalanquinDark-Regular", size: size))
            .foregroundColor(Color("Text"))
    }
    
    private func imageView(imageName: String, width: Double, height: Double, color: String, cornerRadius: Double) -> some View {
        return Image(imageName)
            .resizable()
            .frame(width: width, height: height)
            .background(Color(color))
            .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color("ButtonCircle"), lineWidth: 5))
            .background(Color(.white))
            .cornerRadius(cornerRadius)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
