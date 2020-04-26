//
//  ContentView.swift
//  BarButtonSwiftUI
//
//  Created by Yvette Zhukovsky on 4/26/20.
//  Copyright © 2020 bumnetworks. All rights reserved.
//

import SwiftUI

struct NavigationConfigurator: UIViewControllerRepresentable {
    var novConfigure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    
    func setButton(_ uivc: UIViewController){
        if let nc = uivc.navigationController {
            nc.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
            nc.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
            
            if let parent = uivc.parent {
                setButton(parent)
            }
        }
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let navController = uiViewController.navigationController {
            self.novConfigure(navController)
        }
    }
}


struct SwiftUIView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: SwiftUIView2()) {
                Text("go")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())

    }
}
struct SwiftUIView2: View {
    var body: some View {
        NavigationView {
            ScrollView {
                Text("Hello")
            }
            .navigationBarTitle("Navigation Bar", displayMode: .inline)
            .background(NavigationConfigurator { nc in
                nc.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Hello", style: .done, target: self, action: nil)
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
