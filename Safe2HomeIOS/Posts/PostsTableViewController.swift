//
//  PostsTableViewController.swift
//  SnapchatProject
//
//  Created by Paige Plander on 3/9/17.
//  Copyright © 2017 org.iosdecal. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import MBProgressHUD
import FirebaseAuth

class PostsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    // Dictionary that maps IDs of images to the actual UIImage data
    var loadedImagesById: [String:UIImage] = [:]
    // below is the post array

    
    let currentUser = CurrentUser()

    var currentPost = Post(username: "dummyname", dateString: "dummystring", gender: "dummygender", major: "dummymajor")
    
    var posts_array: [Post] = []
//    var mactched_user = Post()
    
    /// Table view holding all posts from each thread
    
    @IBOutlet weak var Chat: UIButton!
    
    @IBAction func LogOut(_ sender: Any) {
        try! Auth.auth().signOut()
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let welcomeViewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "welcome")
        self.present(welcomeViewController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var RequestTableView: UITableView!
    
    //actually don't know if the textfield and and pressbutton should go here??

    @IBOutlet weak var CommentTextField: UITextField!
    
//    @IBAction func RequestPostButton(_ sender: UIButton) {
////        var _:String = CommentTextField.text ?? ""
////        addPost(username: (Auth.auth().currentUser?.displayName)!, comment: CommentTextField.text!)
//        //?? fill in the blank of current user
//        //?? observe
//
//        //get date again
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.A"
//       let dateString = dateFormatter.string(from: Date())
//
//        print(4)
//        currentPost = Post(username: currentUser.username, dateString: dateString, gender: currentUser.gender, major: currentUser.major)
//        print(5)
//        match(currentPost: currentPost)
////        RequestTableView.reloadData()
//        //addPost(client: currentPost)
//        print(6)
//
//    }

//    var comments         : [[String:Any]]!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        RequestTableView.delegate = self
        RequestTableView.dataSource = self
        
        // add the button that displays the selected post's image to this view
//        view.addSubview(postImageViewButton)
        getPosts() { (posts) in
            if let posts = posts {
                self.posts_array = posts
            }
        }
        
        

    }

    // Remember that this method will be called everytime this view appears.
    override func viewWillAppear(_ animated: Bool) {
        // Reload the tablebview.
        RequestTableView.reloadData()
        // Update the data from Firebase
        updateData()
    }
    
    
    /*
     This function uses the 'getPosts' function to retrieve all of the posts in the database. We pass in the currentUser property declared above so that we know if the posts have been read or not.
     Using the posts variable that is returned, we are doing the following:
     - First clearing the current dictionary of posts (in case we're reloading this feed again). We are doing this by calling the 'clearThreads' function.
     - For each post in the array:
     - We are adding the post to the thread using the 'addPostToThread' function
     - Using the postImagePath property of the post, we are retrieving the image data from the storage module (there is a function in ImageFeed.swift that does this for us already, implemented by you. *Thanks!*).
     - We are creating a UIImage from the data and adding a new element to the 'loadedImagesById' variable using the image and post ID.
     - After iterating through all the posts, we are reloading the tableview.
     
     */
    func updateData() {
        getPosts() { (posts) in
            if let posts = posts {
                self.RequestTableView.reloadData()
                
            }
        }
    }

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pcell = RequestTableView.dequeueReusableCell(withIdentifier: "RequestPostCell", for: indexPath) as! PostsTableViewCell
        // can't find comment
        //pcell.commentmessage.text = comments[indexPath.row]["message"] as! String
        
//        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PostsTableViewController.runTimedCode), userInfo: nil, repeats: true)
        getPosts() { (matches) in
            if let matches = matches {
                print(2)
                //pcell.MatcherName.text = posts[0].username
                self.RequestTableView.reloadData()
            }
        }
        return pcell
    }
    
    
//    @objc func runTimedCode(){
//        self.tableView.reloadData()
//    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // not sure what to display yet??
        return 1
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    }
    
    
    func match(currentPost: Post, posts_array:[Post] ) -> Void {
        // first check if there are some posts
        if posts_array.count != 0 {
            print("count:")
            print(posts_array.count)
            for potential in posts_array {
                // if match, the algorithm will be more complicated later
                if (potential.username == "Debbie1") {
                    addMatch(client1: currentPost, client2: potential)
                    print("+++++++----------------------------------------------")
                    print(currentPost.username)
                
                    deletePost(username: currentPost.username)
                
                    print("++++++++++++++++++++++++++++++++++++++++++++++++++++++=")
                    return
                }
                print(8)
            }
        }
        print(7)
        addPost(client: currentPost)
        print("post added")
    }
    
    
    
    
}
