//
//  WeatherConditionsDictionary.swift
//  Dual Weather iOS
//
//  Created by Brandon Lamer-Connolly on 1/26/25.
//

import Foundation
import WeatherKit

var WeatherConditionsDictionary : [WeatherCondition: [Bool : String]] = [ // Bool true = isDaylight , false = !isDaylight
    .blowingDust: [true: "sun.dust.fill", false: "moon.dust.fill"],
    .clear: [true: "sun.max.fill", false: "moon.stars.fill"],
    .cloudy: [true: "cloud.fill", false: "cloud.fill"],
    .foggy: [true: "cloud.fog.fill", false: "cloud.fog.fill"],
    .haze: [true: "sun.haze.fill", false: "moon.haze.fill"],
    .mostlyClear: [true: "sun.max.fill", false: "moon.stars.fill"],
    .mostlyCloudy: [true: "cloud.fill", false: "cloud.fill"],
    .partlyCloudy: [true: "cloud.sun.fill", false: "cloud.moon.fill"],
    .smoky: [true: "smoke.fill", false: "smoke.fill"],
    .breezy: [true: "wind", false: "wind"],
    .windy: [true: "wind", false: "wind"],
    .drizzle: [true: "cloud.drizzle.fill", false: "cloud.drizzle.fill"],
    .heavyRain: [true: "cloud.heavyrain.fill", false: "cloud.heavyrain.fill"],
    .isolatedThunderstorms: [true: "cloud.sun.bolt.fill", false: "cloud.moon.bolt.fill"],
    .rain: [true: "cloud.rain.fill", false: "cloud.rain.fill"],
    .sunShowers: [true: "sun.rain.fill", false: "moon.rain.fill"],
    .scatteredThunderstorms: [true: "cloud.sun.bolt.fill", false: "cloud.moon.bolt.fill"],
    .strongStorms: [true: "cloud.bolt.rain.fill", false: "cloud.bolt.rain.fill"],
    .thunderstorms: [true: "cloud.bolt.fill", false: "cloud.bolt.fill"],
    .frigid: [true: "", false: ""],
    .hail: [true: "", false: ""],
    .hot: [true: "", false: ""],
    .flurries: [true: "", false: ""],
    .sleet: [true: "", false: ""],
    .snow: [true: "", false: ""],
    .sunFlurries: [true: "", false: ""],
    .wintryMix: [true: "", false: ""],
    .blizzard: [true: "", false: ""],
    .blowingSnow: [true: "", false: ""],
    .freezingDrizzle: [true: "", false: ""],
    .freezingRain: [true: "", false: ""],
    .heavySnow: [true: "", false: ""],
    .hurricane: [true: "", false: ""],
    .tropicalStorm: [true: "", false: ""]
]
