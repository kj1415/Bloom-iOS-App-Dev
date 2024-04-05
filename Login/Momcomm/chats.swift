import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

let db = Firestore.firestore()
let userCollectionRef = db.collection("users")


struct Tweet: Identifiable, Codable {
    @DocumentID var id: String?
    var uid: String
    var username: String
    var text: String
    var timestamp: Timestamp
    var imageURL: String? // Add imageURL field
}

var userID: String {
    if let currentUser = Auth.auth().currentUser {
        return currentUser.uid
    } else {
        // Handle the case where there is no authenticated user
        return ""
    }
}

func getUsername(forUID uid: String, completion: @escaping (String?) -> Void) {
    userCollectionRef.document(uid).getDocument { document, error in
        if let document = document, document.exists {
            if let data = document.data(), let username = data["username"] as? String {
                completion(username)
            } else {
                completion(nil)
            }
        } else {
            completion(nil)
        }
    }
}

class TweetViewModel: ObservableObject {
    private var db = Firestore.firestore()

    @Published var tweets: [Tweet] = []

    init() {
        fetchTweets()
    }

    func fetchTweets() {
        db.collection("tweets").order(by: "timestamp", descending: true).addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            self.tweets = documents.compactMap { document in
                do {
                    var tweet = try document.data(as: Tweet.self)
                    // Fetch and update the username associated with the UID
                    getUsername(forUID: tweet.uid) { username in
                        if let username = username {
                            tweet.username = username
                        }
                    }
                    return tweet
                } catch {
                    print("Error decoding tweet: \(error.localizedDescription)")
                    return nil
                }
            }
        }
    }
}


    private func fetchImageURL(forTweetID tweetID: String, completion: @escaping (String?) -> Void) {
        // Construct the path to the image in Firebase Storage
        let imagePath = "tweet_images/\(tweetID)"

        // Fetch the download URL for the image
        Storage.storage().reference().child(imagePath).downloadURL { url, error in
            if let error = error {
                print("Error fetching image URL: \(error.localizedDescription)")
                completion(nil)
            } else if let url = url {
                // Return the image URL
                completion(url.absoluteString)
            } else {
                completion(nil)
            }
        }
    }




struct TwitterCloneView: View {
    @ObservedObject private var tweetViewModel = TweetViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGray6)
                    .ignoresSafeArea()

                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(tweetViewModel.tweets) { tweet in
                            // Tweet View
                            TweetView(tweet: tweet)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                        }
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 70) // Adjust bottom padding to make space for the Add Tweet button
                }

                // Add Tweet button at the bottom corner
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: AddTweetView()) {
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .clipShape(Circle())
                                .padding(.trailing, 20)
                                .padding(.bottom, 20)
                        }
                    }
                }
                .padding(.horizontal) // Add horizontal padding to the VStack
            }
            .navigationBarHidden(false)
            .navigationBarTitle("Momcomm           ", displayMode: .inline) // Set custom navigation bar title
            .navigationBarTitleDisplayMode(.inline) // Set display mode to inline
            .onAppear {
                tweetViewModel.fetchTweets()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct TweetView: View {
    var tweet: Tweet
    @State private var isLiked: Bool = false // Add state to track if the tweet is liked
    @State private var likes: Int = 0 // Add state to track the number of likes

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // User Info Section
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())

                VStack(alignment: .leading) {
                    Text(tweet.username)
                        .font(.headline)

                    Text("@\(tweet.username)")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }

                Spacer()
            }
            .padding([.leading, .trailing, .top])

            // Tweet Text
            Text(tweet.text)
                .padding([.leading, .trailing, .bottom])

            // Tweet Image (if available)
            if let imageURL = tweet.imageURL, let url = URL(string: imageURL) {
                           AsyncImage(url: url) { phase in
                               switch phase {
                               case .empty:
                                   ProgressView()
                               case .success(let image):
                                   image
                                       .resizable()
                                       .aspectRatio(contentMode: .fit)
                                       .frame(maxHeight: 200) // Adjust the frame height as needed
                               case .failure:
                                   Image(systemName: "photo")
                                       .resizable()
                                       .aspectRatio(contentMode: .fit)
                                       .frame(maxHeight: 200) // Adjust the frame height as needed
                                       .foregroundColor(.gray)
                                                              }
                           }
                           .padding([.leading, .trailing])
                       }

            // Action Buttons (e.g., Like, Retweet, Comment)
            HStack(spacing: 20) {
                Button(action: {
                    // Toggle like status
                    isLiked.toggle()
                    // Update the number of likes
                    likes += isLiked ? 1 : -1
                }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .foregroundColor(isLiked ? .red : .gray)
                }

                NavigationLink(destination: CommentView(tweetID: tweet.id ?? "", userID: userID)) {
                    Image(systemName: "bubble.right")
                        .foregroundColor(.gray)
                }
            }
            .padding(.leading) // Add padding to align buttons with tweet text

            // Timestamp
            Text(timeAgo(from: tweet.timestamp.dateValue()))
                .foregroundColor(.gray)
                .font(.footnote)
                .padding([.leading, .trailing])
                .padding(.bottom, 8)
        }
        .background(Color.white)
    }

    // Helper function to format timestamp as time ago
    private func timeAgo(from date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}

    // Helper function to format timestamp as time ago
    private func timeAgo(from date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: date, relativeTo: Date())
    }





struct TwitterCloneView_Previews: PreviewProvider {
    static var previews: some View {
        TwitterCloneView()
    }
}

