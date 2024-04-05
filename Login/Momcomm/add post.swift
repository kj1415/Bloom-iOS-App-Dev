import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore
import UIKit

//struct AddTweetView: View {
//    @State private var tweetText: String = ""
//    @State private var selectedImage: UIImage?
//    @State private var isImagePickerPresented = false
//    @State private var username: String?
//    @Environment(\.presentationMode) var presentationMode // Add presentationMode environment variable
//
//    // Firestore reference
//    private var db = Firestore.firestore()
//    // Firebase Storage reference
//    private var storage = Storage.storage().reference()
//    // Property to store UID
//    private var uid: String
//
//    init() {
//        // Retrieve UID when the view is initialized
//        self.uid = Auth.auth().currentUser?.uid ?? ""
//        // Fetch the username when the view is initialized
//        fetchUsername()
//    }
//
//    var body: some View {
//        ScrollView {
//            VStack {
//                Spacer()
//
//                Text("Compose a Babble")
//                    .font(.title)
//                    .foregroundColor(.blue)
//
//                Spacer()
//
//                // Display the username
//                if let username = username {
//                    Text("Welcome, \(username)!")
//                        .font(.headline)
//                        .foregroundColor(.gray)
//                        .padding()
//                }
//
//                // Tweet TextField
//                TextField("What's happening?", text: $tweetText)
//                    .padding()
//                    .background(Color.gray.opacity(0.1))
//                    .cornerRadius(10)
//                    .padding()
//
//                Spacer()
//
//                // Display selected image
//                if let selectedImage = selectedImage {
//                    Image(uiImage: selectedImage)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(maxWidth: .infinity, maxHeight: 200)
//                        .padding()
//                }
//
//                // Button to pick image
//                Button(action: {
//                    isImagePickerPresented.toggle()
//                }) {
//                    Text("Select Image")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                }
//                .padding()
//
//                Spacer()
//
//                Button(action: {
//                    // Implement the action to post the tweet
//                    postTweet()
//                }) {
//                    Text("Post")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                }
//                .padding()
//            }
//        }
//        .sheet(isPresented: $isImagePickerPresented) {
//            ImagePicker(image: $selectedImage)
//        }
//        .padding()
//    }


struct AddTweetView: View {
    @State private var tweetText: String = ""
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var username: String?
    @Environment(\.presentationMode) var presentationMode // Add presentationMode environment variable

    // Firestore reference
    private var db = Firestore.firestore()
    // Firebase Storage reference
    private var storage = Storage.storage().reference()
    // Property to store UID
    private var uid: String

    init() {
        // Retrieve UID when the view is initialized
        self.uid = Auth.auth().currentUser?.uid ?? ""
        // Fetch the username when the view is initialized
        fetchUsername()
    }

    var body: some View {
        VStack {
            Text("Compose a Babble")
                .font(.title)
                .foregroundColor(.blue)
                .padding()

            if let username = username {
                Text("Welcome, \(username)!")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
            }

            TextField("What's happening?", text: $tweetText)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding()

            Button(action: {
                isImagePickerPresented.toggle()
            }) {
                HStack {
                    Image(systemName: "photo")
                    Text("Select Image")
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
            }
            .padding()

            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .padding()
            }

            Button(action: {
                // Implement the action to post the tweet
                postTweet()
            }) {
                Text("Post")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $selectedImage)
        }
        .padding()
    }

    private func postTweet() {
        guard !tweetText.isEmpty else {
            // Add your validation logic here (if required)
            return
        }

        // Check if an image is selected
        if let image = selectedImage, let imageData = image.jpegData(compressionQuality: 0.5) {
            // Define image file name
            let imageFileName = UUID().uuidString
            // Create a reference to the file you want to upload
            let imageRef = storage.child("tweet_images/\(imageFileName)")

            // Upload the file to the path "tweet_images/<imageFileName>"
            let uploadTask = imageRef.putData(imageData, metadata: nil) { metadata, error in
                guard let metadata = metadata else {
                    print("Error uploading image to Firebase Storage: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                // You can then access the download URL for this image via metadata.downloadURL()
                imageRef.downloadURL { url, error in
                    guard let downloadURL = url else {
                        print("Error retrieving download URL: \(error?.localizedDescription ?? "Unknown error")")
                        return
                    }
                    // If image upload is successful, proceed to post the tweet with the shortened URL
                    saveTweet(imageURL: downloadURL.absoluteString)
                }
            }

            // Observe and report upload progress
            uploadTask.observe(.progress) { snapshot in
                // Upload progress
                let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
                print("Upload progress: \(percentComplete)%")
            }
        } else {
            // If no image is selected, post the tweet without an image
            saveTweet(imageURL: nil)
        }
    }

    private func saveTweet(imageURL: String?) {
        // Fetch the username associated with the UID from Firestore
        db.collection("users").document(uid).getDocument { userDocument, error in
            if let userDocument = userDocument, userDocument.exists {
                if let username = userDocument["username"] as? String {
                    // If username is successfully fetched, proceed to post the tweet
                    var tweetData: [String: Any] = [
                        "uid": uid,
                        "username": username,
                        "text": tweetText,
                        "timestamp": FieldValue.serverTimestamp()
                    ]
                    // Add imageURL to tweetData if available
                    if let imageURL = imageURL {
                        tweetData["imageURL"] = imageURL
                    }
                    // Save the tweet data to the "tweets" collection
                    db.collection("tweets").addDocument(data: tweetData) { tweetError in
                        if let tweetError = tweetError {
                            print("Error saving tweet to Firestore: \(tweetError.localizedDescription)")
                        } else {
                            // Successfully saved tweet
                            print("Tweet successfully saved to Firestore")
                            // Optionally, you can also reset the text field after posting
                            tweetText = ""
                            // Automatically navigate back to the previous page
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            } else {
                print("Error fetching username: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }

    private func fetchUsername() {
        // Fetch the username associated with the UID from Firestore
        db.collection("users").document(uid).getDocument { document, error in
            if let document = document, document.exists {
                if let username = document["username"] as? String {
                    self.username = username
                }
            } else {
                print("Error fetching username: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}

struct AddTweetView_Previews: PreviewProvider {
    static var previews: some View {
        AddTweetView()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
