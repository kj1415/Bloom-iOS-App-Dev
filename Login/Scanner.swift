import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

struct MedicalRecordView: View {
    @State private var folderName: String = ""
    @State private var images: [UIImage] = []
    @State private var isImagePickerPresented: Bool = false
    @State private var folders: [MedicalFolder] = []

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter folder name", text: $folderName)
                    .padding()

                Button(action: {
                    isImagePickerPresented = true
                }) {
                    Text("Add Images")
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker1(images: $images)
                }

                Button(action: {
                    uploadImages()
                }) {
                    Text("Save")
                }

                List {
                    ForEach(folders) { folder in
                        NavigationLink(destination: FolderDetailView(folder: folder)) {
                            Text(folder.name)
                        }
                    }
                }
            }
            .navigationBarTitle("Medical Records")
        }
        .onAppear {
            fetchFolders()
        }
    }

    private func uploadImages() {
        let storageRef = Storage.storage().reference()
        let folderRef = storageRef.child("images/\(folderName)")

        // Upload images to Firebase Storage
        for (index, image) in images.enumerated() {
            guard let imageData = image.jpegData(compressionQuality: 0.5) else { continue }
            let filename = "\(index).jpg"
            let imageRef = folderRef.child(filename)
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"

            imageRef.putData(imageData, metadata: metadata) { _, error in
                if let error = error {
                    print("Error uploading image: \(error.localizedDescription)")
                } else {
                    print("Image uploaded successfully")
                }
            }
        }

        // Store folder information in Firestore
        let folder = MedicalFolder(name: folderName)
        Firestore.firestore().collection("folders").addDocument(data: folder.toDictionary()) { error in
            if let error = error {
                print("Error adding folder: \(error.localizedDescription)")
            } else {
                print("Folder added successfully")
                folderName = ""
                images.removeAll()
                fetchFolders()
            }
        }
    }

    private func fetchFolders() {
        Firestore.firestore().collection("folders").addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            folders = documents.compactMap { document in
                MedicalFolder(document: document)
            }
        }
    }

}

struct ImagePicker1: UIViewControllerRepresentable {
    @Binding var images: [UIImage]

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = context.coordinator
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        return imagePickerController
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker1

        init(parent: ImagePicker1) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.images.append(image)
            }
            picker.dismiss(animated: true, completion: nil)
        }
    }
}

struct MedicalFolder: Identifiable {
    let id: String
    let name: String

    init(name: String) {
        self.id = UUID().uuidString
        self.name = name
    }

    init(document: QueryDocumentSnapshot) {
        let id = document.documentID
        let name = document["name"] as! String
        self.id = id
        self.name = name
    }


    func toDictionary() -> [String: Any] {
        ["name": name]
    }
}

struct FolderDetailView: View {
    let folder: MedicalFolder

    var body: some View {
        Text("Folder: \(folder.name)")
    }
}
