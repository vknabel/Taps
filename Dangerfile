# Sometimes it's a README fix, or something like that - which isn't relevant for
# including in a project's CHANGELOG for example
not_declared_trivial = !github.pr_title.include?("#trivial")
has_app_changes = !git.modified_files.grep(/Sources/).empty?
has_readme_test_changes = !git.modified_files.grep(/Tests\/TapsTests\/ReadmeExamples.swift/).empty?

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

# Warn when there is a big PR
warn("Big PR") if git.lines_of_code > 500

# Don't let testing shortcuts get into master by accident
# fail("fdescribe left in tests") if `grep -r fdescribe Tests/ `.length > 1
# fail("fit left in tests") if `grep -r fit Tests/ `.length > 1
fail("runMain left in tests") if `grep -r runMain Tests/ `.length > 1

# Changelog entries are required for changes to library files.
no_changelog_entry = !git.modified_files.include?("CHANGELOG.md")
if has_app_changes && no_changelog_entry && not_declared_trivial
  fail("Any changes to library code need a summary in the Changelog.")
end

# README.md should be updated if it's tests has been changed.
no_readme_change = !git.modified_files.include?("README.md")
if no_readme_change && has_readme_test_changes
  fail("Any changes to the readme tests need to be applied to README.md.")
end
