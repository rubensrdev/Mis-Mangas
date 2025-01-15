//
//  PreviewData.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 27/12/24.
//

import Foundation

extension Manga {
	static let preview = Manga(id: 13,
							   title: "One Piece",
							   titleJapanese: "One Piece",
							   titleEnglish: "One Piece",
							   background: "One Piece is the highest selling manga series of all time, with over 500 million copies in circulation as of 2022. Volume 67 of the series currently holds the record for highest first print run of any manga (including books) of all time in Japan, with 4.05 million in 2012. The series was a finalist for the Tezuka Osamu Cultural Prize three times in a row from 2000 to 2002. In 2012, it won the 41st Japan Cartoonists Association Award Grand Prize, alongside Kimuchi Yokoyama's Neko Darake. VIZ Media has published One Piece in English under the Shonen Jump imprint since January 2, 2003 and in 3-in-1 omnibus editions since December 1, 2009. VIZ Media released three boxed sets for the manga; the first including the first 23 volumes released on November 5, 2013, the second including volumes 24-46 released on November 4, 2014, and the third including volumes 47-70 released on October 4, 2016. The series has also been published in numerous amounts of languages worldwide including; Korean, Malay, Indonesian, Chinese, Thai, Vietnamese, German, French, Italian, Spanish, Portuguese, Swedish, Danish, Norwegian, Finnish, Polish, Turkish, and Russian.",
							   mainPicture: "https://cdn.myanimelist.net/images/manga/2/253146l.jpg",
							   sypnosis: "Gol D. Roger, a man referred to as the \"King of the Pirates,\" is set to be executed by the World Government. But just before his demise, he confirms the existence of a great treasure, One Piece, located somewhere within the vast ocean known as the Grand Line. Announcing that One Piece can be claimed by anyone worthy enough to reach it, the King of the Pirates is executed and the Great Age of Pirates begins.\n\nTwenty-two years later, a young man by the name of Monkey D. Luffy is ready to embark on his own adventure, searching for One Piece and striving to become the new King of the Pirates. Armed with just a straw hat, a small boat, and an elastic body, he sets out on a fantastic journey to gather his own crew and a worthy ship that will take them across the Grand Line to claim the greatest status on the high seas.\n\n[Written by MAL Rewrite]",
							   startDate: "1997-07-22T00:00:00Z",
							   endDate: nil,
							   score: 9.22,
							   status: "currently_publishing",
							   chapters: nil,
							   volumes: 98,
							   url: "https://myanimelist.net/manga/13/One_Piece",
							   authors: [Author(
								id: UUID(uuidString: "25617399-543F-4220-9114-3A4181AF8D80")!,
								role: "Story & Art",
								firstName: "Eiichiro",
								lastName: "Oda")],
							   genres: [
								Genre(id: UUID(uuidString: "72C8E862-334F-4F00-B8EC-E1E4125BB7CD")!, genre: "Action"),
								Genre(id: UUID(uuidString: "BE70E289-D414-46A9-8F15-928EAFBC5A32")!, genre: "Adventure"),
								Genre(id: UUID(uuidString: "B3E8D4B2-7EE4-49CD-8DB0-9897619B3F62")!, genre: "Fantasy")],
							   themes: [],
							   demographics: [Demographic(id: UUID(uuidString: "5E05BBF1-A72E-4231-9487-71CFE508F9F9")!, demographic: "Shounen"),
											  Demographic(id: UUID(uuidString: "5E05BBF1-A72E-4231-9487-71CFE508F9F9")!, demographic: "Adventure")])
}

extension MangaInCollection {
	static let preview = MangaInCollection(id: 13, manga: .preview, volumesOwned: 37, readingVolume: 11)
}

let previewDemographics: [String] = [
	"Seinen",
	"Shounen",
	"Shoujo",
	"Josei",
	"Kids"
]

let previewGenres: [String] = [
	"Action",
	"Adventure",
	"Comedy",
	"Drama",
	"Fantasy",
	"Historical",
	"Horror",
	"SciFi",
	"Romance"
]

let previewThemes: [String] = [
	"Supernatural",
	"Magic",
	"Superhero",
	"Mystery",
	"SliceOfLife",
	"Romantic",
]
