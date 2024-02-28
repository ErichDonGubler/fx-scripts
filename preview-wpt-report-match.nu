def main [
	path_and_line: string,
] {
	let info = $path_and_line | parse --regex '(?P<filename>.*):(?P<line>\d+)' | first
	bat $info.filename | jq . - | bat - --file-name $info.filename --highlight-line ($info.line) --line-range $"($info.line):"
}
