guard_options = {
  cmd: "rspec",
  all_after_pass: false,
  all_on_start: false,
  failed_mode: :focus,
}

guard :rspec, guard_options do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end
