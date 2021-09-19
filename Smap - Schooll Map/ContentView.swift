
import SwiftUI
import CoreLocation
import MapKit

struct ContentView: View {
    var locationData = [
        Location(name : "Student Life Center SLC",wifi: false,people: 42,friends: ["Yash", "Dwayne", "Ingrid", "Pav", "Jamie"],score: 4,quiet:false,latitude: 43.4716,longitude: -80.5453,power: false, num: 0),
        
        Location(name: "Engineering 7",wifi: true,people: 12,friends: ["Ingrid", "Pav", "Jamie"],score: 4,quiet:false,latitude: 43.4728,longitude: -80.5397,power: true, num: 1),
        
        Location(name: "Williams Fresh Cafe",wifi: false,people: 20,friends: ["none"],score: 5,quiet:false,latitude: 43.4724,longitude: -80.5387,power: false, num: 2),
        
        Location(name: "CMH Hall",wifi: true,people: 52,friends: ["Jamie"],score: 2,quiet: false,latitude: 43.458759,longitude: -80.539680,power: true, num: 3),
        
        Location(name: "Dana Porter Library",wifi: true,people: 42,friends: ["Yash", "Dwayne", "Ingrid", "Pav", "Jamie"],score: 4,quiet: true,latitude: 43.4697504,longitude: -80.5423533,power: true, num: 4),
        
        Location(name: "DC Library",wifi: true,people: 2,friends: ["none"],score: 2,quiet: true,latitude: 43.4729293,longitude: -80.5420011,power: true, num: 5)
    ]
    
    let courses = [
        Course(name: "CS135", members: 24, active: 5, courseNum: 2),
        Course(name: "MATH137", members: 4, active: 2, courseNum: 1),
        Course(name: "MATH135", members: 24, active: 1, courseNum: 0),
    ]
    
    var coursesDeat = [
        CourseDetail(name: "MATH 135", description: "Introduction to math through proofs", email: "math135@uwaterloo.ca", page: "https://learn.uwaterloo.ca/d2l/home/709642", todo: ["Written assignment 2", "Mobius Quiz 4", "Mobius Quiz 5", "Mobius Quiz 6"]),
        CourseDetail(name: "MATH 137", description: "Introduction to math through calculus", email: "math137@uwaterloo.ca", page: "https://learn.uwaterloo.ca/d2l/home/709966", todo: ["Written assignment 2", "Mobius Quiz 2"]),
        CourseDetail(name: "CS 135", description: "Introduction to cs through raket", email: "cs135@uwaterloo.ca", page: "https://student.cs.uwaterloo.ca/~cs135/", todo: ["Written assignment 2", "Mobius Quiz 2"])
    ]
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.4706, longitude: -80.541382), span: MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007))
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    VStack(alignment: .leading){
                        Text("Hello, Yash!").font(.largeTitle)
                            .bold()
                        
                        Text("Todo")
                        
                        ForEach(coursesDeat){course in
                            ForEach(course.todo, id: \.self){thing in
                                HStack{
                                    CheckBox(checked: false)
                                    Text(thing)
                                }
                            }
                            
                        }
                    }
                    VStack(){
                        Spacer()
                        Text("Current Classes").font(.title2)
                        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20){
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
                            }.frame(width: 100,height: 80)
                            .background(Color.white)
                        }
                        Spacer()
                        Text("Study Locations").font(.title2)
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
                        }
                        NavigationLink(
                            destination: MapView(),
                            label: {
                                
                                Map(coordinateRegion: $region, showsUserLocation: false,  annotationItems: locationData){ location in
                                    MapMarker(coordinate: location.coordinate)
                                }.edgesIgnoringSafeArea(.all)
                                .frame(width: 375,height: 300)
                                .cornerRadius(25.0)
                            })
                    }
                }
            }
        }.edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
