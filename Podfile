# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'NewAppProject' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for NewAppProject

  pod 'FMDB'
  pod 'SideMenu', '~> 6.4.8'
  pod 'Cosmos', '~> 23.0'
  pod 'IQKeyboardManagerSwift'


  target 'NewAppProjectTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'NewAppProjectUITests' do
    # Pods for testing
#   pod 'IQKeyboardManagerSwift'

  end

end
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end
end 
