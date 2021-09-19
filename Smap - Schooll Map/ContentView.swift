
//
//  ContentView.swift
//  Smap
//
//  Created by Yash Trivedi on 2021-09-17.
//

import SwiftUI
import CoreLocation
import MapKit

struct Location: Codable, Identifiable {
    
    var id = UUID()
    var name: String
    var wifi: Bool
    var people: Int
    var friends: [String]
    var score: Int
    var quiet: Bool
    var latitude: Double
    var longitude: Double
    var power: Bool
    var coordinate: CLLocationCoordinate2D{CLLocationCoordinate2D(latitude: latitude, longitude: longitude)}
    var num: Int
    
}
struct Course: Identifiable{
    let id = UUID()
    let name: String
    let members: Int
    let active: Int
    let courseNum: Int
    
    
}


struct ContentView: View {

    
    var locationData = [
        Location(name : "Student Life Center SLC",wifi: false,people: 42,friends: ["Yash", "Dwayne", "Ingrid", "Pav", "Jamie"],score: 4,quiet:false,latitude: 43.4716,longitude: -80.5453,power: false, num: 0),
        
        Location(name: "Engineering 7",wifi: true,people: 12,friends: ["Ingrid", "Pav", "Jamie"],score: 4,quiet:false,latitude: 43.4728,longitude: -80.5397,power: true, num: 1),
        
        Location(name: "Williams Fresh Cafe",wifi: false,people: 20,friends: ["none"],score: 5,quiet:false,latitude: 43.4724,longitude: -80.5387,power: false, num: 2),
        
        Location(name: "CMH Hall",wifi: true,people: 52,friends: ["Jamie"],score: 2,quiet: false,latitude: 43.458759,longitude: -80.539680,power: true, num: 3),
        
        Location(name: "Dana Porter Library",wifi: true,people: 42,friends: ["Yash", "Dwayne", "Ingrid", "Pav", "Jamie"],score: 4,quiet: true,latitude: 43.4697504,longitude: -80.5423533,power: true, num: 4),
        
        Location(name: "DC Library",wifi: true,people: 2,friends: ["none"],score: 2,quiet: true,latitude: 43.4729293,longitude: -80.5420011,power: true, num: 5)
    ]

    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.4706, longitude: -80.541382), span: MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007))
    
    
    var body: some View {
        NavigationView{
            ZStack{
                Map(coordinateRegion: $region, showsUserLocation: false,  annotationItems: locationData){ location in
                    MapMarker(coordinate: location.coordinate)
                    //MapMarker(coordinate: place.coordinate)
                    
                }.edgesIgnoringSafeArea(.all)
                NavigationLink(destination: ProfileView(), label: {
                    Text("Profile")
                })
                HStack(spacing: 10) {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(locationData){ location in
                                NavigationLink(destination: DetailsView(location:location.num), label:{
                                    VStack {
                                        Text(location.name).font(.custom("Avenir", size: 15)).foregroundColor(.black)
                                        HStack {
                                            if location.wifi == true{
                                                Image(systemName: "wifi").imageScale(.small).foregroundColor(.green)
                                            }
                                            else{
                                                Image(systemName: "wifi").imageScale(.small).foregroundColor(.yellow)
                                            }

                                            HStack (spacing: 0, content: {
                                                Text(String(location.people)).font(.custom("Avenir", size: 14))
                                                Image(systemName: "person.fill").imageScale(.small)
                                            })
                                            if location.power == true{
                                                Image(systemName: "bolt.fill").imageScale(.small).foregroundColor(.yellow)
                                            }
                                            else{
                                                Image(systemName: "bolt.fill").imageScale(.small).foregroundColor(.red)
                                            }
                                            
                                            Image(systemName: "speaker.slash").imageScale(.small)
                                        }
                                    }.frame(width: 200, height: 80)
                                    .background(Color.white)
                                })
                            }.background(Color.clear).cornerRadius(20)
                        }
                    }.padding(10)
                }.frame(height: 415, alignment: .bottom)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
