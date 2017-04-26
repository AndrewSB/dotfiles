
import Foundation
let gitOutput = shell("git", "remote", "get-url", "--all", "origin")

switch gitOutput.1 {
case 0:
    guard let gitRemote = gitOutput.0, let range = gitRemote.range(of: "[(:)](.*).git", options: .regularExpression) else {
        fatalError("FATAL: there was no remote found in the gitUrl")
    }
    let gitUrl = gitRemote.substring(with: range).utf8
        .dropFirst() // remove leading `:`
        .dropLast(4) // remove trailing `.git`
    let branchRef = shell("command git symbolic-ref HEAD 2> /dev/null || command git rev-parse --short HEAD 2> /dev/null")

    let branch = branchRef.0!.components(separatedBy: "/").last!

    print(gitUrl)
    print(branch)

default:
    // not a git repo. Print directory instead
    let cwd = ProcessInfo.processInfo.environment["PWD"]!
    let homePath = ProcessInfo.processInfo.environment["HOME"]!
    let relitaveToHomeCwd = cwd.replacingOccurrences(of: homePath, with: "~")
    print(relitaveToHomeCwd)
}

