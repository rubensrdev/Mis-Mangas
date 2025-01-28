//
//  Theme.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

/// Enumeración que representa las diferentes temáticas disponibles para los mangas.
enum ThemeCases: String, CaseIterable, Identifiable, Codable {
	case gore = "Gore"
	case military = "Military"
	case mythology = "Mythology"
	case psychological = "Psychological"
	case historical = "Historical"
	case samurai = "Samurai"
	case romanticSubtext = "Romantic Subtext"
	case school = "School"
	case adultCast = "Adult Cast"
	case parody = "Parody"
	case superPower = "Super Power"
	case teamSports = "Team Sports"
	case delinquents = "Delinquents"
	case workplace = "Workplace"
	case survival = "Survival"
	case childcare = "Childcare"
	case iyashikei = "Iyashikei"
	case reincarnation = "Reincarnation"
	case showbiz = "Showbiz"
	case anthropomorphic = "Anthropomorphic"
	case lovePolygon = "Love Polygon"
	case music = "Music"
	case mecha = "Mecha"
	case combatSports = "Combat Sports"
	case isekai = "Isekai"
	case gagHumor = "Gag Humor"
	case crossdressing = "Crossdressing"
	case reverseHarem = "Reverse Harem"
	case martialArts = "Martial Arts"
	case visualArts = "Visual Arts"
	case harem = "Harem"
	case otakuCulture = "Otaku Culture"
	case timeTravel = "Time Travel"
	case videoGame = "Video Game"
	case strategyGame = "Strategy Game"
	case vampire = "Vampire"
	case mahouShoujo = "Mahou Shoujo"
	case highStakesGame = "High Stakes Game"
	case cgdct = "CGDCT"
	case organizedCrime = "Organized Crime"
	case detective = "Detective"
	case performingArts = "Performing Arts"
	case medical = "Medical"
	case space = "Space"
	case memoir = "Memoir"
	case villainess = "Villainess"
	case racing = "Racing"
	case pets = "Pets"
	case magicalSexShift = "Magical Sex Shift"
	case educational = "Educational"
	case idolsFemale = "Idols (Female)"
	case idolsMale = "Idols (Male)"
	
	var id: Self { self }
}
