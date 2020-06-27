//
//  ContentView.swift
//  Rainy
//
//  Created by Thijs van der Heijden on 25/06/2020.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = WeatherViewModel()
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center) {
                if viewModel.forecast != nil {
                    
                    HStack {
                        Image(iconForId(id: viewModel.forecast.current.weather[0].id))
                            .padding()
                        Spacer()
                        Text("\(String(Double(round(10 * (viewModel.forecast.current.temp - 273))/10)))°C")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                    }
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .background(Color.black)
                    .cornerRadius(15)
                    
                    Spacer()
                    
                    VStack {
                        // Sunrise and sunset
                        HStack {
                            HStack {
                                let sunriseHour = Calendar.current.component(.hour, from: Date(timeIntervalSince1970: Double(viewModel.forecast.current.sunrise)))
                                let sunriseMinute = Calendar.current.component(.minute, from: Date(timeIntervalSince1970: Double(viewModel.forecast.current.sunrise)))
                                Image(systemName: "sunrise")
                                if sunriseMinute < 10 {
                                    if sunriseHour < 10 {
                                        Text("0\(sunriseHour):0\(sunriseMinute)")
                                    } else {
                                        Text("\(sunriseHour):0\(sunriseMinute)")
                                    }
                                } else {
                                    if sunriseHour < 10 {
                                        Text("0\(sunriseHour):\(sunriseMinute)")
                                    } else {
                                        Text("\(sunriseHour):\(sunriseMinute)")
                                    }
                                }
                            }
                            .padding()
                            
                            Spacer()
                            
                            HStack {
                                let sunsetHour = Calendar.current.component(.hour, from: Date(timeIntervalSince1970: Double(viewModel.forecast.current.sunset)))
                                let sunsetMinute = Calendar.current.component(.minute, from: Date(timeIntervalSince1970: Double(viewModel.forecast.current.sunset)))
                                Image(systemName: "sunset")
                                if sunsetMinute < 10 {
                                    if sunsetHour < 10 {
                                        Text("0\(sunsetHour):0\(sunsetMinute)")
                                    } else {
                                        Text("\(sunsetHour):0\(sunsetMinute)")
                                    }
                                } else {
                                    if sunsetHour < 10 {
                                        Text("0\(sunsetHour):\(sunsetMinute)")
                                    } else {
                                        Text("\(sunsetHour):\(sunsetMinute)")
                                    }
                                }
                            }
                            .padding()
                            
                            
                        }
                        
                        // Wind speed and air humidity
                        HStack {
                            // Wind speed HStack
                            HStack {
                                Image(systemName: "wind")
                                Text("\(String(viewModel.forecast.current.windSpeed)) m/s \(windDegreesToCompass(degrees: viewModel.forecast.current.windDeg))")
                            }
                            .padding()
                            
                            Spacer()
                            
                            HStack {
                                
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .background(Color.black)
                    .cornerRadius(15)
                    
                    Spacer()
                    Text("Hourly forecast:")
                        .font(.title)
                        .foregroundColor(.black)
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            ForEach(viewModel.forecast.hourly, id: \.dt) { hour in
                                VStack {
                                    Text("\(String(Calendar.current.component(.hour, from: Date(timeIntervalSince1970: Double(hour.dt))))):00")
                                    GeometryReader { geometry in
                                        HourForecastCard(hour: hour)
                                            .rotation3DEffect(Angle(degrees: Double((geometry.frame(in: .global).minX) - 20) / -20), axis: (x: 0, y: 10, z: 0))
                                    }
                                    .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 5)
                                }
                            }
                        }
                        .padding(20)
                    }
                } else {
                    ProgressView(label: {
                        Text("Loading weather")
                    })
                    .foregroundColor(.black)
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11 Pro")
    }
}
