//
//  HourForecastCard.swift
//  Rainy
//
//  Created by Thijs van der Heijden on 25/06/2020.
//

import SwiftUI

struct HourForecastCard: View {
    
    var time: Int
    var temp, precipMM: Double
    var hour: Hourly
    
    init(hour: Hourly) {
        self.hour = hour
        self.time = Calendar.current.component(.hour, from: Date(timeIntervalSince1970: Double(hour.dt)))
        self.temp = hour.temp
        self.precipMM = hour.rain?.the1H ?? 0
    }
    
    var body: some View {
        VStack {
            Image(iconForId(id: hour.weather[0].id))
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .padding()
            Spacer()
            VStack {
                Text("\(String(Double(round(10 * (temp - 273))/10)))°C")
                    .bold()
                if hour.rain?.the1H ?? 10 > 0.01 {
                    Text("\(String(Double(round(10 * (hour.rain?.the1H ?? 0))/10))) mm rain")
                }
            }
            .padding()
        }
        .foregroundColor(.white)
        .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 5)
        .background(Color.black)
        .cornerRadius(15)
    }
}
