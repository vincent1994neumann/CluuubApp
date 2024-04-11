//
//  LetsGoRowingView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 13.03.24.
//

import SwiftUI

struct LetsGoRowingView: View {
    
    @StateObject var LGRviewModel = LetsGoRowingViewModel()
    
    @Binding var selectedTab: Tabs
    
    @State var showingAddRequestSheet = false
    
    @State private var mainFilterOption: MainFilterOptions = .open
    @State private var subFilterOption: SubFilterOptions = .all
    
    var filteredRequests: [LetsGoRowingRequest] {
        LGRviewModel.listOfRequest.filter{ request in
            request.rowingDate >= Date() &&
                   (
                       (mainFilterOption == .open && !request.requestClosed) ||
                       (mainFilterOption == .closed && request.requestClosed) 
                   )
        }.filter{ request in
            switch subFilterOption {
            case .all:
                return true
            case .skull:
                return request.rowingStyle == .skull
            case .riemen:
                return request.rowingStyle == .riemen
            }
            
        }.sorted{ $0.rowingDate < $1.rowingDate}
    }
    
    var body: some View {
        NavigationStack{
            VStack{
               
                
                Picker("Hauptfilter", selection: $mainFilterOption){
                    ForEach(MainFilterOptions.allCases, id: \.self) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                if mainFilterOption == .open {
                    Picker("Subfilter", selection: $subFilterOption){
                        ForEach(SubFilterOptions.allCases, id: \.self){ option in
                            Text(option.rawValue).tag(option)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                }
            }.padding(.leading, 8)
             .padding(.trailing, 8)
            
            ScrollView{
                
                ForEach(filteredRequests) { request in
                    RequestView(request: request, LGRViewModel: LGRviewModel)
                    
                }.toolbar {
                    ToolbarItem(placement: .topBarTrailing){
                        Button("Add Request", systemImage: "plus"){
                            
                            showingAddRequestSheet = true
                        }.sheet(isPresented: $showingAddRequestSheet){
                            LetsGoRowingRequestView(LGRViewModel: LGRviewModel)
                        }
                        
                    }
                }.navigationTitle("Let's Go Rowing")
            } .onAppear {
                LGRviewModel.fetchAllRequests()
            }
            .padding(.leading, 8)
            .padding(.trailing, 8)
        }
    }
}


//#Preview {
//    LetsGoRowingView(selectedTab: .constant(.letsGoRowingView))
//}
