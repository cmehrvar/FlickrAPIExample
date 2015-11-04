
import UIKit

class Flick_Model: NSObject {
    
    private var photoImageView: UIImageView!
    private var photoTitle: UILabel!
    // variable for all images
    var myArrayOfPhotos = [NSData]()
    var myArrayOfTitles = [String]()
    
    init(photoView: UIImageView, myTitle: UILabel) {
        super.init()
        photoImageView = photoView
        photoTitle = myTitle
        self.getImageFromFlickr()
        
    }
    
    func getImageFromFlickr() {
        
        // Step one: create a session
        let session = NSURLSession.sharedSession()
        
        // Step two: create a URL String
        let urlString = BASE_URL + escapedParameters(METHOD_ARGUMENTS)
        let url = NSURL(string: urlString)!
        
        // Step three: create a URL Request
        let request = NSURLRequest(URL: url)
        print(request)
        // Initialize task for getting data
        let task = session.dataTaskWithRequest(request) { (data, response, downloadError) -> Void in
            
        // check if we are successful
            if let error = downloadError {
                print("could not complete request \(error)")
            } else {
                // we are successful
                var parseError: NSError? = nil
                let parsedResult: AnyObject!
                do {
                    parsedResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                    print(parsedResult)
                } catch let error as NSError {
                    parseError = error
                    print("\(parseError)")
                    parsedResult = nil
                } catch {
                    fatalError()
                }
                
                if let photosDictionary = parsedResult.valueForKey("photos") as? NSDictionary {
                    if let photoArray = photosDictionary.valueForKey("photo") as? [[String: AnyObject]] {
                     
                        // grab a single image
                        let randomPhotoIndex = Int(arc4random_uniform(UInt32(photoArray.count)))
                        let photoDictionary = photoArray[randomPhotoIndex] as [String: AnyObject]
                        
                        // grab the image url and title
                        let photoTitle = photoDictionary["title"] as? String
                        let imageUrlString = photoDictionary["url_m"] as? String
                        let imageURL = NSURL(string: imageUrlString!)
                        // if an image exists at the url se the image and title
                        if let imageData = NSData(contentsOfURL: imageURL!) {
                            // async  // submits a block a asynchronous execution on a dispatch queue
                            
                        
                        print("Count is \(parsedResult.count)")
                            
                     //       for var i=0; i<=parsedResult.count; i++ {
                                
                            self.myArrayOfPhotos.append(imageData)
                            self.myArrayOfTitles.append(photoTitle!)
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                // set the image and the title for the view
                                self.photoImageView.image = UIImage(data: imageData)
                                self.photoImageView.layer.cornerRadius = self.photoImageView.frame.size.width / 2
                                
                                self.photoImageView.clipsToBounds = true
                                self.photoImageView.layer.borderWidth = 5
                                self.photoImageView.layer.borderColor = UIColor.whiteColor().CGColor
                                self.photoTitle.text = photoTitle
                                
                            })
                     //   }
                        } else {
                            print("Image does not exist")
                        }
                    } else {
                        print("can't find key photo")
                    }
                }else {
                        print("can't find key parsed result")
                    }
                }
            }
    
        task.resume()
    }
    
    // Helper function: Given a dictionary of parameters/
    // and convert a string for url
    func escapedParameters(parameters: [String: AnyObject]) -> String {
       
        var urlVars = [String]()
        
        for (key, value) in parameters {
            // make sure that it is a string
            let stringValue = "\(value)"
            _ = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            
            _ = stringValue.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            // append it
            urlVars += [key + "=" + "\(value)"]
            
        }

        return (!urlVars.isEmpty ? "?" : "") + urlVars.joinWithSeparator("&")
    }
}
