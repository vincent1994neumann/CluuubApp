    //
    //  PinnwanndDetailView.swift
    //  BRCApp
    //
    //  Created by Vincent  Neumann on 02.04.24.
    //

    import SwiftUI

    struct PinnwandDetailView: View {
        let pinnwandPost: Pinnwand
        
        @State private var newCommentContent: String = ""
        @ObservedObject var viewModel: PinnwandViewModel

        var body: some View {
            VStack {
                ScrollView{
                    VStack(alignment: .leading, spacing: 10) {
                        Text(pinnwandPost.title).font(.title)
                        Text("\(pinnwandPost.categoryPost)")
                        Text(pinnwandPost.description)
                        Text("Veröffentlicht von: \(pinnwandPost.publishedBy.fullName)")
                        Text("Am \(pinnwandPost.publishedDate)")
                        Divider()
                        Text("Kommentare:").font(.headline)
                        
                        ForEach(viewModel.comments) { comment in
                                            CommentView(comment: comment)
                                        }
                    }
                    .padding()
                }
                .onAppear(perform: {
                    viewModel.loadComments(forPostWithID: viewModel.currentPinnwandPost?.id ?? "Error")
                })


                
                Divider()
                HStack {
                    TextField("Schreiben Sie einen Kommentar...", text: $newCommentContent)
                    Button("Senden") {
                        // Es ist sicher, direkt auf postID und publishedBy zuzugreifen,
                        // da sie anscheinend keine Optionals sind.
                        guard let postID = pinnwandPost.id else {
                            print("Error: Post ID ist nil")
                            return
                        }
                        viewModel.addComment(toPostWithID: postID, content: newCommentContent, author: pinnwandPost.publishedBy)
                        viewModel.loadComments(forPostWithID: postID)
                        newCommentContent = ""
                    }
                    .disabled(newCommentContent.isEmpty)


                }
                .padding()
            }
            .navigationBarTitle(Text(pinnwandPost.title), displayMode: .inline)
            .onAppear {
                       if let postID = viewModel.currentPinnwandPost?.id {
                           viewModel.loadComments(forPostWithID: postID)
                       }
                   }
        }
        
        private var itemFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.timeStyle = .short
            return formatter
        }
    }
