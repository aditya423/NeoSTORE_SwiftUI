//
//  ProductListView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 15/01/24.
//

import SwiftUI
//MARK: - ProductListView
struct ProductListView: View {
    //State Objects
    @State var searchText = ""
    @State var isSearchTextFieldHidden = true
    @State private var timer: Timer? = nil
    @ObservedObject var viewModel = ProductListViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var categoryId: Int?
    init(categoryId: Int?) {
           self.categoryId = categoryId
           viewModel.getProductList(categoryId: String((categoryId ?? 0) + 1))
    }
    
    //Body
    var body: some View {
        VStack(spacing: 0){
            Color.red.edgesIgnoringSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: 1)
            VStack{
                // For Search Bar
                if !isSearchTextFieldHidden{
                    TextField("Search",text: $searchText)
                        .onChange(of: searchText) { newValue in
                                       timer?.invalidate()
                                       timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
                                           viewModel.filterProducts(text:searchText)
                                       }
                                   }
                    .frame(maxWidth: .infinity,maxHeight: 50)
                    .padding(.leading)
                    .background(.white)
                    .cornerRadius(5)
                    .padding([.leading,.trailing,.top], 20)
                }
                // If Data Received reload View else show Loader
                if viewModel.dataReceived {
                    List{
                        ForEach(0..<(viewModel.filterProductList.count ), id: \.self) { index in
                            ZStack{
                                ProductListCell(productData: viewModel.filterProductList[index])
                                NavigationLink(destination: ProductDetailsView(productId: viewModel.filterProductList[index].id)) {
                                    EmptyView()
                                }
                                .opacity(0)
                            }
                            //On Appear API Call with pagination
                                .onAppear {
                                    if index == ((viewModel.filterProductList.count ) - 1) {
                                        viewModel.page += 1
                                        viewModel.getProductList(categoryId: String((categoryId ?? 0) + 1))
                                    }
                                }
                                .listRowInsets(EdgeInsets(top: (index == 0 ? 20 : 0), leading: 10, bottom: 0, trailing: 0))
                                .padding(0)
                            Rectangle()
                                .frame(maxWidth: .infinity,maxHeight: 1)
                                .foregroundColor(AppColors.grayColor)
                                  .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                  .padding(0)
                        }
                        .listRowSeparator(.hidden)
                    }
                } else {
                    LoaderView(bgColor: AppColors.grayColor, tintColor: Color.red)
                }
            }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 242/255, green: 242/255, blue: 247/255))
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitleDisplayMode(.automatic)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: ImageNames.backArrow.rawValue)
                        .font(.title3)
                        .foregroundColor(.white)
                        .bold()
                }
            }
            ToolbarItem(placement: .principal) {
                Text((HomeViewModel.furnitureData[categoryId ?? 0]?["name"] as? String ?? ""))
                    .font(.title2)
                    .foregroundColor(.white)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    self.isSearchTextFieldHidden.toggle()
                } label: {
                    Image(ImageNames.search.rawValue)
                        .font(.title3)
                        .foregroundColor(.white)
                        .bold()
                }
            }
        }
        .toolbarBackground(
            AppColors.primaryColor,
            for: .navigationBar
        )
                }
    }
}
//preview
struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(categoryId: 2)
    }
}
