//
//  LocationSearchView.swift
//  servicesForYourBF
//
//  Created by Omar Rodriguez on 12/5/22.
//

import SwiftUI

struct LocationSearchView: View {
    @State private var startLocationText = ""
    @Binding var mapState: MapViewState
    @EnvironmentObject var viewModel: LocationSearchViewModel
    var body: some View {
        VStack {
            HStack{
                TextField ("Where do you want the service?", text: $viewModel.queryfragment)
                    .frame(height: 32)
                    .background(Color(.systemGray4))
                    .padding()
            }
            .padding(.horizontal)
            .padding(.top , 64)
            
            Divider()
                .padding(.vertical)
            //List
            
            ScrollView{
                VStack(alignment: .leading) {
                    ForEach(viewModel.result, id: \.self){ result in
                        LocationSearchResulCell(title: result.title, subtitle: result.subtitle).onTapGesture {
                            withAnimation(.spring()){
                                viewModel.selectLocation(result)
                                mapState = .locationSelected
                            }
                            
                        }
                    }
                }
            }
        }
        .background(Color.theme.backgroundColor)
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(mapState: .constant(.searchingForLocation))
    }
}
