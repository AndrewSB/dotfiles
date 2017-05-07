import Foundation

@discardableResult
func shell(_ args: String...) -> (String?, Int32) {
	let task = Process()
	task.launchPath = "/usr/bin/env"
	task.arguments = args

	let pipe = Pipe()
	task.standardOutput = pipe
	task.standardError = pipe
	task.launch()
	let data = pipe.fileHandleForReading.readDataToEndOfFile()
	let output = String(data: data, encoding: .utf8)?.replacingOccurrences(of: "\n", with: "")
	task.waitUntilExit()
	return (output, task.terminationStatus)
}
