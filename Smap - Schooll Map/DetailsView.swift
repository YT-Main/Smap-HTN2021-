//
//  DetailsView.swift
//  Smap
//
//  Created by Yash Trivedi on 2021-09-17.
//
import MapKit
import SwiftUI

struct DetailsView: View {
    var locationData = [
        Location(name : "Student Life Center SLC",wifi: false,people: 42,friends: ["Yash", "Dwayne", "Ingrid", "Pav", "Jamie"],score: 4,quiet:false,latitude: 43.4716,longitude: -80.5453,power: false, num: 0),
        
        Location(name: "Engineering 7",wifi: true,people: 12,friends: ["Ingrid", "Pav", "Jamie"],score: 4,quiet:false,latitude: 43.4728,longitude: -80.5397,power: true, num: 1),
        
        Location(name: "Williams Fresh Cafe",wifi: false,people: 20,friends: ["none"],score: 5,quiet:false,latitude: 43.4724,longitude: -80.5387,power: false, num: 2),
        
        Location(name: "CMH Hall",wifi: true,people: 52,friends: ["Jamie"],score: 2,quiet: false,latitude: 43.458759,longitude: -80.539680,power: true, num: 3),
        
        Location(name: "Dana Porter Library",wifi: true,people: 42,friends: ["Yash", "Dwayne", "Ingrid", "Pav", "Jamie"],score: 4,quiet: true,latitude: 43.4697504,longitude: -80.5423533,power: true, num: 4),
        
        Location(name: "DC Library",wifi: true,people: 2,friends: ["none"],score: 2,quiet: true,latitude: 43.4729293,longitude: -80.5420011,power: true, num: 5)
    ]
    
    
    
    @State var location: Int
    
    let courses = [
        Course(name: "CS135", members: 24, active: 5, courseNum: 2),
        Course(name: "MATH137", members: 4, active: 2, courseNum: 1),
        Course(name: "MATH135", members: 24, active: 1, courseNum: 0),
    ]
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.4723, longitude: -80.5449), span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003))
    var body: some View {
        VStack{
            Map(coordinateRegion: $region, showsUserLocation: false,  annotationItems: locationData){ place in
                MapMarker(coordinate: place.coordinate)
                //MapMarker(coordinate: place.coordinate)
                
            }.edgesIgnoringSafeArea(.all)
            .frame(height: 100)
            VStack{
                Text(locationData[location].name)
                    .font(.largeTitle)
                    .bold()
                HStack{
                    Image("dual-profile")
                        .resizable()
                        .frame(width: 60, height: 55)
                    if locationData[location].friends[0] != "none"{
                        HStack{
                            Text(locationData[location].friends[0])
                            Text(" and ")
                            Text(String(locationData[location].friends.capacity-1))
                            Text(" others in this study space")
                        }
                    }
                    else{
                        Text("You have no friends working here")
                    }
                }
                Text("Active Courses")
                List{
                    ForEach(courses){ course in
                        NavigationLink(destination: CourseView(courseID: course.courseNum), label: {
                            VStack(alignment: .leading){
                                Text(course.name)
                                HStack{
                                    Image(systemName: "person")
                                    Text(String(course.members))
                                    Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                    Text(String(course.active))
                                }
                                
                            }
                        })
                    }
                }.background(Color.clear)
                Link("Take Me There", destination: URL(string: "https://www.google.com/maps/place/Turnkey+Desk/@43.4716415,-80.5453385,15z/data=!4m5!3m4!1s0x0:0x6a103714f7b2accf!8m2!3d43.4716415!4d-80.5453385")!)
                
            }
            Spacer()
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
