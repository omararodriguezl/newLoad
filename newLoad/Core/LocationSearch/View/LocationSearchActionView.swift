//
//  LocationSearchActionView.swift
//  servicesForYourBF
//
//  Created by Omar Rodriguez on 12/5/22.
//

import SwiftUI

struct LocationSearchActionView: View {
    var body: some View {
        HStack{
            Rectangle()
                .fill(Color.black)
                .frame(width: 8, height: 8)
                .padding(.horizontal)
            Text("Where do you want the service?")
                .foregroundColor(Color(.darkGray))
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64, height: 50)
        .background(
            Rectangle()
                .fill(Color.white)
                .shadow(color: .black, radius: 6)
        )
    }
}

struct LocationSearchActionView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchActionView()
    }
}
