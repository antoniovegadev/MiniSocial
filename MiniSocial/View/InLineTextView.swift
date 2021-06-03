//
//  InLineTextView.swift
//  MiniSocial
//
//  Created by Antonio Vega on 6/1/21.
//

import SwiftUI

struct InLineTextView: View {
    let title: String
    let contents: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text("\(title)")
                .bold()
            Text(contents)
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding()
        .background(Color.secondary)
        .clipShape(Capsule())
        
    }
}

struct InLineTextView_Previews: PreviewProvider {
    static var previews: some View {
        InLineTextView(title: "Company", contents: "Amazon")
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
