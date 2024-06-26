//
//  HomeView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 13.03.24.
//

import SwiftUI
import MapKit

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @ObservedObject var LGRViewModel : LetsGoRowingViewModel
    @Binding var selectedTab: Tabs
    @State private var isShowingSideMenu = false
     var weatherAPI = APIWeatherRepo()
    
    
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack{
            
            ZStack{
                VStack{
                    Image("BRC_Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                        .opacity(0.9)
                        .cornerRadius(8)
                    WeatherWidget().padding(.all,8)
                    
                    GeometryReader { geometry in
                        TabView(selection: $viewModel.currentIndex) {
                            ForEach(0..<viewModel.images.count, id: \.self) { index in
                                Image(viewModel.images[index].name)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width, height: 180)
                                    .clipped()
                                    .tag(index)
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Versteckt die Page Control Indikatoren
                        .frame(height: 180)
                    }
                    .frame(height: 180)
                    
                    
                    HStack{
                        Spacer()
                        Text("Upcoming Events")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .padding(.top, 8)
                 
                    }
                        
                    VeranstaltungsView()
                      
                    
                   Spacer()
                    
                   
                    
                    
                   
                    
                }.toolbar{
                    ToolbarItem(placement: .topBarLeading){
                        Button(action:{
                            withAnimation(.smooth){
                                isShowingSideMenu.toggle()
                            }
                        }){
                            Image(systemName: "list.bullet")
                        }
                    }
                }
                .offset(x: isShowingSideMenu ? UIScreen.main.bounds.width * 0.6 : 0)
                .onTapGesture {
                    withAnimation(.smooth){
                        isShowingSideMenu = false
                    }
                }
                
                
                HStack{
                    if isShowingSideMenu{
                        SideMenuView(isShowing: $isShowingSideMenu)
                            .frame(width: UIScreen.main.bounds.width * 0.6)
                            .transition(.move(edge: .leading))
                        Spacer()
                    }
                }
            }
                
        }
    }
     
}

