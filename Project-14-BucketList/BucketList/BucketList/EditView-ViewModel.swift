import Foundation

extension EditView { // Current Project Challlenge 3
    @Observable
    class ViewModel {
        private(set) var location: Location
        var name: String
        var description: String
        var loadingState = LoadingState.loading
        var pages = [Page]()
        
        enum LoadingState {
            case loading, loaded, failed
        }
        
        init(location: Location) {
            self.location = location
            _name = location.name
            _description = location.description
        }
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            // create URL
            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }
            
            do { // fetch
                let (data, _) = try await URLSession.shared.data(from: url)// _ means ignore the response
                
                // if we are still here means we got some data back!, then decode it into a Result.
                let items = try JSONDecoder().decode(Result.self, from: data)
                
                // success – convert the array values to our pages array
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
            } catch {
                // if we're still here it means the request failed somehow
                loadingState = .failed
            }
        }
    }
}
