//
//  RegionModel.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 5/29/24.
//

struct RegionModel {
    let regionName: String
    let regionNumber: Int
}

extension RegionModel {
    static func dummy() -> [RegionModel] {
        return [
            RegionModel(regionName: "서울", regionNumber: 11),
            RegionModel(regionName: "부산", regionNumber: 12),
            RegionModel(regionName: "경기", regionNumber: 13),
            RegionModel(regionName: "강원", regionNumber: 14),
            RegionModel(regionName: "충북", regionNumber: 15),
            RegionModel(regionName: "서울", regionNumber: 16),
            RegionModel(regionName: "충남", regionNumber: 17),
            RegionModel(regionName: "전북", regionNumber: 18),
            RegionModel(regionName: "전남", regionNumber: 19),
            RegionModel(regionName: "경북", regionNumber: 20),
            RegionModel(regionName: "경남", regionNumber: 21),
            RegionModel(regionName: "제주", regionNumber: 22),
            RegionModel(regionName: "대구", regionNumber: 23),
            RegionModel(regionName: "인천", regionNumber: 24),
            RegionModel(regionName: "광주", regionNumber: 25),
            RegionModel(regionName: "대전", regionNumber: 26),
            RegionModel(regionName: "울산", regionNumber: 28),
        ]
    }
    
    static func fetchDummyForText() -> [String] {
        var data = [String]()
        let dummyData = dummy()
        
        for i in dummyData {
            data.append("\(i.regionName)(\(i.regionNumber))")
        }
        
        return data
    }
}
