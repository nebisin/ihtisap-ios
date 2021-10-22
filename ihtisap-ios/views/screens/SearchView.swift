//
//  SearchView.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var userStore: UserStore
    
    @StateObject var vm = SearchTabViewModel()
    @State var searchTerm = ""
    
    var body: some View {
        NavigationView {
            Group {
                if vm.isLoading {
                    ProgressView()
                } else if vm.result.isEmpty {
                    Text("We can't find anything")
                } else {
                    List(vm.result) { item in
                        AppTransactionItem(ts: item)
                    }
                    
                }
            }
            .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always))
            .onSubmit(of: .search) {
                search(term: searchTerm)
            }
            .onChange(of: searchTerm) { newValue in
                search(term: searchTerm)
            }
            .onAppear {
                search(term: searchTerm)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Search Transaction")
        }
        
    }
    
    func search(term: String) {
        guard let token = userStore.authToken else {
            return
        }
        
        if vm.isLoading {
            return
        }
        
        Task {
            if term.count == 0 {
                let _ = await vm.searchTransaction(token: token, term: "")
            } else {
                let _ = await vm.searchTransaction(token: token, term: "\(term):*")
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(UserStore.mockData())
    }
}
