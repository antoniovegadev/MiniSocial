//
//  UserView.swift
//  MiniSocial
//
//  Created by Antonio Vega on 5/29/21.
//

import SwiftUI

struct UserView: View {
    let users: [User]
    let user : User
    
    init(user: User, users: [User]) {
        self.user = user
        self.users = users
    }
    
    init(id: String, users: [User]) {
        self.user = users.first(where: { $0.id == id })!
        self.users = users
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
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
                Text(user.company)
                Text(user.email)
                Text(user.address)
                    .padding(.bottom)
                
                Text("About")
                    .font(.headline)
                    .underline()
                Text(user.about)
                    .padding(.horizontal)
                
                Text("Friends")
                    .font(.headline)
                    .underline()
                LazyVGrid(columns: columns, spacing: 25) {
                    ForEach(user.friends, id: \.id) { friend in
                        NavigationLink(destination: UserView(id: friend.id, users: users)) {
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
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static let user = User(id: "50a48fa3-2c0f-4397-ac50-64da464f9954", isActive: true, name: "Alford Rodriguez", age: 21, company: "Imkan", email: "alfordrodriguez@imkan.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.\r\n", registered: "2015-11-10T01:47:18-00:00", tags: [
        "cillum",
        "consequat",
        "deserunt",
        "nostrud",
        "eiusmod",
        "minim",
        "tempor"
    ], friends: [])
    static var previews: some View {
        UserView(user: user, users: [])
    }
}
