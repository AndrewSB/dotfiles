import Foundation

func gitInfo(gitRemoteOutput: String) -> String {
    guard let range = gitRemoteOutput.range(of: "[(:)](.*).git", options: .regularExpression) else {
        fatalError("FATAL: incorrect pattern in git remote url")
    }

    let gitUrl = gitRemoteOutput.substring(with: range).utf8
        .dropFirst() // remove leading `:`
        .dropLast(4) // remove trailing `.git`

    var branchNameOrCommitHash: String
    switch shell("git", "symbolic-ref", "HEAD") {
    case (let branchNameRef, 0):
        branchNameOrCommitHash = branchNameRef!.components(separatedBy: "/").last!
    default:
        branchNameOrCommitHash = shell("git", "rev-parse", "--short", "HEAD").0!
    }

    return "\(gitUrl):\(branchNameOrCommitHash)"
}

func path() -> String {
    let cwd = ProcessInfo.processInfo.environment["PWD"]!
    let homePath = ProcessInfo.processInfo.environment["HOME"]!
    let relitaveToHomeCwd = cwd.replacingOccurrences(of: homePath, with: "~")

    return relitaveToHomeCwd
}
