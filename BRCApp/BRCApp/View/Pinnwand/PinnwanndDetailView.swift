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
                        Text(viewModel.currentPinnwandPost?.title ?? "Error").font(.title)
                        Text(pinnwandPost.subTitle).font(.headline)
                        Text(pinnwandPost.description)
                        Text("Veröffentlicht von: \(pinnwandPost.publishedBy.fullName)")
                        Text("Am \(pinnwandPost.publishedDate), formatter: itemFormatter)")
                        Divider()
                        Text("Kommentare:").font(.headline)
                        
                        ForEach(viewModel.currentPinnwandPost?.commentSection ?? []) { comment in
                               CommentView(comment: comment)
                           }

                        
                    }
                    .padding()
                }.onAppear(perform: {
                    viewModel.loadComments(forPostWithID: viewModel.currentPinnwandPost?.id ?? "Error")
                })


                
                Divider()
                HStack {
                    TextField("Schreiben Sie einen Kommentar...", text: $newCommentContent)
                    Button("Senden") {
                        viewModel.addComment(toPostWithID: pinnwandPost.id ?? "Error PostId", content: newCommentContent, author: pinnwandPost.publishedBy)
    //                    viewModel.addComment(toPostWithID: pinnwandPost.id ?? <#default value#>, content: newCommentContent, author: viewModel.currentUser?.id)
                        viewModel.loadComments(forPostWithID: viewModel.currentPinnwandPost?.id ?? "Error !!!")
                        print("\(pinnwandPost.commentSection)")
                        newCommentContent = ""
                    }
                    .disabled(newCommentContent.isEmpty)
                }
                .padding()
            }
            .navigationBarTitle(Text(pinnwandPost.title), displayMode: .inline)
        }
        
        private var itemFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.timeStyle = .short
            return formatter
        }
    }
