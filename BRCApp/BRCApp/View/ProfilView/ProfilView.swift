import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ProfilView: View {
    @ObservedObject var profilViewModel: ProfilViewModel

    init() {
        self.profilViewModel = ProfilViewModel()
    }

    var body: some View {
        List {
            if let user = profilViewModel.user {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Profil")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.bottom, 20)

                        ProfileDetail(title: "Name", value: "\(user.name) \(user.lastName)")
                        ProfileDetail(title: "E-Mail", value: user.eMail)
                        ProfileDetail(title: "Alter", value: user.age)
                        ProfileDetail(title: "Skull", value: user.skull ? "Ja" : "Nein")
                        ProfileDetail(title: "Riemen", value: user.riemen ? "Ja" : "Nein")
                        ProfileDetail(title: "Backboard", value: user.bb ? "Ja" : "Nein")
                        ProfileDetail(title: "Steuerboard", value: user.sb ? "Ja" : "Nein")
                        ProfileDetail(title: "Hängerführerschein", value: user.trailerDrivingLicence ? "Ja" : "Nein")
                        ProfileDetail(title: "Admin", value: user.admin ? "Ja" : "Nein")
                    }
              
                }
            } else {
                Text("Lade Benutzerdaten...")
                    .padding()
            }
        }
        .onAppear {
            profilViewModel.fetchCurrentUser()
        }
    }
}

// Hilfsstruktur für das Darstellen von Profildetails
struct ProfileDetail: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title + ":")
                .fontWeight(.bold)
            Text(value)
               
        } .padding(.bottom,5)
    }
}
