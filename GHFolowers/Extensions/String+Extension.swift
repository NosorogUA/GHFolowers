//
//  String+Extension.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 17.12.2024.
//


import RegexBuilder

extension String {
    var isValidEmail: Bool {
        let emailFormat = Regex {
            OneOrMore {
                CharacterClass(
                    .anyOf("._%+-"),
                    ("A"..."Z"),
                    ("0"..."9"),
                    ("a"..."z")
                )
            }
            "@"
            OneOrMore {
                CharacterClass(
                    .anyOf("-"),
                    ("A"..."Z"),
                    ("a"..."z"),
                    ("0"..."9")
                )
            }
            "."
            Repeat(2...64) {
                CharacterClass(
                    ("A"..."Z"),
                    ("a"..."z")
                )
            }
        }
        
        return self.wholeMatch(of: emailFormat) != nil
    }
    
    var isNameValid: Bool {
        let text = self.filter({ $0 != " " && $0 != "\n" })
        return text.count >= 2 && text.count <= 30
    }
    
    var isPhoneValid: Bool {
        if self.count < 12 { return false }
        
        let regEx = Regex {
            Repeat(12...) {
                CharacterClass(
                    .anyOf("+"),
                    ("0"..."9")
                )
            }
        }
        
        return self.wholeMatch(of: regEx) != nil
    }
}
