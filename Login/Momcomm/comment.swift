//
//  comment.swift
//  Login
//
//  Created by user4 on 20/03/24.
//
 
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Comment: Identifiable, Codable {
    @DocumentID var id: String?
    var uid: String
    var username: String
    var text: String
    var timestamp: Timestamp
}

struct CommentView: View {
    var tweetID: String
    var userID: String // Pass the userID from the parent view
    @State private var newCommentText = ""
    @ObservedObject private var commentViewModel = CommentViewModel()
    @State private var username: String = "" // State variable to store the username

    var body: some View {
        VStack {
            // List of comments
            List(commentViewModel.comments) { comment in
                VStack(alignment: .leading) {
                    Text(comment.username)
                        .font(.headline)
                    Text(comment.text)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            
            // Text field and button to add new comment
            HStack {
                TextField("Add a comment", text: $newCommentText)
                    .padding(.horizontal)
                Button("Post") {
                    // Add the new comment to the database
                    let newComment = Comment(uid: userID, username: username, text: newCommentText, timestamp: Timestamp())
                    commentViewModel.addComment(newComment, toTweetWithID: tweetID)
                    // Clear the text field
                    newCommentText = ""
                }
            }
            .padding()
            .background(Color.secondary.opacity(0.1))
        }
        .onAppear {
            // Fetch comments for the tweet
            commentViewModel.fetchComments(forTweetWithID: tweetID)
            // Fetch the username associated with the userID
            getUsername(forUID: userID) { fetchedUsername in
                if let fetchedUsername = fetchedUsername {
                    self.username = fetchedUsername
                }
            }
        }
        .navigationBarTitle("Comments", displayMode: .inline)
    }
}


class CommentViewModel: ObservableObject {
    private var db = Firestore.firestore()

    @Published var comments: [Comment] = []

    func fetchComments(forTweetWithID tweetID: String) {
        db.collection("tweets").document(tweetID).collection("comments").order(by: "timestamp", descending: true).addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            self.comments = documents.compactMap { document in
                do {
                    let comment = try document.data(as: Comment.self)
                    return comment
                } catch {
                    print("Error decoding comment: \(error.localizedDescription)")
                    return nil
                }
            }
        }
    }
    
    func addComment(_ comment: Comment, toTweetWithID tweetID: String) {
        do {
            try db.collection("tweets").document(tweetID).collection("comments").addDocument(from: comment)
        } catch {
            print("Error adding comment: \(error.localizedDescription)")
        }
    }
}
