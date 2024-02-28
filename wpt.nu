use std log info

export def search-reports [
	test_path: string,
	--in-dir: directory,
] {
	fd 'wptreport.json$' $in_dir | lines | par-each {|report|
		info $"parsing ($report)"
		let report = bat $report | from json
		let tests = $report | get results | where {|test|
			($test.test =~ $test_path)
		}
		$tests
	} | flatten | filter {||
		not ($in | is-empty)
	} | to json | jq . - | bat --language json

# rg --files-with-matches $search_term $in_dir | lines | path relative-to ("." | path expand) | par-each {|file|
#	bat $file | jq . | rg $search_term - --with-filename --no-heading --line-number --color never | rg '.*?:(\d+):.*' --replace $"($file):$1"
# } | str join | fzf --preview "nu preview-wpt-report-match.nu {}"
}
