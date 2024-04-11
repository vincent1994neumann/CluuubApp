//
//  CommentView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 02.04.24.
//

import SwiftUI

struct CommentView: View {
    
    @ObservedObject var viewModel: PinnwandViewModel
    var comment: Comment
    @State private var authorName: String = ""


   
    
    var body: some View {
        VStack(alignment: .leading) {
            if authorName.isEmpty {
                          Text("Lade...")
                              .onAppear {
                                  viewModel.fetchUserDetails(byID: comment.author) { rower in
                                      self.authorName = rower?.fullName ?? "Unbekannt"
                                  }
                              }
                      } else {
                          Text(authorName)
                      }
            Text(comment.content).font(.headline)
            Text("\(comment.timestamp, formatter: CommentView.itemFormatter)").font(.footnote).italic()
                .padding(.top,8)
            Divider()
                .padding(4)
        }
    }
    
    static private var itemFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }
}
