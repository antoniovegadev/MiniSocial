//
//  ContentView.swift
//  MiniSocial
//
//  Created by Antonio Vega on 5/29/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var users: FetchedResults<User>

    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink(destination: UserView(userId: user.id)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.headline)
                            Text(user.company)
                        }
                        
                        Spacer()
                        
                        user.statusImageFixed
                    }
                }
            }
            .navigationTitle("MiniSocial")
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        if(!users.isEmpty) {
            return
        }
        
        let decoder = JSONDecoder()
        
        decoder.userInfo[CodingUserInfoKey.managedObjectContext!] = moc
        decoder.dateDecodingStrategy = .iso8601
        
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let safeData = data {
                _ = try? decoder.decode([User].self, from: safeData)
                return
            }

            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
