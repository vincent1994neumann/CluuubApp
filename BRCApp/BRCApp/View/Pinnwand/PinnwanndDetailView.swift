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
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 10) {
//                        Text(pinnwandPost.title)
//                            .font(.largeTitle)
//                            .bold()
//                            .padding(.top)

                        Text(pinnwandPost.categoryPost.rawValue)
                            .font(.title2)
                            .foregroundColor(.secondary)
                            .padding(.vertical, 4)

                        Text(pinnwandPost.description)
                            .font(.body)
                            .padding(.bottom)

                        HStack {
                            Text("Veröffentlicht von:")
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            Text(pinnwandPost.publishedBy.fullName)
                                .font(.subheadline)
                                .foregroundColor(.primary) // Primärfarbe für wichtige Informationen
                        }

                        HStack {
                            Text("Am:")
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            Text(pinnwandPost.publishedDate, style: .date) // Datum im Standardformat
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        }
                        .padding(.bottom, 5)

                        Divider()

                        Text("Kommentare:")
                            .font(.headline)
                            .padding(.vertical, 5)

                        ForEach(viewModel.comments) { comment in
                            CommentView(comment: comment)
                        }
                    }
                    .padding(.horizontal) // Horizontaler Abstand zu den Seiten
                }

                .onAppear(perform: {
                    viewModel.loadComments(forPostWithID: pinnwandPost.id!)
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
