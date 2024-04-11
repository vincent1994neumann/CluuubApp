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
            Image(systemName: "cloud.fog")
            Text("\(viewModel.weatherClouds)")
            Text("%")
                .font(.footnote)
        }
        
        
        //        ZStack{
        //            Rectangle()
        //                .fill(LinearGradient(colors: [.gray, .white], startPoint: .topLeading, endPoint: .bottomTrailing))
        //                .frame(width: 350, height: 120)
        //                .cornerRadius(10.0)
        //
        //            VStack(spacing: 20){
        //
        //                Text("\(viewModel.vereinOrt)")
        //                    .foregroundStyle(.blue)
        //
        //                HStack{
        //                    Text("\(String(format: "%.0f", viewModel.temperature))° Grad")
        //                        .font(.system(size: 24))
        //                    VStack(alignment: .leading, spacing: 8){
        //                        HStack{
        //                            Image(systemName: "wind")
        //                            Text("\(String(format: "%.0f", viewModel.windSpeed)) km/h")
        //                        }
        //                        HStack{
        //                            Image(systemName: "cloud.fog")
        //                            Text("\(viewModel.weatherClouds) %")
        //                        }
        //                    }
        //                }
        //            }
        //        }
    }
}



#Preview {
    WeatherWidget()
}
