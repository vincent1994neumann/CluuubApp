//
//  HomeViewModel.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 14.03.24.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject, Identifiable{
    
    @Published var images : [GalleryImage] = [
        GalleryImage(name: "Anrudern"),
        GalleryImage(name: "BW2018"),
        GalleryImage(name: "Bootsplatz"),
        GalleryImage(name: "Olympia"),
        GalleryImage(name: "TrainerBootsTaufe")
    ]
    
    @Published var currentIndex = 0
    private var timer : Timer?
    
    
    init(){
        startTimer()
    }
    deinit{
        print("HomeViewModel deinitialist")
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { [weak self] _ in
            guard let self = self else {return}
            withAnimation {
                self.currentIndex = (self.currentIndex + 1) % self.images.count 
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
