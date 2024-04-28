//
//  AwardsType.swift
//  ritus
//
//  Created by Mariia Mohylska on 4/26/24.
//

import Foundation

enum AwardsType: String, Codable {
    case oneWeekStrike = "One week strike of",
         twoWeeksStrike = "Two week strike of",
         oneMonthStrike = "One month strike of",
         twoMonthStrike = "Two month strike of",
         threeMonthStrike = "Three month strike of",
         fourMonthStrike = "four month",
         fiveMonthStrike = "five month",
         sixMonthStrike = "Six moth strike of",
         sevenMonthStrike = "seven month",
         eightMonthStrike = "eight month",
         nineMonthStrike = "nine month",
         tenMonthStrike = "ten month",
         elevenMonthStrike = "eleven month",
         oneYearStrike = "One year strike of",
         fiftyPercentOfMonth = "50% is competed within one month of",
         seventyFivePersentOfMonth = "75% is competed within one month of",
         nintyPercentOfMonth = "90% is competed within one month of",
         threeHabitsMoreThanSeventyFive = "3 or more habits is completed more than 75% within one month: ",
         fiveHabitsMoreThanFifty = "5 or more habits is completed more than 50% within one month: "
}
