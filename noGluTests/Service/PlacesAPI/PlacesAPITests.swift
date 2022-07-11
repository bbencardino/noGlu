import XCTest
@testable import noGlu

class PlacesAPITests: XCTestCase {

    var sut: PlacesAPI!

    override func setUpWithError() throws {
        sut = PlacesAPI(network: MockNetwork())
    }

    override func tearDownWithError() throws {}

}
