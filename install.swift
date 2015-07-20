#!/usr/bin/env xcrun swift

func main() {
    welcome()
    checkXCodeInstallation()
    installCommandLineTools()
    installDotfiles()
}


/*
// Here's what you're going to be installing
*/
let homebrewRemoteCodeLocation =    "https://raw.githubusercontent.com/Homebrew/install/master/install"
let ohMyZshRemoteCodeLocation =     "https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh"
enum HomebrewTool: String {
    case Carthage =                 "carthage"
    case GitHub =                   "hub"
    case Node =                     "node"
    case Watchman =                 "watchman"
    case Cask =                     "caskroom/cask/brew-cask"
    
    static let allValues = [Carthage, GitHub, Node, Watchman, Cask]
}
enum CaskApp: String {
    case GoogleChrome =             "google-chrome"
    case Atom =                     "atom"
    case SkalaColor =               "colorpicker-skalacolor"
    case Fabric =                   "fabric"
    case GitHub =                   "github"
    case Hermes =                   "hermes"
    case Sketch =                   "sketch"
    case Spotify =                  "spotify"
    case SublimeText =              "sublime-text"
    case Transmission =             "transmission"
    
    static let allValues = [GoogleChrome, Atom, SkalaColor, Fabric, GitHub, Hermes, Sketch, Spotify,SublimeText, Transmission]
}
enum Gem: String {
    case CocoaPods =                "cocoapods"
    case Synx =                     "synx"
    
    static let allValues = [CocoaPods, Synx]
}


func welcome() {
    println("Yo yo")
    println("Welcome to the superflous swift dotfile installtion script that Andrew wrote \nsome day of age")
    println("We're going to start out by making sure Xcode is installed, then install a \nsome command line tools, and applications, and then finally setup\nyour dotfiles.\n")
    
    soundGoodPrompt(no: {
        println("Aight. We won't install")
        exit(0)
    })
}

func checkXCodeInstallation() {
    let xcodeVersionOrNil = LowLevel.sharedInstance.shell("xcode-select", "-v")
    if xcodeVersionOrNil.rangeOfString("No such file or directory") != nil {
        println("I understand you think you're boss. But you kinda sorta maybe need Xcode.")
        println("On the other hand, you cloned this without getting git on your machine. Quite boss")
        println("Go hit up the app store and get Xcode. You're going to need it")
        exit(0)
    } else {
        println("Looks like you have Xcode installed, thats good!")
    }
}

func installCommandLineTools() {
    
    println("Installing Homebrew")
    let homeBrewInstallScript = LowLevel.sharedInstance.shell("curl", "-fsSL", homebrewRemoteCodeLocation)
    LowLevel.sharedInstance.shell("ruby", "-e", homeBrewInstallScript)
    
    println("\nInstalling oh my zsh")
    let ohMyZshInstallScript = LowLevel.sharedInstance.shell("curl", "-fsSL", ohMyZshRemoteCodeLocation)
    LowLevel.sharedInstance.shell("sh", "-c", ohMyZshInstallScript)
    
    
    println("\nInstalling the homebrew tools")
    HomebrewTool.allValues.map {
        LowLevel.sharedInstance.shell("brew", "install", $0.rawValue)
    }
    CaskApp.allValues.map {
        LowLevel.sharedInstance.shell("brew", "cask", "install", $0.rawValue)
    }
    println("\nDone installing all the homebrew tools")
    
    println("\nInstalling gem tools")
    Gem.allValues.map {
        LowLevel.sharedInstance.shell("sudo", "gem", "install", $0.rawValue)
    }
    println("\nDone installing the gem tools")
    
}

func installDotfiles() {
    println("\n Going to be overwriting your zshrc and gitconfig.")
    soundGoodPrompt(yes: {
        LowLevel.sharedInstance.shell("cp", ".zshrc", "~/.zshrc")
        LowLevel.sharedInstance.shell("cp", ".gitconfig", "~/.gitconfig")
    })
}


// LOW LEVEL
// I need a class so I can accept selectors to pipe my standardOutput to
import Cocoa

class LowLevel: NSObject {
    static var sharedInstance: LowLevel {
        struct Static {
            static let instance = LowLevel()
        }
        return Static.instance
    }
    
    func shell(args: String...) -> String {
        let task = NSTask()
        let pipe = NSPipe()
        
        task.launchPath = "/usr/bin/env"
        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = args
        
        task.launch()
        
        return NSString(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: NSUTF8StringEncoding) as! String
    }
    
    func promptUserInput(message: String) -> String {
        println("\(message)")
        let fh = NSFileHandle.fileHandleWithStandardInput()
        
        var str = NSString(data: fh.availableData, encoding: NSUTF8StringEncoding)
        return str as! String
    }
    
    func soundGoodPrompt(yes: (Void)? = nil, no: (Void)?) {
        let userStartResponse = promptUserInput("Sound good? (👍 /👎 )")
        
        if userStartResponse.rangeOfString("👍 ") == nil    { if let no = no { no() }}
        else                                                { if let yes = yes { yes() } }
    }
}

main()