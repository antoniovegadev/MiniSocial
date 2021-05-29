//
//  ContentView.swift
//  MiniSocial
//
//  Created by Antonio Vega on 5/29/21.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()

    var body: some View {
        NavigationView {
            List(users, id: \.id) { user in
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.headline)
                    Text(user.company)
                }
                
                Spacer()
                
                user.statusImage
            }
            .navigationTitle("MiniSocial")
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let safeData = data {
                if let decoded = try? JSONDecoder().decode([User].self, from: safeData) {
                    DispatchQueue.main.async {
                        users = decoded
                    }
                    return
                }
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
