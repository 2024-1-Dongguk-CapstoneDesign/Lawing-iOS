//
//  RegionModel.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 5/29/24.
//

struct RegionModel {
    let regionName: String
    let regionNumber: String
}

extension RegionModel {
    static func dummy() -> [RegionModel] {
        return [
            RegionModel(regionName: "서울특별시경찰청", regionNumber: "11"),
            RegionModel(regionName: "부산광역시경찰청", regionNumber: "12"),
            RegionModel(regionName: "경기도남부경찰청", regionNumber: "13"),
            RegionModel(regionName: "강원특별자치도경찰청", regionNumber: "14"),
            RegionModel(regionName: "충청북도경찰청", regionNumber: "15"),
            RegionModel(regionName: "충청남도경찰청", regionNumber: "16"),
            RegionModel(regionName: "전북특별자치도경찰청", regionNumber: "17"),
            RegionModel(regionName: "전라남도경찰청", regionNumber: "18"),
            RegionModel(regionName: "경상북도경찰청", regionNumber: "19"),
            RegionModel(regionName: "경상남도경찰청", regionNumber: "20"),
            RegionModel(regionName: "제주특별자치도경찰청", regionNumber: "21"),
            RegionModel(regionName: "대구광역시경찰청", regionNumber: "22"),
            RegionModel(regionName: "인천광역시경찰청", regionNumber: "23"),
            RegionModel(regionName: "광주광역시경찰청", regionNumber: "24"),
            RegionModel(regionName: "대전광역시경찰청", regionNumber: "25"),
            RegionModel(regionName: "울산광역시경찰청", regionNumber: "26"),
            RegionModel(regionName: "경기도북부경찰청", regionNumber: "28"),
        ]
    }
    
    static func fetchDummyForText() -> [String] {
        var data = [String]()
        let dummyData = dummy()
        
        for i in dummyData {
            data.append("\(i.regionNumber)(\(i.regionName))")
        }
        
        return data
    }
}
