import UIKit

final class ResultDataSource: NSObject, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell",
                                                       for: indexPath) as? ResultTableViewCell else {
            fatalError("Table view cell is not ResultTableViewCell")
        }

        return cell
    }
}
