//
//  Video.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/21/20.
//

import Foundation

class Videogroups {
    var groups = [Videogroup]()
    init() {
        groups.append(Videogroup(name: "Covid", keyword: "Covid"))
        groups.append(Videogroup(name: "Latest", keyword: "Latest"))
        groups.append(Videogroup(name: "Koronavirus", keyword: "Koronavirus"))
    }
}
struct Videogroup {
    var name: String
    var keyword: String
    var url: String {
        let resourceUrl = "https://youtube.googleapis.com/youtube/v3/"
        let requestType = "search?"
        let part = "part=snippet&q=\(keyword)&type=video&videoCaption=closedCaption&maxResults=20"
        return "\(resourceUrl)\(requestType)\(part)&key=\(ytAPIkey[3])"
    }
    var list = VideosList()
}
struct VideosList: Codable {
    var kind: String = ""
    var etag: String = ""
    var nextPageToken: String = ""
    var regionCode: String = ""
    var pageInfo : PageInfo?
    var items = [Video]()
}
struct PageInfo : Codable {
    var totalResults: Int
    var resultsPerPage: Int
}
struct Video: Codable  {
    var kind: String
    var etag: String
    var id: Id
    var snippet: Snippet
}
struct Id: Codable  {
    var kind: String
    var videoId: String
}
struct Snippet: Codable {
    var publishedAt: String
    var channelId: String
    var title: String
    var description: String
    var thumbnails: Thumbnails
    var channelTitle: String
    var liveBroadcastContent: String
    var publishTime: String
}
struct Thumbnails: Codable {

    var medium: Image
    var high: Image
}
struct Image: Codable {
    var url: String
    var width: Int
    var height: Int
}
// Request example
// https://youtube.googleapis.com/youtube/v3/search?part=snippet&q=covid&type=video&videoCaption=closedCaption&maxResults=20&key=AIzaSyCoCgCVy9txmg2ZrMgTV_S18O79-Tx8mtk

/* JSON Example.:
 
  "kind": "youtube#searchListResponse",
  "etag": "cdFHvTCEORhQvNSohgFG4UUPups",
  "nextPageToken": "CBQQAA",
  "regionCode": "BY",
  "pageInfo": {
    "totalResults": 1000000,
    "resultsPerPage": 20
  },
 
  "items": [
    {
      "kind": "youtube#searchResult",
      "etag": "XSBIg40U1Og5RActb7pDHqfFVHQ",
      "id": {
        "kind": "youtube#video",
        "videoId": "BSudTSzeNg0"
      },
      "snippet": {
        "publishedAt": "2020-11-20T22:08:20Z",
        "channelId": "UCZYTClx2T1of7BRZ86-8fow",
        "title": "What&#39;s the Deal with Pfizer&#39;s COVID-19 Vaccine? | SciShow News",
        "description": "SciShow is supported by Brilliant.org. Go to https://Brilliant.org/SciShow to get 20% off of an annual Premium subscription. Multiple companies and organizations ...",
        "thumbnails": {
          "default": {
            "url": "https://i.ytimg.com/vi/BSudTSzeNg0/default.jpg",
            "width": 120,
            "height": 90
          },
          "medium": {
            "url": "https://i.ytimg.com/vi/BSudTSzeNg0/mqdefault.jpg",
            "width": 320,
            "height": 180
          },
          "high": {
            "url": "https://i.ytimg.com/vi/BSudTSzeNg0/hqdefault.jpg",
            "width": 480,
            "height": 360
          }
        },
        "channelTitle": "SciShow",
        "liveBroadcastContent": "none",
        "publishTime": "2020-11-20T22:08:20Z"
      }
    },
}
 ...
*/
