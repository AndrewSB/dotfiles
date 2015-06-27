import Cocoa

func main() {
    welcome()
    checkXCodeInstallation()
    
    println("escalting userPrivellages")
    NSAppleScript(source: "do shell script \"sudo whatever\" with administrator privileges")!.executeAndReturnError(nil)
    println("escalted")
}

func welcome() {
    println("Yo yo")
    println("Welcome to the superflous swift dotfile installtion script that Andrew wrote a day of age")
    println("We're going to start out by making sure Xcode is installed, then install a bunch of command line tools, applications, and finally setup your dotfiles.")
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
    }
}

func installCommandLineTools() {
    let homeBrewInstallScript = shell("curl", "-fsSL", "https://raw.githubusercontent.com/Homebrew/install/master/install")
    let lol = shell("ruby", "-e", homeBrewInstallScript)
}

// LOW LEVEL
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