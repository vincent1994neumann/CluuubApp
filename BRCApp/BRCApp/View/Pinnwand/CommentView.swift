//
//  CommentView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 02.04.24.
//

import SwiftUI

struct CommentView: View {
    var comment: Comment
   
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(comment.author)
            Text(comment.content).font(.headline)
            Text("Am \(comment.timestamp, formatter: CommentView.itemFormatter)").font(.subheadline)
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
