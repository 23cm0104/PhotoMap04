import SwiftUI
import PhotosUI

struct AddMarkerItemView: View {
    @State var isShowActivity = false
    @State var isShowSheet = false
    @State var isShowAction = false
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    @StateObject private var locationManager = LocationManager()
    @StateObject private var address = AddressFetcher()
    @State private var title = ""
    @State private var comment = ""
    @State private var imageData: Data = Data()
    @State var selectedItem: PhotosPickerItem?
    @State private var uiImage: UIImage?
    @State private var markerColor = Color.blue
    var longitude: Double {
        locationManager.currentLocation?.coordinate.longitude ?? 0
    }
    var latitude: Double {
        locationManager.currentLocation?.coordinate.latitude ?? 0
    }
    var body: some View {
        NavigationStack{
            VStack {
                TextField("タイトル", text: $title)
                    .font(.title)
                    .border(.black)
                TextEditor(text: $comment)
                    .font(.body)
                    .border(.black)
                ColorPicker("マーク色", selection: $markerColor)
                HStack {
                    if let uiImage = uiImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .border(.black)
                    } else {
                        Image("noimage")
                            .resizable()
                            .frame(height: 200)
                            .aspectRatio(contentMode: .fit)
                            .border(.black)
                    }
                    Spacer()
                    PhotosPicker(selection: $selectedItem) {
                        Image(systemName: "photo.artframe.circle")
                            .font(.system(size: 50))
                    }
                    .onChange(of: selectedItem) { oldItem, newItem in
                        Task {
                            guard let data = try? await newItem?.loadTransferable(type: Data.self) else { return }
                            guard let uiImage = UIImage(data: data) else { return }
                            imageData = data
                            self.uiImage = uiImage
                        }
                    }
                }
                Button(action: {
                    isShowSheet = true
                }, label: {
                    Text("カメラ")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .multilineTextAlignment(.center)
                        .background(.blue)
                        .foregroundColor(.white)
                })
                .sheet(isPresented: $isShowSheet) {
                    ImagePickerView(isShowSheet: $isShowSheet, captureImage: $uiImage)
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        addItem()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("保存")
                    }
                }
            }.task {try? await address.fetchData(longitude: longitude, latitude: latitude)}
        }
    }
    private func addItem() {
        withAnimation {
            let newItem = MarkerItem(context: viewContext)
            let image = uiImage
            let defaultImage = UIImage(named: "noimage")
            let uiColor = UIColor(markerColor)
            var r: CGFloat = 0.0
            var g: CGFloat = 0.0
            var b: CGFloat = 0.0
            var a: CGFloat = 0.0
            uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)
            newItem.title = title
            newItem.comment = comment
            newItem.address = address.addressList[0].prefecture + address.addressList[0].city + address.addressList[0].town
            newItem.createdTime = Date()
            newItem.updateTime = Date()
            newItem.latitude = locationManager.currentLocation?.coordinate.latitude ?? 0.0
            newItem.longitude = locationManager.currentLocation?.coordinate.longitude ?? 0.0
            newItem.imageData = image?.pngData() ?? defaultImage?.pngData()
            newItem.red = Float(r)
            newItem.green = Float(g)
            newItem.blue = Float(b)
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
