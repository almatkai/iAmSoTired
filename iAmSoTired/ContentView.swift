//
//  ContentView.swift
//  iAmSoTired
//
//  Created by Almat Kairatov on 03.01.2023.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @ObservedObject var app: RealmSwift.App
    
    var body: some View {
        if let user = app.currentUser {
            let config = user.flexibleSyncConfiguration(initialSubscriptions: { subs in
                if let foundSubscription = subs.first(named: "user_notes"), let foundSubscription2 = subs.first(named: "user_subnotes") {
                    // Existing subscription found - do nothing
                    return
                } else {
                    subs.append(QuerySubscription<Note>(name: "user_notes") {
                        $0.owner_id == user.id
                    })
                    subs.append(QuerySubscription<SubNote>(name: "user_subnotes"))
                }
            })
            OpenRealmView(user: user).environment(\.realmConfiguration, config)
        } else {
            // If there is no user logged in, show the login view.
            LoginView()
        }
    }
}
