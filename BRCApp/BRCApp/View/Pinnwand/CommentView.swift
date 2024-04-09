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
            Text(comment.author).font(.headline)
            Text(comment.content)
            Text("Am \(comment.timestamp, formatter: CommentView.itemFormatter)").font(.subheadline)
        }
    }
    
    static private var itemFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }
}
