enum URLBuilder {
    static func buildCatListURL(page: Int = 0) -> String {
        "https://api.thecatapi.com/v1/images/search?page=\(page)&limit=20&order=DESC&has_breeds=true"
    }
}
