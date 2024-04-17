//
//  WeatherWidget.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 10.04.24.
//

import SwiftUI

struct WeatherWidget: View {
    var weatherAPI = APIWeatherRepo()
    @StateObject var viewModel = WeatherWidgetViewModel()
    
    
    
    var body: some View {
        
        HStack{
            
            Text("\(viewModel.vereinOrt)")
                .font(.footnote)
            Text("\(String(format: "%.0f", viewModel.temperature))° |")
            
            Image(systemName: "wind")
            Text("\(String(format: "%.0f", viewModel.windSpeed))")
            Text("km/h |")
                .font(.footnote)
            Image(systemName: "eye")
            Text("\(viewModel.weatherClouds)")
            Text("%")
                .font(.footnote)
        }
    }
}



#Preview {
    WeatherWidget()
}
