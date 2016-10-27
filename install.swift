#!/usr/bin/swift

import Foundation

// LOW LEVEL
// I need a class so I can accept selectors to pipe my standardOutput to
class LowLevel: NSObject {
    static var sharedInstance: LowLevel {
        struct Static {
            static let instance = LowLevel()
        }
        return Static.instance
    }

    func shell(_ args: String...) -> String {
        let process = Process()
        let pipe = Pipe()

        process.launchPath = "/usr/bin/env"
        process.standardOutput = pipe
        process.standardError = pipe
        process.arguments = args

        process.launch()

        return String(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8)!
    }

    func promptUserInput(message: String) -> String {
        print("\(message)")
        let fh = FileHandle.standardInput

        return String(data: fh.availableData, encoding: .utf8)!
    }

    func promptUser(prompt: String, expects: String = "👍", yes: (() -> ())? = nil, no: (() -> ())? = nil) {
        let userStartResponse = promptUserInput(message: prompt)

        switch userStartResponse.range(of: expects) != nil {
        case true:  yes?()
        case false: no?()
        }
    }
}

/*
// Here's what you're going to be installing
*/
let homebrewRemoteCodeLocation =    "https://raw.githubusercontent.com/Homebrew/install/master/install"
let ohMyZshRemoteCodeLocation =     "https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh"
enum HomebrewTool: String {
    case carthage
    case hub
    case node

    static let allValues = [carthage, hub, node]
}
enum CaskApp: String {
    case googleChrome   = "google-chrome"
    case skalacolor     = "colorpicker-skalacolor"
    case sketch

    static let allValues = [googleChrome, skalacolor, sketch]
}
enum Gem: String {
    case synx
    case fastlane
    
    static let allValues = [synx, fastlane]
}


func welcome() {
    print("Yo yo")
    print("Welcome to the superflous swift dotfile installtion script that Andrew wrote \nsome day of age")
    print("We're going to start out by making sure Xcode is installed, then install \nsome command line tools, and applications, and then finally setup\nyour dotfiles.\n")
    
    LowLevel.sharedInstance.promptUser(prompt: "Sound good? (👍 /👎 )", no: {
        print("Aight. We won't install")
        exit(0)
    })
}

func checkXCodeInstallation() {
    let xcodeVersionOrNil = LowLevel.sharedInstance.shell("xcode-select", "-v")
    if xcodeVersionOrNil.range(of: "No such file or directory") != nil {
        print("I understand you think you're boss. But you kinda sorta maybe need Xcode.")
        print("On the other hand, you cloned this without getting git on your machine. Quite boss")
        print("Go hit up the app store and get Xcode. You're going to need it")
        exit(0)
    } else {
        print("Looks like you have Xcode installed, thats good!")
    }
}

func installCommandLineTools() {
    
    print("Installing Homebrew")
    let homeBrewInstallScript = LowLevel.sharedInstance.shell("curl", "-fsSL", homebrewRemoteCodeLocation)
    LowLevel.sharedInstance.shell("ruby", "-e", homeBrewInstallScript)
    
    print("\nInstalling oh my zsh")
    let ohMyZshInstallScript = LowLevel.sharedInstance.shell("curl", "-fsSL", ohMyZshRemoteCodeLocation)
    LowLevel.sharedInstance.shell("sh", "-c", ohMyZshInstallScript)
    
    
    print("\nInstalling the homebrew tools")
    HomebrewTool.allValues.forEach {
        _ = LowLevel.sharedInstance.shell("brew", "install", $0.rawValue)
    }
    CaskApp.allValues.forEach {
        _ = LowLevel.sharedInstance.shell("brew", "cask", "install", $0.rawValue)
    }
    print("\nDone installing all the homebrew tools")
    
    print("\nInstalling gem tools")
    Gem.allValues.forEach {
        _ = LowLevel.sharedInstance.shell("sudo", "gem", "install", $0.rawValue)
    }
    print("\nDone installing the gem tools")
    
}

func installDotfiles() {
    print("\n Going to be overwriting your zshrc and gitconfig.")
    LowLevel.sharedInstance.promptUser(prompt: "Sound good? (👍 /👎 )", yes: {
        LowLevel.sharedInstance.shell("cp", ".zshrc", "~/.zshrc")
        LowLevel.sharedInstance.shell("cp", ".gitconfig", "~/.gitconfig")
    })
}

func main() {
    welcome()
    checkXCodeInstallation()
    installCommandLineTools()
    installDotfiles()
}
main()
