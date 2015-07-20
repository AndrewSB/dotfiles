#!/usr/bin/env xcrun swift

func main() {
    welcome()
    checkXCodeInstallation()
    installCommandLineTools()
}


/*
// Here's what you're going to be installing
*/
enum CommandLineTool {
    case Homebrew(tool: HomebrewTool)
    case Cask(app: CaskApp)
}
enum HomebrewTool: String {
    case Carthage =     "carthage"
    case GitHub =       "hub"
    case Node =         "node"
    case Watchman =     "watchman"
    case Cask =         "caskroom/cask/brew-cask"
    
    static let allValues = [Carthage, GitHub, Node, Watchman, Cask]
}
enum CaskApp: String {
    case GoogleChrome = "google-chrome"
    case Atom =         "atom"
    case SkalaColor =   "colorpicker-skalacolor"
    case Fabric =       "fabric"
    case GitHub =       "github"
    case Hermes =       "hermes"
    case Sketch =       "sketch"
    case Spotify =      "spotify"
    case SublimeText =  "sublime-text"
    case Transmission = "transmission"
    
    static let allValues = [GoogleChrome, Atom, SkalaColor, Fabric, GitHub, Hermes, Sketch, Spotify,SublimeText, Transmission]
}
enum Gem: String {
    case CocoaPods =    "cocoapods"
    case Synx =         "synx"
    
    static let allValues = [CocoaPods, Synx]
}


func welcome() {
    println("Yo yo")
    println("Welcome to the superflous swift dotfile installtion script that Andrew wrote \nsome day of age")
    println("We're going to start out by making sure Xcode is installed, then install a \nbunch of command line tools, applications, and finally setup your dotfiles.\n")
    let userStartResponse = promptUserInput("Sound good? (👍 /👎 )")
    if userStartResponse.rangeOfString("👍 ") == nil {
        println("Aight. We won't install")
        exit(0)
    }
}

func checkXCodeInstallation() {
    let xcodeVersionOrNil = shell("xcode-select", "-v")
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
    let homeBrewInstallScript = shell("curl", "-fsSL", "https://raw.githubusercontent.com/Homebrew/install/master/install")

    for tool in HomebrewTool.allValues {
        shell("brew", "install", tool.rawValue)
    }
    println("installed all homebrew tools")
    
    for app in CaskApp.allValues {
        shell("brew", "cask", "install", app.rawValue)
    }
    println("installed all cask apps")
    
    for gem in Gem.allValues {
        shell("sudo", "gem", "install", gem.rawValue)
    }
}

func installDotfiles() {
    shell("cp", ".zshrc", "~/.zshrc")
    shell("cp", ".gitconfig", "~/.gitconfig")
}


// LOW LEVEL
import Cocoa

func shell(args: String...) -> String {
    let task = NSTask()
    let pipe = NSPipe()
    
    task.launchPath = "/usr/bin/env"
    task.standardOutput = pipe
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

main()