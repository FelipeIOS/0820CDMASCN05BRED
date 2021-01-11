
import Foundation

// MARK: - Locais
struct Locais: Codable {
    let agencias: [Agencia]
}

// MARK: - Agencia
struct Agencia: Codable {
    let title, subtitle, categoria, lat: String
    let lng: String
}
