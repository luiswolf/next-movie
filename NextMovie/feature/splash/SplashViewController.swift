//
//  SplashViewController.swift
//  NextMovie
//
//  Created by Luís Wolf on 24/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let service = MovieService()
        service.getList(atPage: 1) { response in
            if response.success, let movieList = response.data?.movies {
                for movie in movieList {
                    print(movie.title)
                }
            }
        }
        service.getDetail(withId: 360920) { response in
            if response.success, let movie = response.data {
                print(movie.title)
            }
        }
        service.getGenres { response in
            if response.success, let genreList = response.data?.genres {
                for genre in genreList {
                    print(genre.name)
                }
            }
        }
        service.search(for: "Reprisa", withPage: 1) { response in
            if response.success, let movieList = response.data?.movies {
                for movie in movieList {
                    print(movie.title)
                    print(movie.overview)
                }
            }
        }
        
//        print(ApiHelper.get(endpoint: .movieList, withPage: 1))
//        print(ApiHelper.get(endpoint: .movieDetail))
//        print(ApiHelper.get(endpoint: .movieGenreList))
//        print(ApiHelper.get(endpoint: .movieSearch, withPage: 1))
//        print(ApiHelper.getPosterPath())
//        print(ApiHelper.getBackdropPath())
//        print("LOADING CONTENT")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            print("REDIRECTING")
//            AppDelegate.shared.rootViewController.switchToMovie()
//        }
        
    }


}

