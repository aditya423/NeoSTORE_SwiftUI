//
//  MyCartView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 15/01/24.
//

import SwiftUI

struct MyCartView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 0) {
                Color.red.edgesIgnoringSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: 1)
                Color.white.edgesIgnoringSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Image(ImageNames.username.rawValue)
                            .padding(.leading, 20)
                        VStack {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Pembroke")
                                    Text("(Table)")
                                }
                                Spacer()
                            }
                            HStack {
                                Button {
                                    // open pickerview
                                } label: {
                                    HStack {
                                        Text("1")
                                        Image(systemName: ImageNames.backArrow.rawValue)
                                    }
                                }
                                Spacer()
                                Text("Rs.45")
                                    .padding(.trailing, 20)
                            }
                        }
                        .padding(.leading, 20)
                    }
                    .padding([.top, .bottom], 15)
                    .background(.white)
                    Spacer()
                }
                .background(.yellow)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: ImageNames.backArrow.rawValue)
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold()
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
            }
            ToolbarItem(placement: .principal) {
                Text("My Cart")
                    .font(.title2)
                    .foregroundColor(.white)
                    .bold()
            }
        }
        .toolbarBackground(
            Color.red,
            for: .navigationBar
        )
    }
}

struct MyCartView_Previews: PreviewProvider {
    static var previews: some View {
        MyCartView()
    }
}
