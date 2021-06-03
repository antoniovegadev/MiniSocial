//
//  UserView.swift
//  MiniSocial
//
//  Created by Antonio Vega on 5/29/21.
//

import SwiftUI

struct UserView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var showFriends = false

    let userId: String
    var fetchRequest: FetchRequest<User>
    
    var result: FetchedResults<User> {
        return fetchRequest.wrappedValue
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        if result.isEmpty {
            VStack{
                Text("No user found with ID \(userId).")
            }
            .navigationTitle("Exception")
        } else {
            let user = result.first!
            
            GeometryReader { geo in
                ScrollView {
                    ZStack {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: geo.size.width*0.4, height: geo.size.width*0.4)
                        
                        user.statusImageDynamic
                            .frame(width: geo.size.width*0.1, height: geo.size.width*0.1)
                            .offset(x: geo.size.width*0.125, y: geo.size.width*0.15)
                    }
                    
                    Text(user.name)
                        .font(.title)
                    
                    VStack(alignment: .leading) {
                        InLineTextView(title: "Age", contents: String(user.age))
                        InLineTextView(title: "Email", contents: user.email)
                        InLineTextView(title: "Address", contents: user.address)
                        InLineTextView(title: "Company", contents: user.company)
                        InLineTextView(title: "Registered", contents: user.formattedDate)
                    }
                    
                    HStack {
                        Text("Friends")
                            .font(.headline)
                        Image(systemName: "person.fill")
                            .imageScale(.medium)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                self.showFriends.toggle()
                            }
                        }) {
                            Image(systemName: "chevron.right.circle")
                                .imageScale(.large)
                                .rotationEffect(.degrees(showFriends ? 90 : 0))
                                .padding()
                        }
                    }
                    .padding()
                    
                    if showFriends {
                        LazyVGrid(columns: columns, spacing: 25) {
                            ForEach(user.friendsList, id: \.id) { friend in
                                NavigationLink(destination: UserView(userId: friend.id)) {
                                    VStack {
                                        Image(systemName: "person.crop.circle")
                                            .resizable()
                                            .frame(width: geo.size.width*0.2, height: geo.size.width*0.2)
                                        Text(friend.name)
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .transition(.slideDownAndUp)
                    }
                }
            }
        }
    }
    
    init(userId: String) {
        self.userId = userId
        fetchRequest = FetchRequest<User>(entity: User.entity(),
                                          sortDescriptors: [],
                                          predicate: NSPredicate(format: "id == %@", userId))
    }
}

extension AnyTransition {
    static var slideDownAndUp: AnyTransition {
        let insertion = AnyTransition.scale
        let removal = AnyTransition.move(edge: .trailing)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(userId: "1")
    }
}
