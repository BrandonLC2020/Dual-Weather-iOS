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
    .frigid: [true: "thermometer.snowflake", false: "thermometer.snowflake"],
    .hail: [true: "cloud.hail.fill", false: "cloud.hail.fill"],
    .hot: [true: "thermometer.sun.fill", false: "thermometer.sun.fill"],
    .flurries: [true: "snowflake", false: "snowflake"],
    .sleet: [true: "cloud.sleet.fill", false: "cloud.sleet.fill"],
    .snow: [true: "snowflake", false: "snowflake"],
    .sunFlurries: [true: "sun.snow.fill", false: "sun.snow.fill"],
    .wintryMix: [true: "snowflake", false: "snowflake"],
    .blizzard: [true: "cloud.snow.fill", false: "cloud.snow.fill"],
    .blowingSnow: [true: "wind.snow", false: "wind.snow"],
    .freezingDrizzle: [true: "cloud.drizzle.fill", false: "cloud.drizzle.fill"],
    .freezingRain: [true: "cloud.rain.fill", false: "cloud.rain.fill"],
    .heavySnow: [true: "cloud.snow.fill", false: "cloud.snow.fill"],
    .hurricane: [true: "hurricane", false: "hurricane"],
    .tropicalStorm: [true: "tropicalstorm", false: "tropicalstorm"]
]
