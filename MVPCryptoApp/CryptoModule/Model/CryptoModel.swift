import Foundation

struct CryptoModel: Codable {
    let data: Crypto
}

struct Crypto: Codable {
    let marketData: MarketData
    let symbol: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case symbol, name
        case marketData = "market_data"
    }
}

struct MarketData: Codable {
    let priceUsd: Double?
    let percentChangeUsdLast24Hours: Double?

    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
        case percentChangeUsdLast24Hours = "percent_change_usd_last_24_hours"
    }
}

enum NameOfCrypto: String, CaseIterable {
    case btc      = "btc"
    case eth      = "eth"
    case tron     = "tron"
    case luna     = "luna"
    case polkadot = "polkadot"
    case dogecoin = "dogecoin"
    case stellar  = "stellar"
    case cardano  = "cardano"
    case xrp      = "xrp"
}

enum SortState {
    case up
    case down
}
