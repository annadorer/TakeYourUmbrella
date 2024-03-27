//
//  ContentView.swift
//  TakeYourUmbrella
//
//  Created by Anna on 11.03.2024.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    @State var showingLocationSearchView = false
    
    private let currentDate = Date()
    private let dateFormatter = DateFormatter()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    requestNotificationAuthorization()}) {
                    imageView(imageName: "notification", width: 50, height: 50, color: "Button", cornerRadius: 30)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: -10) {
                    textView(text: "\(dateFormatter.string(from: currentDate))", size: 21)
                    textView(text: "\(viewModel.weather?.city ?? ""), \(viewModel.weather?.country ?? "")", size: 22)
                        .lineLimit(1)
                }
            }
            
            HStack(alignment: .center, spacing: 25) {
                imageView(imageName: "\(viewModel.weather?.condition.image ?? "default")", width: 180, height: 180, color: "Form", cornerRadius: 110)
                    .shadow(radius: 15)
                VStack(alignment: .center, spacing: -30) {
                    textView(text: "\(viewModel.weather?.temperature ?? 0)°C", size: 75)
                    textView(text: "\(viewModel.weather?.condition ?? WeatherData.WeatherCondition.sunny)", size: 28)
                }
            }
            .padding(.top, -10)
            HStack {
                Spacer()
                combineTexts(text1: "Wind", text2: "\(viewModel.weather?.windSpeed ?? 0) mp/h")
                Divider()
                    .overlay(.black)
                    .frame(width: 15, height: 50)
                combineTexts(text1: "Humidity", text2: "\(viewModel.weather?.humidity ?? 0)%")
                Divider()
                    .overlay(.black)
                    .frame(width: 15, height: 50)
                combineTexts(text1: "Cloud", text2: "\(viewModel.weather?.cloudness ?? 0)%")
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
                    LocationSearchView()
                }
                Rectangle()
                    .frame(height: 2.5)
                    .foregroundColor(Color("Text"))
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
    
    func requestNotificationAuthorization() {
            let center = UNUserNotificationCenter.current()
            
            center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if let error = error {
                    print("Ошибка при запросе разрешения на уведомления: \(error.localizedDescription)")
                } else if granted {
                    print("Разрешение на уведомления получено")
                    scheduleRainNotification()
                } else {
                    print("Пользователь отказал в разрешении на уведомления")
                }
            }
        }
    
    func scheduleRainNotification() {
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Возьмите зонтик!"
        content.body = "Ожидаются осадки. Не забудьте взять зонтик с собой."
        
        // Проверка количества осадков (здесь просто для примера)
        let isRaining = (viewModel.weather?.dailyChanceOfRain ?? 0) >= 40
        
        if isRaining {
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) // Уведомление через 5 секунд
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            center.add(request) { error in
                if let error = error {
                    print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
                } else {
                    print("Уведомление успешно добавлено")
                }
            }
        } else {
            print("Сейчас не ожидаются осадки")
        }
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
