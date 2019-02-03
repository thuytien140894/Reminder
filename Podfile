# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'Reminder' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Reminder
  pod 'Firebase/Core'
  pod 'Firebase/Firestore'

  target 'ReminderTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ReminderUITests' do
    inherit! :complete
    # Pods for testing
  end

end

# Exclude Pods from code coverage
# https://stackoverflow.com/questions/39674057/how-to-exclude-pods-from-code-coverage-in-xcode
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |configuration|
      configuration.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
      configuration.build_settings['SWIFT_EXEC'] = '$(SRCROOT)/SWIFT_EXEC-no-coverage'
    end
  end
end