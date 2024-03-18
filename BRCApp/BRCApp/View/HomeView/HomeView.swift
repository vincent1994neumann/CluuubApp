//
//  HomeView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 13.03.24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @Binding var selectedTab: Tabs
    @State private var isShowingSideMenu = false
  
    
    
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack{
            VStack{
                Image("BRC_Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                
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
                    .frame(width: geometry.size.width, height: 180)
                }
            }.toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button(action:{
                        withAnimation{
                            isShowingSideMenu.toggle()
                        }
                    }){
                        Image(systemName: "list.bullet")
                    }
                }
            }.sheet(isPresented: $isShowingSideMenu, content: {
               
            })
        }
    }
}
#Preview {
    HomeView(viewModel: HomeViewModel(), selectedTab: .constant(.homeView))
}
