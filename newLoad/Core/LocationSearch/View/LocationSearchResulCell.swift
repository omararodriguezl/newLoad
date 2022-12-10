//
//  LocationSearchResulCell.swift
//  servicesForYourBF
//
//  Created by Omar Rodriguez on 12/5/22.
//

import SwiftUI

struct LocationSearchResulCell: View {
    let title: String
    let subtitle: String
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.red)
                .accentColor(.white)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.body)
                
                Text(subtitle)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                
                Divider()
            }
            .padding(.leading, 8)
            .padding(.vertical, 8)
        }
        .padding(.leading)
    }
}

struct LocationSearchResulCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchResulCell(title: "Smart Pet", subtitle: "123 main St")
    }
}
