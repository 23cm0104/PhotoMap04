import SwiftUI
import MapKit
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: MarkerItem.entity(),
        sortDescriptors: [NSSortDescriptor(key: "updateTime", ascending: false)],
        animation: .default)
    private var items: FetchedResults<MarkerItem>
    @StateObject var locationManager = LocationManager()
    @State private var showAddItemView = false
    @State private var position: MapCameraPosition = .region(MKCoordinateRegion(center: .jec, span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1)))
    @State var selectedAnnotation: MarkerItem?
    func setPostion(latitude: Double, longitude: Double) {
        position = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude,longitude: longitude), span: .init(latitudeDelta: 0.03, longitudeDelta: 0.03)))
    }
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottomTrailing) {
                Map(position: $position) {
                    UserAnnotation()
                    ForEach(items) { item in
                        Annotation("\(item.title ?? "")\n\(item.address ?? "")", coordinate: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)) {
                            VStack {
                                Image(systemName: "star.circle.fill")
                                    .foregroundColor(Color(.sRGB, red: Double(item.red), green: Double(item.green), blue: Double(item.blue)))
                                    .font(.system(size: 20))
                                Image(uiImage: UIImage(data: item.imageData!)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60)
                                    .onTapGesture {
                                        setPostion(latitude: item.latitude, longitude: item.longitude)
                                        selectedAnnotation = item
                                    }
                            }
                        }
                    }
                }
                .mapControls {
                    MapUserLocationButton().mapControlVisibility(.visible)
                    MapPitchToggle()
                    MapCompass()
                    MapScaleView().mapControlVisibility(.hidden)
                        .sheet(item: $selectedAnnotation){ item in
                            ItemInfoView(address: item.address, imageData: item.imageData , comment: item.comment, title: item.title ,red: item.red, green:  item.green, blue:  item.blue, love: item.love).presentationDetents([.medium, .large]).presentationDragIndicator(.hidden)
                        }
                }
                VStack{
                    NavigationLink(destination: ListView()) {
                        Image(systemName: "list.bullet.rectangle.portrait")
                            .font(.title)
                            .padding()
                            .background(.white)
                            .foregroundColor(.blue)
                            .clipShape(Circle())
                            .shadow(radius: 4, x: 0, y: 4)
                            .padding(.trailing)
                    }
                    NavigationLink(destination: AddMarkerItemView()) {
                        Image(systemName: "plus")
                            .font(.title)
                            .padding()
                            .background(.white)
                            .foregroundColor(.blue)
                            .clipShape(Circle())
                            .shadow(radius: 4, x: 0, y: 4)
                            .padding([.trailing, .top])
                    }
                }
            }
        }
    }
}

extension CLLocationCoordinate2D {
    static let shinjukuStation =
    CLLocationCoordinate2D(latitude: 35.6896646, longitude: 139.6999667)
    static let jec =
    CLLocationCoordinate2D(latitude: 35.6982316, longitude: 139.6981199)
}

#Preview {
    ContentView()
}
