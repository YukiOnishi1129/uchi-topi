//
//  uchi_topiApp.swift
//  uchi-topi
//
//  Created by 大西雄貴 on 2025/09/24.
//

import SwiftUI
#if os(iOS)
import UIKit
#endif
// import Firebase // Firebaseを後で追加

@main
struct uchi_topiApp: App {
    
    init() {
        setupApp()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    setupAppearance()
                }
        }
    }
    
    /// アプリケーションの初期設定
    private func setupApp() {
        // Firebase初期化（後で有効化）
        // FirebaseApp.configure()
        
        // UserDefaults初期設定
        if UserDefaults.standard.object(forKey: Constants.UserDefaultsKeys.isFirstLaunch) == nil {
            UserDefaults.standard.set(true, forKey: Constants.UserDefaultsKeys.isFirstLaunch)
        }
    }
    
    /// UIの外観設定
    private func setupAppearance() {
        #if os(iOS)
        // ナビゲーションバーの外観設定
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = UIColor.systemBackground
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.label
        ]
        navigationBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.label
        ]
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        // タブバーの外観設定
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = UIColor.systemBackground
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        #endif
    }
}