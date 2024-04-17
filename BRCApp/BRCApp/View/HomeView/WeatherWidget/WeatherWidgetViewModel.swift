//
//  WeatherWidgetViewModel.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 10.04.24.
//

import Foundation
import Combine

class WeatherWidgetViewModel : ObservableObject{
    
    @Published var temperature : Double = 0.0
    @Published var windSpeed : Double = 0.0
    @Published var weatherIcon : String = ""
    @Published var weatherClouds : Int = 0
    var vereinOrt : String = "Berlin Wannsee"
    
    private var weatherAPI = APIWeatherRepo()
    
    init(){
       fetchWeather()
    }
    
    
    func fetchWeather() {
          weatherAPI.fetchWeather { [weak self] response in
              DispatchQueue.main.async {
                  if let weatherResponse = response {
                      // Konvertieren der Temperatur von Kelvin in Celsius
                      self?.temperature = weatherResponse.main.temp - 273.15
                      self?.windSpeed = weatherResponse.wind.speed
                      self?.weatherClouds = weatherResponse.clouds.all
                  } else {
                      self?.temperature = 0.0
                      self?.windSpeed = 0.0
                      self?.weatherClouds = 0
                  }
              }
          }
      }
    
}
