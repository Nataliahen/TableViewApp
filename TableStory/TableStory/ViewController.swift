//
//  ViewController.swift
//  TableStory
//
//  Created by Henriquez Perez, Natalia on 3/17/25.
//

import UIKit

import MapKit




//array objects of our data.
let data = [
    Item(name: "Barefoot Campus Outfitter", neighborhood: "Nelson Shopping Center", desc: "The perfect boutique to shop for campus and gameday outfits.", lat: 29.884793321648676, long: -97.94026864952323, imageName: "co"),
    Item(name: "KnD's Boutique", neighborhood: "Nelson Shopping Center", desc: "This shop offers a variety of items from trendy clothing to stylish accessories.", lat: 29.88490711255401, long: -97.94028852253646, imageName: "KnD"),
    Item(name: "Pitaya", neighborhood: "Nelson Shopping Center", desc: "The perfect boutique to keep up to date with the most modern and trendy styles.", lat: 29.884162418308634, long: -97.93987817281246, imageName: "pit"),
    Item(name: "Vagabond", neighborhood: "Nelson Shopping Center", desc: "This shop offers a varity of vintage clothing items, and is ideal for people who are into sustainable fashion. ", lat: 29.885118312218932,long: -97.94018037466118, imageName: "vag"),
    Item(name: "Daughter of the Wild", neighborhood: "Nelson Shopping Center", desc: "If you're into spirituality and hand-made items, then this is the shop for you.", lat: 29.88367699588592, long: -97.9413215881546, imageName: "DOW")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}




class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var theTable: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return data.count
   }


   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
       let item = data[indexPath.row]
       cell?.textLabel?.text = item.name
       
       //Add image references
                     let image = UIImage(named: item.imageName)
                     cell?.imageView?.image = image
                     cell?.imageView?.layer.cornerRadius = 10
                     cell?.imageView?.layer.borderWidth = 5
                     cell?.imageView?.layer.borderColor = UIColor.white.cgColor
       return cell!
   }
       
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let item = data[indexPath.row]
      performSegue(withIdentifier: "ShowDetailSegue", sender: item)
    
  }
    
    // add this function to original ViewController
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "ShowDetailSegue" {
               if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                   // Pass the selected item to the detail view controller
                   detailViewController.item = selectedItem
               }
           }
       }
       
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        theTable.delegate = self
        theTable.dataSource = self
        
        //add this code in viewDidLoad function in the original ViewController, below the self statements

            //set center, zoom level and region of the map
                let coordinate = CLLocationCoordinate2D(latitude: 29.884793321648676, longitude: -97.94026864952323)
                let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
                mapView.setRegion(region, animated: true)
                
             // loop through the items in the dataset and place them on the map
                 for item in data {
                    let annotation = MKPointAnnotation()
                    let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                    annotation.coordinate = eachCoordinate
                        annotation.title = item.name
                        mapView.addAnnotation(annotation)
                        }


    }


}

