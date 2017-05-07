let gitOutput = shell("git", "remote", "get-url", "--all", "origin")

switch gitOutput.1 {
case 0:
    guard let gitRemote = gitOutput.0 else { 
        fatalError("FATAL: there was no remote found in the gitUrl")
    }

    print(gitInfo(gitRemoteOutput: gitRemote))

default:
    // not a git repo. Print directory instead
    print(path())
}
